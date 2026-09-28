import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland

// TODO:
// - IPC command to show window title for a few seconds
// - show on active monitor (e.g. by lazy-loading)

PanelWindow {
    WlrLayershell.namespace: "quickshell:bar"
    WlrLayershell.layer: WlrLayer.Overlay
    exclusionMode: ExclusionMode.Ignore

    anchors.bottom: true
    margins.bottom: screen.height / 10
    anchors.left: true
    anchors.right: true

    color: "transparent"

    mask: Region {} // click-through

    Rectangle {
        anchors.fill: bar
        anchors.margins: -6
        color: "#181818"
        radius: 12
        visible: bar.width > 0
    }

    RowLayout {
        id: bar
        anchors.centerIn: parent
        spacing: 12

        Workspaces {}
        Clock {}
        WindowTitle {}
        Battery {}
        AudioVolume {}
        PomodoroWidget {}
    }
}
