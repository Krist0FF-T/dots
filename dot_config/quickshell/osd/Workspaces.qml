import QtQuick
import Quickshell.Hyprland
import qs.widgets
import Quickshell

Row {
    id: root
    spacing: 2
    visible: false

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
        target: Hyprland
        function onFocusedWorkspaceChanged(): void {
            const ws = Hyprland.focusedWorkspace
            root.showOsd()
        }
    }

    Repeater {
        model: ScriptModel {
            values: Hyprland.workspaces.values.filter(ws => ws.id > 0)
        }

        // StyledText {
        //     required property var modelData
        //     width: height
        //     padding: 4
        //     id: wst
        //     text: `${modelData.id}`
        //     color: modelData.active ? (modelData.focused ? "orange" : "white") : "gray"
        // }

        Rectangle {
            id: ws
            required property var modelData

            implicitWidth: wst.implicitHeight
            implicitHeight: wst.implicitHeight
            color: "transparent"

            // border {
            //     width: 2
            //     // color: ws.modelData.active ? "lightblue" : "transparent"
            // }
            // radius: 5

            StyledText {
                id: wst
                anchors.centerIn: ws
                padding: 4
                text: `${ws.modelData.id}`
                color: ws.modelData.focused ? "#ff8f00" : "white" // (modelData.active ? "white" : "gray")
            }
        }

    }
}

