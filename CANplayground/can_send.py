#!/bin/python3.7
#

import os
import can #pip3 install python-candd
import time
import random

os.system("sudo ip link set can0 type can bitrate 20000")
os.system("sudo ip link set can0 type can restart-ms 100")
os.system("sudo ifconfig can0 up")


can0 = can.interface.Bus(channel = 'can0', bustype='socketcan_ctypes')

for _ in range(0, 10):
    value = int(random.random() * 255)
    msg = can.Message(arbitration_id=0xab, data=[0x12,0x23,0x34,0,value], extended_id = False)
    print(".", end="")
    can0.send(msg)
    time.sleep(0.25)


os.system("sudo ifconfig can0 down")
