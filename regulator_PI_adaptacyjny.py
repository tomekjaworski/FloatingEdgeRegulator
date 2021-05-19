import numpy as np
import cv2
import skimage.measure
import subprocess, time
import Faulhaber as FH
import datetime, os, math
from typing import List, Optional

class Object(object):
    pass

class PIDSettings:
    Kp: float = 0
    Ki: float = 0
    Kd: float = 0
    OutputOffset: float = 0

    def __init__(self, kp: float, ki: float, kd: float, offset: float):
        self.Kp = kp
        self.Ki = ki
        self.Kd = kd
        self.OutputOffset = offset


class MeasurementQueue:
    __marker_positions = None # type: List[Optional[float]]
    __carriage_positions = None # type: List[Optional[float]]
    __timestamps = None # type: List[Optional[float]]
    __capacity = 0
    __has_complete_data = False

    __pid_settings = None # type: PIDSettings

    def __init__(self):
        self.__capacity = 3
        self.__marker_positions = [None] * self.__capacity
        self.__carriage_positions = [None] * self.__capacity
        self.__timestamps = [None] * self.__capacity

    def AddMeasurement(self, newMarkerPosition: float, newCarriagePosition: float, newTimestamp: float):
        E = self.__capacity - 1
        if newMarkerPosition == self.__marker_positions[E]:
            self.__carriage_positions[E] = newCarriagePosition
            self.__timestamps[E] = newTimestamp
        else:
            for i in range(0, self.__capacity - 1):
                self.__marker_positions[i] = self.__marker_positions[i + 1]
                self.__carriage_positions[i] = self.__carriage_positions[i + 1]
                self.__timestamps[i] = self.__timestamps[i + 1]

            self.__marker_positions[E] = newMarkerPosition
            self.__carriage_positions[E] = newCarriagePosition
            self.__timestamps[E] = newTimestamp

        # Sprawdź, czy można wyznaczyć parametry regulatora
        self.__has_complete_data = all([x is not None for x in self.__marker_positions]) \
            and all([x is not None for x in self.__carriage_positions]) \
            and all([x is not None for x in self.__timestamps])

        if self.__has_complete_data:
            E = self.__capacity - 1

            # kroki czasowe regulacji/pomiarów w [mm]
            dt0 = np.double(self.__timestamps[E - 0] - self.__timestamps[E - 1]) # delta t dla ostatniego pomiaru
            dt1 = np.double(self.__timestamps[E - 1] - self.__timestamps[E - 2]) # delta t dla PRZEDostatniego pomiaru

            # prędkości markera w [mm/s]
            vmarker0 = (self.__marker_positions[E - 0] - self.__marker_positions[E - 1]) / dt0 # ostatnia prędkość markera
            vmarker1 = (self.__marker_positions[E - 1] - self.__marker_positions[E - 2]) / dt1 # PRZEDostatnia prędkośc markera

            # położenia markera (uproszczenie zapisu)
            s0 = self.__marker_positions[E - 0]
            s1 = self.__marker_positions[E - 1]
            s2 = self.__marker_positions[E - 2]

            # współczynniki modelu prędkosc_markera=A * pozycja_wózka + B
            A = (vmarker1 - vmarker0) / (s1 - s0)
            B = vmarker1 - A * s1

            kp = np.abs(1.0 / A / dt0)
            ki, kd = 0, 0
            offset = np.abs(B / A)

            pid_settings = PIDSettings(kp, ki, kd, offset)

    def HasCompleteData(self) -> bool:
        return self.__has_complete_data

    def GetPIDSettings(self) -> PIDSettings:
        return self.__pid_settings

##########################################
ident = Object()

ident.edge_counter = 0
ident.Tturn = 30 # Czas od ostatniego zobaczenia markera do awaryjnej zmiany kierunku
##########################################

can0 = FH.Initialize()
node_id = 5

print("Uruchamianie sterownika...")
FH.SendNodeStartCommand(can0, node_id)
time.sleep(1)

