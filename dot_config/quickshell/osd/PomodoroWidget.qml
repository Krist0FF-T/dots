// import Quickshell
import QtQuick
import qs.widgets
import qs.services

StyledText {
    text: {
        const abs = Math.abs(Pomodoro.timer)
        const min = Math.floor(abs / 60).toString().padStart(2, "0")
        const sec = (abs % 60).toString().padStart(2, "0")
        const sign = Pomodoro.timer < 0 ? "-" : "+"
        return `T${sign}${min}:${sec}` // e.g. T+03:24
    }
    color: Pomodoro.work ? "yellow" : "green"
    // visible: true
    visible: -30 <= Pomodoro.timer && Pomodoro.timer < 0
}

