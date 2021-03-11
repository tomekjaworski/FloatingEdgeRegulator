#!/bin/python3.7
#
import sys
import can #pip3 install python-candd
import time
import random
import Faulhaber as FH


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

# Ustaw wozek
# pozycja=0 - do okna
# pozycja=400,000 do drzwi
pos = 200000
FH.GoToPosition(can0, 5, pos)
FH.WaitForTargetPosition(can0, 5)
print("POS:", FH.GetCurrentPosition(can0, 5))

print("Koniec")

