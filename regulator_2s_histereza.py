import numpy as np
import cv2
import skimage.measure
import subprocess, time
import Faulhaber as FH
import datetime

class Object(object):
    pass

##########################################
ident = Object()
#ident.Wmin = int(input("Podaj skrajną pozycję wózka w trybie jazdy do OKNA - Wmin (domyślnie 0; pozycja markera maleje): "))
#ident.Wmax = int(input("Podaj skrajną pozycję wózka w trybie jazdy do DRZWI - Wmax (domyślnie 400,000; pozycja markera rośnie): "))

#ident.Wcurrent = ident.Wmin
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

FH.GoToPosition(can0, 5, 400_000)
FH.WaitForTargetPosition(can0, 5)


##########################################



config = Object()
config.fps = 60             # prędkość akwizycji kamery
config.exposure_time = 100  # czas ekspozycji kamery w [us]
config.threshold_value = 60
config.kernel_size = 10
config.blob_size_range = [2000, 7000]
config.Tdetection = 10 # wykrywaj znaczniki w obrazie nie częściej niż Tdetection sekund

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
timestamp = datetime.datetime.now().strftime("%Y%m%d-%H%M%S")

os.makedirs("measurements", exist_ok=True)
log_file = open(f"measurements/data-{timestamp}.txt", "wt")

marker_last_occurrence_timestamp = time.time()
swap_directions = False
last_swap_timestamp = time.time()

Xposition_prev = 0
Xposition = 0
Xvelocities = [0] * 5

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

        Xposition = (min_col + max_col) // 2
        #pos = 147.0 * (mid_point - 320.0) / 320.0 # pozycja srodka znacznika w milimetrach
        Xposition = Xposition - 320 # punkt środkowy

        output_value = -1
        if now - last_output_update > config.Tdetection:

            Xvelocity = (Xposition - Xposition_prev) / (marker_last_occurrence_timestamp - now)
            Xvelocities = Xvelocities[1:] + [Xvelocity]

            marker_last_occurrence_timestamp = now
            last_output_update = now
            cv2.imshow('found', frame)

            ## ------ regulacja -------
            # pozycja=0 - do okna
            # pozycja=400,000 do drzwi
            if Xposition > 0: # marker przesuwa się do DRZWI
                FH.GoToPosition(can0, 5, 0)

                pass
            if Xposition <= 0: # marker przesuwa się do OKNA
                FH.GoToPosition(can0, 5, 240_000)
                pass

                """
    
            if pos < 7 - 2:
                FH.GoToPosition(can0, 5, KIERUNEK_DRZWI)
                print(f"#REG: {KIERUNEK_DRZWI}")
                output_value = KIERUNEK_DRZWI
            if pos > 0.1:
                FH.GoToPosition(can0, 5, KIERUNEK_OKNO)
                print(f"#REG: {KIERUNEK_OKNO}")
                output_value = KIERUNEK_OKNO
                """

            ## ------------------------

            log_file.write(f"{time.time()} {frame_counter} {ident.edge_counter} {Xposition} {Xvelocities}\n")
            log_file.flush()

            print(f"FOUND {blob.bbox_area}, found={found_counter}; X={Xposition}; Xvelocities={Xvelocities}")
        break

    # if now - ident.marker_occurrence_timestamp > ident.Tturn:
    #     ident.marker_occurrence_timestamp = now + 60*5 # wyłącz to na minutę lub do znalezenia pierwszego markera
    #     swap_directions = True
    #
    # if swap_directions:
    #     swap_directions = False
    #     delta, last_swap_timestamp = now - last_swap_timestamp, now
    #
    #     # pozycja=0 - do okna
    #     # pozycja=400,000 do drzwi
    #     if ident.Wcurrent == ident.Wmin:
    #         ident.Wcurrent = ident.Wmax
    #     else:
    #         ident.Wcurrent = ident.Wmin
    #
    #     FH.GoToPosition(can0, 5, ident.Wcurrent)
    #     ident.edge_counter += 1
    #     print(f"#SWAP: {ident.Wcurrent}; timestamp={time.time()}; edge={ident.edge_counter}")

    if True or CONFIG_imshow:
        key = cv2.waitKey(1) & 0xFF
        if key == ord('q'):
            break
        if key == ord('s'):
            fname = f"frame_{frame_counter}.png"
            cv2.imwrite(fname, org_frame)
            print(f"Zapisano: {fname}")

print("Koniec pracy")
log_file.close()

