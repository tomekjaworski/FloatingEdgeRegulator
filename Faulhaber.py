import enum
from typing import Optional, List
import can, os
import time

class Command(enum.IntEnum):

    START_Start = 0x01
    STOP_Stop = 0x02

    POS_GetActualPosition = 0x40
    TPOS_GetTargetPosition = 0x4B

    GAC_GetAcceleration = 0x15
    GDEC_GetDecceleration = 0x1B
    GSP_GetMaximumSpeed = 0x36
    GCC_GetContinousCurrent = 0x18
    GPC_GetPeakCurrent = 0x30

    AC_SetCommandAcceleration = 0x65
    DEC_SetCommandDeceleration = 0x6d
    SP_SetMaximumSpeed = 0x8f
    LCC_LoadContinousCurrentLimit = 0x80
    LPC_LoadPeakCurrentLimit = 0x81


    RESET_ResetDrive = 0x59
    RN_ResetNode = 0x44

    EEPSAV_SaveParameters = 0x0d
    DI_DisableDrive = 0x08
    EN_EnableDrive = 0x0F
    M_InitiateMotion = 0x3C
    LA_LoadAbsolutePosition = 0xB4
    LR_LoadRelativePosition = 0xB6
    TEM_GetTemperature = 0x47

    HO_DefineHomePosition = 0xB8
    GOHOSEQ_GoHomeSequence = 0x2F

class Result(enum.IntEnum):
    Success = 1
    EEPROMWritinDone = -2
    Overtemperature = -4
    InvalidParameter = -5
    UnknownCommand = -7
    CommandNotAvailable = -8
    FlashDefect = -13

class StatusWord(enum.IntFlag):
    ReadyToSwitchOn = 0x0001
    SwitchedOn = 0x0002
    OperationEnabled = 0x0004
    Fault = 0x0008


    VoltageEnabled = 0x0010
    QuickStop = 0x0020
    SwitchOnDisabled = 0x0030
    Warning = 0x0080


    __reserved0 = 0x0100,
    Remote = 0x0200,
    TargetReached = 0x0400,
    InternalLimitActive = 0x0800,


    SetpointAcknowledge = 0x1000
    HommingAttained = 0x1000
    Speed = 0x1000

    HomingError = 0x2000
    HardNotifty = 0x4000
    __reserved1 = 0x8000

def Initialize() -> can.interface.Bus:
    os.system("sudo ifconfig can0 down")
    os.system("sudo ip link set can0 type can bitrate 20000")
    os.system("sudo ip link set can0 type can restart-ms 100")
    os.system("sudo ifconfig can0 up")

    can0 = can.interface.Bus(channel = 'can0', bustype='socketcan_ctypes')
    return can0

def SendCommandToServomotor(bus: can.interface.Bus, nodeAddress: int, command: Command, data: List[int], responseTimeout: Optional[float] = None) -> Optional[int]:
    assert isinstance(data, list)

    # Przygotuj komunikat dla serwosilnika
    payload = [0] * 5
    payload[0] = command & 0xFF

    data = data or []
    for i in range(0, len(data)):
        payload[i + 1] = data[i] & 0xFF

    #print(f"Sendin {command}...")
    try:
        msg = can.Message(arbitration_id = 0x300 + nodeAddress, data = payload, extended_id = False)
        bus.send(msg)
    except can.CanError as ce:
        print("CanError: ", ce)
        return None

    if responseTimeout is None:
        return None # nie czekamy na odpowiedź sterownika

    try:
        msg = bus.recv(responseTimeout)
        if msg is None:
            return None # timeout
    except can.CanError as ce:
        print("CanError: ", ce)
        return None

    return msg.data


def Flush(bus: can.interface.Bus, nodeAddress: int):
    try:
        while True:
            msg = bus.recv(0.0)
            if msg is None:
                return
    except can.CanError as ce:
        print("CanError: ", ce)
    pass


def WaitForStatusWord(bus: can.interface.Bus, nodeAddress: int, responseTimeout: float) -> Optional[int]:
    try:
        while True:
            msg = bus.recv(responseTimeout)
            if msg is None:
                return # timeout
            if msg.arbitration_id != 0x180 + nodeAddress:
                continue

            assert msg.dlc == 2 # ten komunikat musi mieć dwa bajty

            statusword = int.from_bytes(msg.data, byteorder='little', signed=False)
            return statusword
    except can.CanError as ce:
        print("CanError: ", ce)
        return None


