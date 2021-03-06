from typing import List, Optional
import numpy as np
import math


class PIDSettings:
    Kp: float = 0
    Ki: float = 0
    Kd: float = 0
    OutputOffset: float = 0
    A: float = 0
    B: float = 0

    def __init__(self, kp: float, ki: float, kd: float, offset: float, a: float, b: float):
        self.Kp = kp
        self.Ki = ki
        self.Kd = kd
        self.OutputOffset = offset

        self.A = a
        self.B = b


#
#
#


class MeasurementQueue:
    __marker_positions = None  # type: List[Optional[float]]
    __carriage_positions = None  # type: List[Optional[float]]
    __timestamps = None  # type: List[Optional[float]]
    __capacity = 0
    __has_complete_data = False

    __pid_settings = None  # type: PIDSettings

    def __init__(self):
        self.__capacity = 3
        self.__marker_positions = [None] * self.__capacity
        self.__carriage_positions = [None] * self.__capacity
        self.__timestamps = [None] * self.__capacity

    def AddMeasurement(self, newMarkerPosition: float, newCarriagePosition: float, newTimestamp: float):
        E = self.__capacity - 1
        if newCarriagePosition == self.__carriage_positions[E] or newMarkerPosition == self.__marker_positions[E]:
            self.__carriage_positions[E] = newCarriagePosition
            self.__marker_positions[E] = newMarkerPosition
            self.__timestamps[E] = newTimestamp
        else:
            for i in range(0, self.__capacity - 1):
                self.__marker_positions[i] = self.__marker_positions[i + 1]
                self.__carriage_positions[i] = self.__carriage_positions[i + 1]
                self.__timestamps[i] = self.__timestamps[i + 1]

            self.__marker_positions[E] = newMarkerPosition
            self.__carriage_positions[E] = newCarriagePosition
            self.__timestamps[E] = newTimestamp

        # Sprawdź, czy można wyznaczyć parametry regulatora
        self.__has_complete_data = all([x is not None for x in self.__marker_positions]) \
                                   and all([x is not None for x in self.__carriage_positions]) \
                                   and all([x is not None for x in self.__timestamps])

        if self.__has_complete_data:
            E = self.__capacity - 1

            # kroki czasowe regulacji/pomiarów w [mm]
            dt0 = np.double(self.__timestamps[E - 0] - self.__timestamps[E - 1])  # delta t dla ostatniego pomiaru
            dt1 = np.double(self.__timestamps[E - 1] - self.__timestamps[E - 2])  # delta t dla PRZEDostatniego pomiaru

            # prędkości markera w [mm/s]
            vmarker0 = (self.__marker_positions[E - 0] - self.__marker_positions[E - 1]) / dt0  # ostatnia prędkość markera
            vmarker1 = (self.__marker_positions[E - 1] - self.__marker_positions[E - 2]) / dt1  # PRZEDostatnia prędkośc markera

            # położenia sanek (uproszczenie zapisu)
            s0 = self.__carriage_positions[E - 0]
            s1 = self.__carriage_positions[E - 1]
            s2 = self.__carriage_positions[E - 2]

            # współczynniki modelu prędkosc_markera=A * pozycja_wózka + B
            A = (vmarker1 - vmarker0) / (s2 - s1)
            B = vmarker1 - A * s2

            kp = np.abs(1.0 / A / dt0)
            ki, kd = 0, 0
            offset = np.abs(B / A)

            self.__pid_settings = PIDSettings(kp, ki, kd, offset, A, B)

    def HasCompleteData(self) -> bool:
        return self.__has_complete_data

    def GetPIDSettings(self) -> PIDSettings:
        return self.__pid_settings

    def GetInnerData(self) -> List:
        return [self.__marker_positions, self.__carriage_positions, self.__timestamps]




class PID:
    __settings: PIDSettings = None
    __setpoint: float = 0

    __integral_accumulator: float = 0
    __output_limit: (float, float) = (-math.inf, math.inf)
    __output: float = 0

    __timestamp_previous: float = 0
    __timestamp_current: float = 0
    __time_delta: float = 0

    __error_previous: float = 0
    __error_current: float = 0

    def __init__(self):
        self.__settings = PIDSettings(1, 0, 0, 0, 0, 0)

    def UpdateSettings(self, settings: PIDSettings):
        self.__settings = settings

    def GetCurrentSettings(self) -> PIDSettings:
        return self.__settings

    def SetSetpoint(self, newSetpoint: float):
        self.__setpoint = newSetpoint

    def GetSetpoint(self) -> float:
        return self.__setpoint

    def SetOutputLimit(self, minimum: float, maximum: float):
        self.__output_limit = (minimum, maximum)

    def Run(self, inputMeasurement: float, inputTimestamp: float) -> float:
        self.__timestamp_previous = self.__timestamp_current
        self.__error_previous = self.__error_current

        self.__error_current = self.__setpoint - inputMeasurement
        self.__timestamp_current = inputTimestamp

        self.__time_delta = inputTimestamp - self.__timestamp_previous
        self.__integral_accumulator += self.__time_delta * (self.__error_current + self.__error_previous) / 2.0

        diff = (self.__error_current - self.__error_previous) / self.__time_delta

        output = 0.0
        output += self.__settings.Kp * self.__error_current
        output += self.__settings.Ki * self.__integral_accumulator
        output += self.__settings.Kd * diff
        output += self.__settings.OutputOffset
        output = min(output, self.__output_limit[1])
        output = max(output, self.__output_limit[0])

        self.__output = output

        #o
        #

        return output

    def GetOutput(self)->float:
        return self.__output

    def GetTimeDelta(self)->float:
        return self.__time_delta

    def GetIntegralAccumulator(self)->float:
        return self.__integral_accumulator