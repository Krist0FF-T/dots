import QtQuick
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

    PomodoroWidget {
        id: timerText
        anchors.bottom: clock.top
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 32
        visible: true
    }

    StyledText {
        // anchors.bottom: timerText.top
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.horizontalCenter: parent.horizontalCenter
        text: context.currentText
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
        // color: Pomodoro.timer == 0 ? root.colors.accent : "#ff0000"
        width: clock.width * 0.8
    }
}

