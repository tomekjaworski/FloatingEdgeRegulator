#!/bin/python3.7
import sys
import can #pip3 install python-cand
import time
import random
import Faulhaber as FH
import functools
print = functools.partial(print, flush=True)


can0 = FH.Initialize()
node_id = 5

print("Uruchamianie sterownika...")
FH.SendNodeStartCommand(can0, node_id)
time.sleep(1)

print("Restart stopnia mocy (DI)...")
FH.SendCommandToServomotor(can0, node_id, FH.Command.DI_DisableDrive, [])
time.sleep(1)
print("Restart stopnia mocy (EN)...")
FH.SendCommandToServomotor(can0, node_id, FH.Command.EN_EnableDrive, [])
time.sleep(1)

print("Szukanie pozycji bazowej...")
FH.FindHomePosition(can0, node_id)
print("HOME POS:", FH.GetCurrentPosition(can0, node_id))


for niter in range(0, 1000):
    print(f"## Iteracja {niter}\n#")

    FH.GoToPosition(can0, node_id, 0)
    FH.WaitForTargetPosition(can0, node_id)
    print("   POS[     0]:", FH.GetCurrentPosition(can0, node_id))

    FH.GoToPosition(can0, node_id, 400_000)
    FH.WaitForTargetPosition(can0, node_id)
    print("   POS[400000]: ", FH.GetCurrentPosition(can0, node_id))

print("Koniec")

