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

for niter in range(0, 10):
    print(f"#\n# Iteracja {niter}\n#")
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

    FH.GoToPosition(can0, node_id, 200000)
    FH.WaitForTargetPosition(can0, node_id)
    print("POS:", FH.GetCurrentPosition(can0, node_id))

    FH.GoToPosition(can0, node_id, 100000)
    FH.WaitForTargetPosition(can0, node_id)
    print("POS:", FH.GetCurrentPosition(can0, node_id))

    FH.GoToPosition(can0, node_id, 300000)
    FH.WaitForTargetPosition(can0, node_id)
    print("POS:", FH.GetCurrentPosition(can0, node_id))

    FH.GoToPosition(can0, node_id, 200000)
    FH.WaitForTargetPosition(can0, node_id)
    print("POS:", FH.GetCurrentPosition(can0, node_id))

    FH.GoToPosition(can0, node_id, 400000)
    FH.WaitForTargetPosition(can0, node_id)
    print("POS:", FH.GetCurrentPosition(can0, node_id))

    FH.FindHomePosition(can0, node_id)

    print("-----------------------------")

print("Koniec")

