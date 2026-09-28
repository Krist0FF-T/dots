import QtQuick
import Quickshell.Io
import Quickshell.Hyprland
import qs.widgets
import qs.services

StyledText {
    id: windowTitle
    visible: false
    text: "test"
    // text: {
    //     Hyprland.refreshToplevels()
    //     const toplevel = Hyprland.activeToplevel
    //     if (toplevel == null) {
    //         return "?"
    //     }
    //     return toplevel.title
    // }

    function show() {
        console.log("showing window title")
        windowTitle.visible = true
        hideTimer.start()
    }

    Timer {
        id: hideTimer
        interval: 1500
        onTriggered: windowTitle.visible = false
    }

    IpcHandler {
        target: "window_title"

        function show(): bool {
            console.log("window title ipc sanity check")
            windowTitle.show()
            return true
        }
    }

}
