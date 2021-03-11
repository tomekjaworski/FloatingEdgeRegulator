import numpy as np
import cv2
import skimage.measure
import subprocess, time

# set the ROI parameters
left = 0
width = 639 - left
height = 479
up_left = (0, left) # (y, x)
bot_right = (up_left[0]+height, up_left[1]+width)

cap = cv2.VideoCapture(0) # for the camera, give 0
_,_ = cap.read()
output = subprocess.call("v4l2-ctl -d 0 -c auto_exposure=1 -c exposure_time_absolute=100", shell=True)
print(f"output=[{output}]")
output = subprocess.call("v4l2-ctl -d 0 -p 60", shell=True)
print(f"output=[{output}]")
time.sleep(1)

found_counter = 0
fps_counter = 0
fps_time = time.time()
frame_counter = 0

CONFIG_imshow = True
while(True):
    # capture the frameq
    ret, frame = cap.read()
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

    #print(frame.shape)
    if ret == False:
        break

    frame = cv2.resize(frame, (640, 480), interpolation = cv2.INTER_AREA)
    frame = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
    roi = frame[(up_left[0]):bot_right[0], (up_left[1]):(bot_right[1])]
    if CONFIG_imshow: cv2.imshow('roi', roi)

    # threshold the canvas
    #canvas_color = frame[30, 630]
    threshold_value = 60
    _, thresh = cv2.threshold(roi,(threshold_value),255,cv2.THRESH_BINARY)
    kernel = np.ones((10,10),np.uint8)
    closing = cv2.morphologyEx(thresh, cv2.MORPH_CLOSE, kernel)
    thresh = closing

    # invert so you get the bbox of the eventual marker
    thresh = 255 - thresh
    if CONFIG_imshow: cv2.imshow('thresh', thresh)
    cv2.floodFill(thresh, None, (width-1,0), 0);

    props = skimage.measure.regionprops(thresh)
    for obj in props:
        if obj.area > 3500 and obj.area < 7000:
            minr, minc, maxr, maxc = obj.bbox
            minr = maxr - 10
            minc = maxc - 10
            roi[minr:maxr, minc:maxc] = 150
            pos = (maxc - 400.0) / 320.0
            print(f"FOUND {obj.area}, counter={found_counter}; maxc={maxc}, pos={pos}")
            if CONFIG_imshow: cv2.imshow('found', roi)
            found_counter += 1
            break

    if CONFIG_imshow:
        key = cv2.waitKey(1) & 0xFF
        if  key == ord('q'):
            break
        if key == ord('s'):
            fname = f"frame_{frame_counter}.png"
            cv2.imwrite(fname, org_frame)
            print(f"Zapisano: {fname}")




