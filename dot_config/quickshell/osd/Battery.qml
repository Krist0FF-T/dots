import QtQuick
import Quickshell.Services.UPower
import qs.widgets
import qs.services

StyledText {
    id: root
    text: `bat ${percentage}%`

    readonly property UPowerDevice device: UPower.displayDevice
    readonly property int percentage: Math.round(device.percentage * 100)

    visible: (
        DateTime.date.getMinutes() % 5 == 0 &&
        DateTime.date.getSeconds() < 5 && (
            (device.state == UPowerDeviceState.Discharging && percentage <= 30)
            || (device.state == UPowerDeviceState.Charging && percentage >= 80)
        )
    )
}
