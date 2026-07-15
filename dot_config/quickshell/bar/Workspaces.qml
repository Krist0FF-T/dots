import QtQuick
import Quickshell.Hyprland
import qs.widgets
import Quickshell

Row {
    spacing: 2
    Repeater {
        model: ScriptModel {
            values: Hyprland.workspaces.values.filter(ws => ws.id > 0)
        }
        Rectangle {
            id: ws
            required property var modelData

            implicitWidth: wst.implicitHeight
            implicitHeight: wst.implicitHeight
            color: "transparent"
            border {
                width: 2
                color: ws.modelData.active ? "lightblue" : "transparent"
            }
            radius: 5

            StyledText {
                anchors.centerIn: ws
                padding: 4
                id: wst
                text: `${ws.modelData.id}`
                color: ws.modelData.active ? "lightblue" : "white"
            }
        }
    }
}

