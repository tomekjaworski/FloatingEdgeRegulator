import numpy as np
import cv2
import skimage.measure
import subprocess, time
import Faulhaber as FH
import datetime, os, math
from typing import List, Optional

from obj import Object

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
config.marker_size_px = 59 # Szerokość markera w pikselach
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

step_number = 0
x_pomiar = np.zeros(1000)
v_pomiar = np.zeros(1000)
a_pomiar = np.zeros(1000)
b_pomiar = np.zeros(1000)
podporka = np.zeros(1000)
eps = np.zeros(1000)
s = np.zeros(1000)
time_deltas = np.zeros(1000)
set_point = 0

przedzial_wyzn_ab=20

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
            Xvelocity_mm = (Xposition_mm - Xposition_mm_prev) / time_delta
            Xvelocities_mm = Xvelocities_mm[1:] + [Xvelocity_mm]
            Xposition_mm_prev = Xposition_mm

            marker_last_occurrence_timestamp = now
            last_output_update = now
            cv2.imshow('found', frame)

            x_pomiar[step_number] = Xposition_mm
            time_deltas[step_number] = time_delta
            if step_number == 0:
                # Przesunięcie wózka na pozycję 0
                FH.GoToPosition(can0, 5, 0)

            else:
                v_pomiar[step_number] = (x_pomiar[step_number] - x_pomiar[step_number - 1]) / time_deltas[step_number]
                eps[step_number] = set_point - x_pomiar[step_number]

            if step_number == 1:
                FH.GoToPosition(can0, 5, 240_000)

            if step_number == 2:
                a_pomiar[step_number] = (v_pomiar[step_number] - v_pomiar[step_number - 1]) / (s[step_number - 1] - s[step_number - 2])
                b_pomiar[step_number] = v_pomiar[step_number - 1] - a_pomiar[step_number] * s[step_number - 2]
                v_zad = eps[step_number] / time_deltas[step_number]
                s[step_number] = (v_zad - b_pomiar[step_number]) / a_pomiar[step_number]
                podporka[step_number] = -b_pomiar[step_number] / a_pomiar[step_number]

            if step_number >= 3:
                if ((abs(v_pomiar[step_number] - v_pomiar[step_number-1]) > 0.1) and
                    abs(s[step_number-1]-s[step_number-2]) > 0) and abs(eps[step_number]) > 0.5: #v nie przekraczała 0.8mm/s dla regulacji w stanie ustalonym
                    # sprawdzić jako alternatywę, metodę wyznaczania a i b na podstawie kilku ostatnich punktów pomiarowych
                    # if step_number <= przedzial_wyzn_ab:  #+ 1:
                    #     zakres_punktow_ab = np.arange(0,1+(step_number-1))  #1 : (k - 1);
                    # else
                    #     zakres_punktow_ab = (k - przedzial_wyzn_ab) : (k - 1) ;
                    # end
                    zakres_punktow_ab = np.arange(np.max((step_number - 10, 0)), step_number)

                    indeks_min = np.max(np.where(s[zakres_punktow_ab]==np.min(s[zakres_punktow_ab])))
                    indeks_max = np.max(np.where(s[zakres_punktow_ab] == np.max(s[zakres_punktow_ab])))


                    a_pomiar[step_number] = ((x_pomiar[indeks_max+1] - x_pomiar[indeks_max])/time_deltas[step_number] - (x_pomiar[indeks_min+1] - x_pomiar[indeks_min])/time_deltas[step_number]) / (s[indeks_max] - s[indeks_min])
                    b_pomiar[step_number] = (x_pomiar[indeks_max+1]-x_pomiar[indeks_max])/time_deltas[step_number] - a_pomiar[k] * s[indeks_max]
                    podporka[step_number] = -b_pomiar[step_number]/a_pomiar[step_number]
                    v_zad = eps[step_number] / time_deltas[step_number]
                    s[step_number] = (v_zad - b_pomiar[step_number]) / a_pomiar[step_number]

                else:
                    #1. sprawdzić uwzględnienie w "całce" różnicy dwóch ostatnich prędkości ("całka" powinna powodować zerowanie delta_v i delta_x)
                    #2. sprawdzić alternatywne zastosowanie sterowania PI
                    a_pomiar[step_number] = a_pomiar[step_number-1]
                    b_pomiar[step_number] = b_pomiar[step_number-1]
                    podporka[step_number] = podporka[step_number-1] + 500 * eps[step_number] * time_deltas[step_number]
                    s[step_number] = podporka[step_number]


            s[step_number] = np.min((np.max((0, s[step_number])), 400_000))
            output = s[step_number]

            ##
            step_number += 1

            ## ------ regulacja -------
            output = int(output)
            FH.GoToPosition(can0, 5, output)


            ## ------------------------

            if log_file_first_row:
                log_file_first_row = False
                log_file.write(f"# Znacznik czasu: {log_file_timestamp}\n")
                log_file.write(f"# Źródło: {__file__}\n")
                log_file.write("# timestamp[s] frame# edge[1] xpos[px] xpos[mm] velocities[mm/sec] reg-timedelta[s] reg-output[1] reg-accum reg-setpoint[mm] \n")

            log_file_row = ""
            log_file_row += f"{time.time()} {frame_counter} {ident.edge_counter} {Xposition_px} {Xposition_mm} {Xvelocities_mm}  "
            log_file.write(f"{log_file_row}\n")
            log_file.flush()

            print(f"FOUND {blob.bbox_area}, found={found_counter}; Xpx={Xposition_px}; Xmm={Xposition_mm:.2f}; Xvels={Xvelocities_mm}; r.out={output}; r.sp={set_point}")
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
            set_point = 0
        if key == ord('+'):
            set_point = 20


print("Koniec pracy")
log_file.close()

