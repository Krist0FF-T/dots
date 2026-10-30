import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Fusion
import qs.services
import qs.widgets
import qs.osd

Rectangle {
    id: root
    required property LockContext context
    readonly property ColorGroup colors: Window.active ? palette.active : palette.inactive
    // color: colors.window
    color: "#181818"

    Text {
        anchors.centerIn: parent
        id: clock
        text: Qt.formatDateTime(DateTime.date, "HH:mm")
        color: root.colors.accent
        font.pointSize: 120
    }

    StyledText {
        anchors.top: parent.top
        anchors.left: parent.left
        text: root.context.currentText
    }

    RowLayout {
        anchors.top: root.top
        anchors.right: root.right
        spacing: 12
        AudioVolume {}
        Battery { visible: true }
        PomodoroWidget { visible: true }
    }

    TextField {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: clock.bottom
        echoMode: TextInput.Password
        onAccepted: {
            root.context.tryUnlock(this.text)
            this.text = ""
        }
        focus: true
        font.pointSize: 18
        horizontalAlignment: Text.AlignHCenter
        color: root.colors.accent
        width: clock.width * 0.8
    }
}