print("Restart stopnia mocy...")
FH.SendCommandToServomotor(can0, node_id, FH.Command.DI_DisableDrive, [])
time.sleep(1)
FH.SendCommandToServomotor(can0, node_id, FH.Command.EN_EnableDrive, [])
time.sleep(1)

FH.FindHomePosition(can0, 5)
print("POS:", FH.GetCurrentPosition(can0, 5))

FH.GoToPosition(can0, 5, 120_000) # taśma mnie więcej w miejscu
FH.WaitForTargetPosition(can0, 5)


##########################################



config = Object()
config.fps = 60             # prędkość akwizycji kamery
config.exposure_time = 100  # czas ekspozycji kamery w [us]
config.kernel_size = 10
config.Tdetection = 10 # wykrywaj znaczniki w obrazie nie częściej niż Tdetection sekund
config.marker_size_mm = 12 # szerokość markera w [mm] (stała maszynowa)

# %% Kalibrajca:
config.threshold_value = 60
config.blob_size_range = [2000, 7000]
config.marker_size_px = 67 # Szerokość markera w pikselach
#############################

pid_settings = PIDSettings(6000, 70, 0, 120_000)
pid_queue = MeasurementQueue()

pid = Object()
pid.set_point = 0
pid.error_current = 0 # uchyb aktualny [mm]
pid.error_previous = 0 # uchyb poprzedni [mm]
pid.time_delta = 0 # długośc okresu regulacji/obrotu taśmy [s]
pid.integral_accumulator = 0 # akumulator całki [mm]
pid.output_limit = [0, 400_000] # ogranicznik wyjścia
pid.output = 0
#############################

# set the ROI parameters
# left = 0
# width = 639 - left
# height = 479
# up_left = (0, left) # (y, x)
# bot_right = (up_left[0]+height, up_left[1]+width)

############################################################################
cap = cv2.VideoCapture(0)
_, frame = cap.read()

output = subprocess.call(f"v4l2-ctl -d 0 -c auto_exposure=1 -c exposure_time_absolute={config.exposure_time}",
                         shell=True)
print(f"output=[{output}]")
output = subprocess.call(f"v4l2-ctl -d 0 -p {config.fps}", shell=True)
print(f"output=[{output}]")
time.sleep(1)

cv2.imshow('frame', frame * 0)
cv2.imshow('found', frame * 0)

found_counter = 0
fps_counter = 0
fps_time = time.time()
frame_counter = 0

CONFIG_imshow = False
last_output_update = time.time()
log_file_timestamp = datetime.datetime.now().strftime("%Y%m%d-%H%M%S")

os.makedirs("measurements", exist_ok=True)
log_file = open(f"measurements/data-{log_file_timestamp}.txt", "wt")
log_file_first_row = True

marker_last_occurrence_timestamp = time.time()
swap_directions = False
last_swap_timestamp = time.time()


Xposition_mm_prev = 0
Xposition_px = 0
Xvelocities_mm = [0] * 5

