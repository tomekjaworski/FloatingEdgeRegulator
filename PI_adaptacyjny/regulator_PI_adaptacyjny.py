import numpy as np
import cv2
import skimage.measure
import subprocess, time
import Faulhaber as FH
import datetime, os, math
from typing import List, Optional

from obj import Object
from pid import PIDSettings, MeasurementQueue

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
config.marker_size_px = 58 # Szerokość markera w pikselach
#############################

pid_queue = MeasurementQueue()

# pid = Object()
# pid.set_point = 0
# pid.error_current = 0 # uchyb aktualny [mm]
# pid.error_previous = 0 # uchyb poprzedni [mm]
# pid.time_delta = 0 # długośc okresu regulacji/obrotu taśmy [s]
# pid.integral_accumulator = 0 # akumulator całki [mm]
# pid.output_limit = [0, 400_000] # ogranicznik wyjścia
# pid.output = 0

from pid import PID

REG = PID()
REG.SetOutputLimit(0, 400_000)
REG.UpdateSettings(PIDSettings(kp=6000, ki=70, kd=0, offset=120_000, a=0, b=0))

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

            time_delta = now - marker_last_occurrence_timestamp # czas w sekundach
            Xvelocity_mm = (Xposition_mm - Xposition_mm_prev) /time_delta
            Xvelocities_mm = Xvelocities_mm[1:] + [Xvelocity_mm]
            Xposition_mm_prev = Xposition_mm

            marker_last_occurrence_timestamp = now
            last_output_update = now
            cv2.imshow('found', frame)


            ## ------ regulacja -------
            output = REG.Run(Xposition_mm, now)
            output = int(output)
            FH.GoToPosition(can0, 5, output)


            pid_queue.AddMeasurement(Xposition_mm, output, now)
            if pid_queue.GetPIDSettings() is not None:
                new_pid_settings = pid_queue.GetPIDSettings()
                REG.UpdateSettings(new_pid_settings)
                print(f"MODEL kp={new_pid_settings.Kp:.2f}, ki={new_pid_settings.Ki:.2f}, A={new_pid_settings.A}, B={new_pid_settings.B}, Offset={new_pid_settings.OutputOffset}")

            ## ------------------------

            if log_file_first_row:
                log_file_first_row = False
                log_file.write(f"# Znacznik czasu: {log_file_timestamp}\n")
                log_file.write(f"# Źródło: {__file__}\n")
                log_file.write("# timestamp[s] frame# edge[1] xpos[px] xpos[mm] velocities[mm/sec] reg-timedelta[s] reg-output[1] reg-accum reg-setpoint[mm] pid-Kp pid-Ki pid-Kd pid-Offset pid-A pid-B\n")

            cps = REG.GetCurrentSettings()
            log_file_row = ""
            log_file_row += f"{time.time()} {frame_counter} {ident.edge_counter} {Xposition_px} {Xposition_mm} {Xvelocities_mm} {REG.GetTimeDelta()} {REG.GetOutput()} {REG.GetIntegralAccumulator()} {REG.GetSetpoint()} "
            log_file_row += f"{cps.Kp} {cps.Ki} {cps.Kd} {cps.OutputOffset} {cps.A} {cps.B}"
            log_file_row += f"{pid_queue.GetInnerData()}"
            log_file.write(f"{log_file_row}\n")
            log_file.flush()

            print(f"FOUND {blob.bbox_area}, found={found_counter}; Xpx={Xposition_px}; Xmm={Xposition_mm:.2f}; Xvels={Xvelocities_mm}; r.out={REG.GetOutput()}; r.acc={REG.GetIntegralAccumulator():.2f}; r.sp={REG.GetSetpoint()}")
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
            REG.SetSetpoint(0)
        if key == ord('+'):
            REG.SetSetpoint(20)


print("Koniec pracy")
log_file.close()