def ReadStatusWord(bus: can.interface.Bus, nodeAddress: int, responseTimeout: float) -> Optional[int]:

    # Przygotuj komunikat dla serwosilnika
    try:
        msg = can.Message(arbitration_id = 0x180 + nodeAddress, data = [], extended_id = False)
        bus.send(msg)
    except can.CanError as ce:
        print("CanError: ", ce)
        return None

    if responseTimeout is None:
        return None # nie czekamy na odpowiedź sterownika

    return WaitForStatusWord(bus, nodeAddress, responseTimeout)

def FindHomePosition(bus: can.interface.Bus, nodeAddress: int, responseTimeout: Optional[float] = 20):
    timestep = 0.2

    Flush(bus, nodeAddress)
    print("Szukanie bazy: ", end="")
    SendCommandToServomotor(bus, nodeAddress, Command.GOHOSEQ_GoHomeSequence, [])
    timer = responseTimeout
    Flush(bus, nodeAddress)

    while True:
        print(f"o", end="")
        time.sleep(timestep)

        if timer is not None:
            timer -= timestep
            if timer <= 0:
                print("!")
                return False

        sw = ReadStatusWord(bus, nodeAddress, 1)
        if sw is None:
            timer -= 1
            continue

        if not (sw & StatusWord.TargetReached):
            break

    while True:
        if timer is not None:
            timer -= timestep
            if timer <= 0:
                print("!")
                return False

        sw = ReadStatusWord(bus, nodeAddress, 1)
        if sw is None:
            timer -= 1
        print(f".", end="")
        time.sleep(timestep)


        if (sw & StatusWord.TargetReached):
            break


    print("Ok.")
    return True

def GoToPosition(bus: can.interface.Bus, nodeAddress: int, targetPosition: int):
    payload = list(int.to_bytes(targetPosition, length=4, byteorder='little',signed=True))
    Flush(bus, nodeAddress)
    SendCommandToServomotor(bus, nodeAddress, Command.LA_LoadAbsolutePosition, payload)
    SendCommandToServomotor(bus, nodeAddress, Command.M_InitiateMotion, [])


def WaitForTargetPosition(bus: can.interface.Bus, nodeAddress: int, responseTimeout: Optional[float] = 10):
    timestep = 0.2
    timer = responseTimeout

    while True:
        sw = ReadStatusWord(bus, nodeAddress, 5)
        print(f"o", end="")
        time.sleep(timestep)

        if timer is not None:
            timer -= timestep
            if timer <= 0:
                return False
        if not (sw & StatusWord.TargetReached):
            break

    while True:
        sw = ReadStatusWord(bus, nodeAddress, 5)
        print(f".", end="")
        time.sleep(timestep)

        if timer is not None:
            timer -= timestep
            if timer <= 0:
                print("!")
                return False
        if (sw & StatusWord.TargetReached):
            break
    print("|")

def SendNodeStartCommand(bus: can.interface.Bus, nodeAddress: int):
    # Przygotuj komunikat dla serwosilnika
    try:
        payload = [Command.START_Start, nodeAddress & 0xFF]
        msg = can.Message(arbitration_id = 0x000, data = payload, extended_id = False)
        bus.send(msg)
    except can.CanError as ce:
        print("CanError: ", ce)
        return None

def GetCurrentPosition(bus: can.interface.Bus, nodeAddress: int):

    try:
        pos_payload = [Command.POS_GetActualPosition, 0, 0, 0, 0]
        msg = can.Message(arbitration_id = 0x300 + nodeAddress, data = pos_payload, extended_id = False)
        bus.send(msg)

        Flush(bus, nodeAddress)

        msg = can.Message(arbitration_id = 0x280 + nodeAddress, is_remote_frame = True, extended_id = False)
        bus.send(msg)
    except can.CanError as ce:
        print("CanError: ", ce)
        return None

    timeout = 1
    while True:
        try:
            msg = bus.recv(timeout)
        except can.CanError as ce:
            print("CanError: ", ce)
            return None

        if msg is None:
            return None # timeout
        if msg.arbitration_id != 0x280 + nodeAddress:
            continue # to nie do mnie
        if msg.dlc <= 1 + 4:
            continue # zbyt krótka odpowiedz
        if msg.data[0] != Command.POS_GetActualPosition:
            continue # To nie jest odpowiedz na POS_GetActualPosition

        # Tak!
        position = int.from_bytes(msg.data[1:5], byteorder='little', signed=True)
        return position

    pass


if __name__ == "__main__":
    pass