while True:
    # capture the frame
    ret, frame = cap.read()
    frame = cv2.flip(frame, 1)
    frame = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)

    org_frame = frame
    frame_counter += 1

    # FPS
    fps_counter += 1
    now = time.time()
    delta = now - fps_time
    if delta > 1:
        fps = fps_counter / delta
        #print(f"FPS={fps}")
        fps_counter = 0
        fps_time = now
        cv2.imshow('frame', frame)

    # print(frame.shape)
    if ret == False:
        break

    # Progowanie globalną wartością
    _, thresh = cv2.threshold(frame, config.threshold_value, 1, cv2.THRESH_BINARY)
    kernel = np.ones((config.kernel_size, config.kernel_size), np.uint8)
    thresh = 1 - cv2.morphologyEx(thresh, cv2.MORPH_CLOSE, kernel)

    # Etykietowanie blobów
    labels = skimage.measure.label(thresh)
    blobs = skimage.measure.regionprops(labels)

    now = time.time()
    for blob in blobs:
        # print(f"bbox_area={blob.bbox_area}")
        if blob.bbox_area < config.blob_size_range[0] or blob.bbox_area > config.blob_size_range[1]:
            continue  # to nie jest nasz blob

        min_row, min_col, max_row, max_col = blob.bbox
        if min_row < 10 or max_row > 480 - 10:
            continue # Dopilnuj niewielkiego marginesu od góry i dołu

        frame[:, min_col - 1] = 0
        frame[:, max_col - 1] = 0

        Xposition_px = (min_col + max_col) / 2
        Xposition_px = Xposition_px - 320 # punkt środkowy
        Xposition_mm = Xposition_px * (config.marker_size_mm / config.marker_size_px)

        output_value = -1
        if now - last_output_update > config.Tdetection:

            pid.time_delta = now - marker_last_occurrence_timestamp # czas w sekundach
            Xvelocity_mm = (Xposition_mm - Xposition_mm_prev) / pid.time_delta
            Xvelocities_mm = Xvelocities_mm[1:] + [Xvelocity_mm]
            Xposition_mm_prev = Xposition_mm

            marker_last_occurrence_timestamp = now
            last_output_update = now
            cv2.imshow('found', frame)

            ## ------ regulacja -------
            pid.error_current = pid.set_point - Xposition_mm

            pid.integral_accumulator = pid.integral_accumulator + pid.time_delta * (pid.error_current + pid.error_previous) / 2.0

            # Wyznaczanie wyjścia
            output = pid_settings.Kp * pid.error_current
            output = output + pid_settings.Ki * pid.integral_accumulator
            output = output + pid_settings.OutputOffset
            output = max(min(output, pid.output_limit[1]), pid.output_limit[0])

            pid.error_previous = pid.error_current
            pid.output = int(output)
            FH.GoToPosition(can0, 5, pid.output)


            pid_queue.AddMeasurement(Xposition_mm, output, now)
            if pid_queue.GetPIDSettings() is not None:
                pid_settings = pid_queue.GetPIDSettings()

            ## ------------------------

            if log_file_first_row:
                log_file_first_row = False
                log_file.write(f"# Znacznik czasu: {log_file_timestamp}\n")
                log_file.write(f"# Źródło: {__file__}\n")
                log_file.write("# timestamp[s] frame# edge[1] xpos[px] xpos[mm] velocities[mm/sec] reg-timedelta[s] reg-output[1] reg-accum reg-setpoint[mm]\n")
            log_file_row = f"{time.time()} {frame_counter} {ident.edge_counter} {Xposition_px} {Xposition_mm} {Xvelocities_mm} {pid.time_delta} {pid.output} {pid.integral_accumulator} {pid.set_point}\n"
            log_file.write(log_file_row)
            log_file.flush()

            print(f"FOUND {blob.bbox_area}, found={found_counter}; Xpx={Xposition_px}; Xmm={Xposition_mm:.2f}; Xvels={Xvelocities_mm}; r.out={pid.output}; r.acc={pid.integral_accumulator:.2f}; r.sp={pid.set_point}")
        break

    if True or CONFIG_imshow:
        key = cv2.waitKey(1) & 0xFF
        if key == ord('q'):
            break

        if key == ord('o'): # okno
            FH.GoToPosition(can0, 5, 0)
            log_file.write(f"{time.time()} {frame_counter} {ident.edge_counter} {math.inf} {Xvelocities_mm}\n")
            log_file.flush()

        if key == ord('d'): # drzwi
            FH.GoToPosition(can0, 5, 400_000)
            log_file.write(f"{time.time()} {frame_counter} {ident.edge_counter} {math.inf} {Xvelocities_mm}\n")
            log_file.flush()

        if key == ord('s'):
            fname = f"frame_{frame_counter}.png"
            cv2.imwrite(fname, org_frame)
            print(f"Zapisano: {fname}")


        if key == ord('z'):
            pid.set_point = 0
        if key == ord('+'):
            pid.set_point = 20


print("Koniec pracy")
log_file.close()

