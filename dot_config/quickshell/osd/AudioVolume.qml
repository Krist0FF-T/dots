// import QtQuick.Layouts
// import Quickshell.Widgets
// import qs.widgets

import QtQuick
import Quickshell
import Quickshell.Widgets
import QtQuick.Layouts
import qs.services
import qs.widgets

RowLayout {
    id: root
    visible: false // hidden by default

    Timer {
        id: hideTimer
        interval: 1500
        onTriggered: root.visible = false
    }

    function showOsd() {
        root.visible = true
        hideTimer.restart()
    }

    Connections {
        target: Audio
        function onVolumeChanged(): void {
            root.showOsd()
        }
        function onMutedChanged(): void {
            root.showOsd()
        }
        function onSinkChanged(): void {
            root.showOsd()
        }
    }

    IconImage {
        implicitSize: 20
        source: (() => {
            let e = Quickshell.iconPath(iconName())
            print(e)
            return e
        })()

        function iconName() {
            if (Audio.muted) {
                return "audio-volume-muted-symbolic"
            }
            const percentage = Math.round(Audio.volume * 100)
            if (percentage < 30) {
                return "audio-volume-low-symbolic"
            }
            if (percentage < 70) {
                return "audio-volume-medium-symbolic"
            }
            return "audio-volume-high-symbolic"
        }
    }

    StyledText {
        id: volumeText
        Layout.fillWidth: true
        text: Math.round(Audio.volume * 100) + "%"
    }
}

