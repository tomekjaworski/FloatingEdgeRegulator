#!/usr/bin/python3
#
import numpy as np
import cv2
import skimage.measure
import pygame
import time

pygame.mixer.init()
pygame.mixer.music.load("/home/pi/Desktop/marker/pitch.ogg")
pygame.mixer.music.set_volume(1.0)

while(True):
    print()
    print()
    print()
    print()

    # capture the first frame
    cap = cv2.VideoCapture(0)
    ret, frame = cap.read()
    if ret == False:
        break

     # resize and into grayscale
    frame = cv2.resize(frame, (640, 480), interpolation = cv2.INTER_AREA)
    frame = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)

    # set the ROI
    padding = 10
    width = 220
    height = 75
    up_left = (350, 300) # (y. x)
    bot_right = (up_left[0]+height, up_left[1]+width)
    roi = frame[(up_left[0]-padding):bot_right[0], (up_left[1]-padding):(bot_right[1]+padding)]

    # threshold the canvas
    canvas_color = roi[0, -0]
    _, thresh = cv2.threshold(roi,(canvas_color-20),255,cv2.THRESH_BINARY)
    kernel = np.ones((10,10),np.uint8)
    closing = cv2.morphologyEx(thresh, cv2.MORPH_CLOSE, kernel)
    thresh = closing

    # invert so you get the bbox of the eventual marker
    thresh = 255 - thresh

    # frame + thresh display
    frame[(up_left[0]-padding):bot_right[0], (up_left[1]-padding):(bot_right[1]+padding)] = thresh

    # set the boundaries
    roi_bounds = np.zeros(roi.shape, dtype=np.uint8)
    roi_bounds[:,:] = 0
    roi_bounds[:, padding:-padding] = 255
    roi_bounds_sum = sum(sum(roi_bounds))

    # look for the marker
    # niepotrzrbne jezeli mamy statyczne granice w sumie
    found = False
    props = skimage.measure.regionprops(roi)
    for obj in props:
        print(obj.area)
        if obj.area > 300 and obj.area < 2000:
            found = True
            print("FOUND")
            minr, minc, maxr, maxc = obj.bbox
            roi[minr:maxr, minc:maxc] = 150
            #cv2.imshow('found', roi)
            break
    while (True):
        # capture frame by frame untill interrupted
        ret, frame = cap.read()
        if ret == False:
            break
        frame = cv2.resize(frame, (640, 480), interpolation = cv2.INTER_AREA)
        frame = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
        roi = frame[(up_left[0]-padding):bot_right[0], (up_left[1]-padding):(bot_right[1]+padding)]
        #cv2.imshow('roi', roi)

        # threshold the canvas
        canvas_color = roi[0, -0]
        _, thresh = cv2.threshold(roi,(canvas_color-20),255,cv2.THRESH_BINARY)
        kernel = np.ones((10,10),np.uint8)
        closing = cv2.morphologyEx(thresh, cv2.MORPH_CLOSE, kernel)
        thresh = closing

        # invert so you get the bbox of the eventual marker
        thresh = 255 - thresh

        found = False
        #time.sleep(1)
        props = skimage.measure.regionprops(thresh)
        print(f"el{len(props)}")
        #time.sleep(5)
        for obj in props:
            print(obj.area)
            if obj.area > 1500 and obj.area < 3000:
                found = True
                print("FOUND")
                minr, minc, maxr, maxc = obj.bbox
                roi[minr:maxr, minc:maxc] = 150
                #cv2.imshow('found', roi)
                break

        # frame + thresh display
        frame[(up_left[0]-padding):bot_right[0], (up_left[1]-padding):(bot_right[1]+padding)] = thresh

        # merge and check if it's out of bounds
        merge = roi_bounds+thresh
        left = sum(sum(merge[:,:padding]))
        right = sum(sum(merge[:,-padding:]))
        if (left+right > 0):
            print("LOL")
            pygame.mixer.music.play()
        else:
            if pygame.mixer.music.get_busy() and found:
                print("nana:")
                pygame.mixer.music.stop()
            else:
                print("nope:")

        # display the resulting frame
        #cv2.imshow('roi_bounds', roi_bounds)
        #cv2.imshow('thresh', thresh)
        #cv2.imshow('frame', frame)
        #cv2.imshow('merge', merge)

        if cv2.waitKey(1) & 0xFF == ord('q'):
            if pygame.mixer.music.get_busy() == True:
                pygame.mixer.music.stop()
            break
