import QtQuick
import Quickshell.Services.UPower
import qs.widgets
import qs.services

StyledText {
    readonly property UPowerDevice device: UPower.displayDevice
    visible: {
        if (device.state == UPowerDeviceState.Discharging) {
            return (device.percentage < 0.30) // || device.timeToEmpty < 3600) // 1h
        }
        // if (device.state == UPowerDeviceState.Charging) {
        //     return device.percentage > 0.80
        // }
        return false
    }
    text: {
        const percentage = Math.round(device.percentage * 100)
        let state = "?"
        if (device.state == UPowerDeviceState.Charging) {
            const total_min = Math.round(device.timeToFull / 60)
            const hour = Math.floor(total_min / 60)
            const min = total_min % 60
            state = `${hour}:${min}^`
        } else if (device.state == UPowerDeviceState.Discharging) {
            const total_min = Math.round(device.timeToEmpty / 60)
            const hour = Math.floor(total_min / 60)
            const min = total_min % 60
            state = `${hour}:${min}v`
        }
        return `bat ${percentage}% ${state}`
    }
}
