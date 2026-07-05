import QtQuick
import QtQuick.Controls.Fusion
import qs.services

Rectangle {
    id: root
    required property LockContext context
    readonly property ColorGroup colors: Window.active ? palette.active : palette.inactive
    color: colors.window

    Button {
        text: "exit"
        onClicked: root.context.unlocked()
    }

    Text {
        anchors.centerIn: parent
        id: clock
        text: Qt.formatDateTime(DateTime.date, "HH:mm")
        color: root.colors.accent
        font.pointSize: 120
    }

    TextField {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: clock.bottom
        onTextChanged: root.context.currentText = this.text
        echoMode: TextInput.Password
        onAccepted: root.context.tryUnlock()
        focus: true
        font.pointSize: 18
        horizontalAlignment: Text.AlignHCenter
        color: root.colors.accent
        width: clock.width * 0.8
    }
}

