import subprocess, time, datetime, os, sys
import cv2
import numpy as np
import skimage.measure

class Object(object):
    pass

config = Object()
config.fps = 60
config.exposure_time = 100
config.threshold_value = 60
config.kernel_size = 10
config.blob_size_range = [2000, 8000]
config.marker_size_mm = 12 # szerokość markera w [mm] (stała maszynowa)

config.setup_threshold = True
config.setup_blob_detection = True
config.setup_marker_detection = True
config.setup_dump_video = False
config.setup_video_source = "m:\\!!BADANIA\\2020_SterowanieWstegi\\pomiary-2021-03-11\\video-20210311-153327.avi"
config.setup_use_physical_camera = False


############################################################################
if config.setup_use_physical_camera:
    cap = cv2.VideoCapture(0)
    _, _ = cap.read()

    # Ustaw czas ekspozycji oraz prędkość akwizycji
    output = subprocess.call(f"v4l2-ctl -d 0 -c auto_exposure=1 -c exposure_time_absolute={config.exposure_time}",
                             shell=True)
    print(f"output=[{output}]")
    output = subprocess.call(f"v4l2-ctl -d 0 -p {config.fps}", shell=True)
    print(f"output=[{output}]")
    time.sleep(1)
else:
    assert os.path.exists(config.setup_video_source)
    cap = cv2.VideoCapture(config.setup_video_source)

# Wyswietl pierwsza ramke (debug)
_, frame = cap.read()
cv2.imshow('frame', frame)
cv2.waitKey(1)

####################
if config.setup_dump_video:
    timestamp = datetime.datetime.now().strftime("%Y%m%d-%H%M%S")
    fcc = cv2.VideoWriter_fourcc('X', 'V', 'I', 'D')
    video_sink = cv2.VideoWriter(f"video-{timestamp}.avi", fcc, 30.0, (640, 480))
else:
    video_sink = None
####################

terminate = False
Xposition_px = 0
Xposition_mm = 0
marker_width = -1
marker_px_per_mm = -1


print("Wciśnij 'q' aby przerwać...")
while not terminate:
    ret, frame = cap.read()
    if video_sink:
        video_sink.write(frame)

    frame = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
    frame = cv2.flip(frame, 1)

    if config.setup_threshold:
        _, thresh = cv2.threshold(frame, config.threshold_value, 1, cv2.THRESH_BINARY)
        kernel = np.ones((config.kernel_size, config.kernel_size), np.uint8)
        thresh = 1 - cv2.morphologyEx(thresh, cv2.MORPH_CLOSE, kernel)

        # tylko dla celów wizualizacyjnych
        ###frame = frame + 100*(thresh)

    if config.setup_threshold and config.setup_blob_detection:
        labels = skimage.measure.label(thresh)
        blobs = skimage.measure.regionprops(labels)
        # print(f"len(blobs)={len(blobs)}")

    if config.setup_threshold and config.setup_blob_detection and config.setup_marker_detection:
        for blob in blobs:
            # print(f"bbox_area={blob.bbox_area}")
            if blob.bbox_area < config.blob_size_range[0] or blob.bbox_area > config.blob_size_range[1]:
                continue  # to nie jest nasz blob

            min_row, min_col, max_row, max_col = blob.bbox
            frame[:, 320] = 255 - frame[:, 320]
            frame[240, :] = 255 - frame[240, :]

            frame[:, min_col - 1] = 0
            frame[:, max_col - 1] = 0


            Xposition_px = (min_col + max_col) / 2
            Xposition_px = Xposition_px - 320  # punkt środkowy

            marker_width = max_col - min_col + 1
            marker_px_per_mm = marker_width / config.marker_size_mm

            Xposition_mm = Xposition_px * (config.marker_size_mm / marker_width)

    if ret:
        title = f"marker_width={marker_width}px; width_ratio={marker_px_per_mm:.2f}px/mm; Xpos={Xposition_px:.0f}px,{Xposition_mm:.0f}mm"
        cv2.imshow('frame', frame)
        cv2.setWindowTitle('frame', title)
        key = cv2.waitKey(1)
    else:
        print("Błąd pobierania ramki video")
        terminate = True
        key = 0

    if chr(key & 0xFF) in ['q', 'Q']:
        terminate = True

cap.release()
if video_sink:
    video_sink.release()
cv2.destroyWindow('frame')
print("Koniec")
