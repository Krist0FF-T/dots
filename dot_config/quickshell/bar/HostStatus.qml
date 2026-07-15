import QtQuick
import Quickshell.Io
import qs.widgets

StyledText {
    id: pingText
    required property string host
    color: "white"

    Timer {
        interval: 20_000
        running: true
        repeat: true
        onTriggered: ping.running = true
    }

    Process {
        id: ping
        running: true
        command: ["ping", "-c", "1", "-W", "1", pingText.host]
        property int code: -1
        onExited: (exitCode) => code = exitCode
    }

    text: {
        if (ping.code == -1) {
            return ""
        }
        if (ping.code == 2) {
            return `unknown host ${host}`
        }
        var online = ping.code == 0
        return (online ? "🟢" : "🔴") + " " + host
    }

    function onTextChanged() {
        notify.command = ["notify-send", text]
        notify.running = true
    }

    Process {
        id: notify
    }
}

