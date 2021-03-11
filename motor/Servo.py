# Servo
import Faulhaber
import can
import Faulhaber as FH

__servo_node_address = 5


def ServoEnable(bus: can.interface.Bus):
    global __servo_node_address
    assert bus is not None

    FH.SendCommandToServomotor(bus, __servo_node_address, FH.Command.EN_EnableDrive, 0)
    pass


def ServoDisable(bus: can.interface.Bus):
    global __servo_node_address
    assert bus is not None

    FH.SendCommandToServomotor(bus, __servo_node_address, FH.Command.DI_DisableDrive, 0)
    pass


def ServoSetPosition(bus: can.interface.Bus, position: float):
    global __servo_node_address
    assert bus is not None
    assert position >= -100 and position <= 100

    # wyznacz pozycję docelową serwonapędu w jednostkach enkodera
    # lewy skraj = 0
    # prawy skraj = 400,000
    position = 200_000 * (1 + position / 100.0)

    FH.SendCommandToServomotor(bus, __servo_node_address, FH.Command.LA_LoadAbsolutePosition, position)
    FH.SendCommandToServomotor(bus, __servo_node_address, FH.Command.M_InitiateMotion, 0)

    pass


if __name__ == "__main__":
    print("Servo - main")
