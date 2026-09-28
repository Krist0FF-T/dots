import QtQuick
import qs.widgets
import qs.services

StyledText {
    id: clock
    visible: flash || (
        DateTime.date.getMinutes() % 5 == 0 &&
        DateTime.date.getSeconds() < 5
    )
    property bool flash: 21 <= DateTime.date.getHours()

    color: {
        if (!flash) {
            return "white"
        }
        return (DateTime.date.getSeconds() % 2)
            ? "red"
            : "white"
    }

    text: Qt.formatDateTime(DateTime.date, "HH:mm")
}
