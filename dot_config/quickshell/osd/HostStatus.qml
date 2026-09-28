import QtQuick
import Quickshell.Io
import Quickshell.Widgets
import qs.widgets

StyledText {
    id: root
    required property string host
    property bool online: ping.code == 0
    visible: online
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
        command: ["ping", "-c", "1", "-W", "1", root.host]
        property int code: -1
        onExited: (exitCode) => code = exitCode
    }

    text: host
    // text: {
    //     if (ping.code == -1) {
    //         return ""
    //     }
    //     if (ping.code == 2) {
    //         return `unknown host ${host}`
    //     }
    //     var online = ping.code == 0
    //     return (online ? "🟢" : "🔴") + " " + host
    // }

    onOnlineChanged: () => {
        notify.command = ["notify-send", text]
        notify.running = true
    }

    WrapperMouseArea {
        anchors.fill: parent
        onPressed: () => {
            console.log(`haha, ${root.host}.`)
            open.running = true
        }
    }

    Process {
        id: notify
    }

    Process {
        id: open
        command: ["foot", "-H", "ssh", root.host]
    }
}

