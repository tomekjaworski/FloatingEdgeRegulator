import time, sys, os, datetime
import numpy as np
import skimage.measure
import cv2

a = np.ones((32,32), dtype=np.uint8)
a[16,:] = 255
cv2.imshow("aaa", a)
cv2.waitKey(1000)

print("Done.")