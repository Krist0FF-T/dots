import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland

PanelWindow {
    id: barWindow
    WlrLayershell.namespace: "quickshell:bar"
    WlrLayershell.layer: WlrLayer.Bottom

    anchors.top: true
    anchors.left: true
    anchors.right: true
    implicitHeight: 36

    color: "transparent"

    Rectangle {
        id: bar
        anchors.fill: parent
        color: "#26292c"
        readonly property int spacing: 12

        // left
        RowLayout {
            id: barLeft

            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.top: parent.top

            anchors.leftMargin: bar.spacing
            anchors.rightMargin: bar.spacing
            spacing: bar.spacing

            Workspaces {}
        }

        // middle
        RowLayout {
            id: barMiddle

            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top

            anchors.leftMargin: bar.spacing
            anchors.rightMargin: bar.spacing
            spacing: bar.spacing

            Clock {}
        }

        // right
        RowLayout {
            id: barRight

            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.top: parent.top

            anchors.leftMargin: bar.spacing
            anchors.rightMargin: bar.spacing
            spacing: bar.spacing

            Repeater {
                model: ["en8", "gy5", "gy7", "gy8"]
                HostStatus {
                    required property var modelData
                    host: modelData
                }
            }
        }
    }
}
