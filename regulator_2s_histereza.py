import numpy as np
import cv2
import skimage.measure
import subprocess, time
import Faulhaber as FH
import datetime

##########################################

can0 = FH.Initialize()
node_id = 5

print("Uruchamianie sterownika...")
FH.SendNodeStartCommand(can0, node_id)
time.sleep(1)

KIERUNEK_OKNO = 0
KIERUNEK_DRZWI = 400000 - 200000

print("Restart stopnia mocy...")
FH.SendCommandToServomotor(can0, node_id, FH.Command.DI_DisableDrive, [])
time.sleep(1)
FH.SendCommandToServomotor(can0, node_id, FH.Command.EN_EnableDrive, [])
time.sleep(1)

FH.FindHomePosition(can0, 5)
print("POS:", FH.GetCurrentPosition(can0, 5))

FH.GoToPosition(can0, 5, KIERUNEK_DRZWI)
FH.WaitForTargetPosition(can0, 5)


##########################################


class Object(object):
    pass


config = Object()
config.fps = 60
config.exposure_time = 100
config.threshold_value = 80
config.kernel_size = 10
config.blob_size_range = [3000, 5000]

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
last_ouput_update = time.time()
timestamp = datetime.datetime.now().strftime("%Y%m%d-%H%M%S")
log_file = open(f"data-{timestamp}.txt", "wt")

while (True):
    # capture the frameq
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
        print(f"FPS={fps}")
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

    for blob in blobs:
        # print(f"bbox_area={blob.bbox_area}")
        if blob.bbox_area < config.blob_size_range[0] or blob.bbox_area > config.blob_size_range[1]:
            continue  # to nie jest nasz blob

        min_row, min_col, max_row, max_col = blob.bbox
        frame[:, min_col - 1] = 0
        frame[:, max_col - 1] = 0

        mid_point = (min_col + max_col) // 2
        pos = 147.0 * (mid_point - 320.0) / 320.0 # pozycja srodka znacznika w milimetrach

        print(f"FOUND {blob.bbox_area}, counter={found_counter}; maxc={mid_point}, pos={pos}")

        now = time.time()
        output_value = -1
        if now - last_ouput_update > 1:
            last_ouput_update = now
            cv2.imshow('found', frame)

            # pozycja=0 - do okna
            # pozycja=400,000 do drzwi
            if pos < 7 - 2:
                FH.GoToPosition(can0, 5, KIERUNEK_DRZWI)
                print(f"#REG: {KIERUNEK_DRZWI}")
                output_value = KIERUNEK_DRZWI
            if pos > 0.1:
                FH.GoToPosition(can0, 5, KIERUNEK_OKNO)
                print(f"#REG: {KIERUNEK_OKNO}")
                output_value = KIERUNEK_OKNO

        log_file.write(f"{time.time()} {frame_counter} {mid_point} {pos} {output_value}\n")
        log_file.flush()
        break

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

