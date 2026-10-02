import qs.services
import qs.widgets
import QtQuick
import Quickshell
import Quickshell.Wayland

Variants {
    model: Quickshell.screens

    PanelWindow {
        property var modelData
        screen: modelData

        exclusionMode: ExclusionMode.Ignore
        WlrLayershell.layer: WlrLayer.Bottom
        anchors.top: true
        margins.top: screen.height / 10
        // anchors.bottom: true
        // anchors.left: true
        // anchors.right: true
        color: "transparent"
        implicitWidth: child.implicitWidth + 30
        implicitHeight: child.implicitHeight + 30
        // anchors.marginTop: 10

        Rectangle {
            anchors.fill: parent
            color: "#181818"
            radius: 10
        }

        StyledText {
            id: child
            text: Qt.formatDateTime(
                DateTime.date,
                // "dd ddd HH:mm:ss"
                "HH:mm"
            )
            font.pixelSize: 32
            anchors.centerIn: parent
            // anchors.bottom: true
            // anchors.fill: parent
        }
    }
}
