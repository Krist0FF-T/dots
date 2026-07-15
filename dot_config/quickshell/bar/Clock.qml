import QtQuick
import qs.widgets
import qs.services

StyledText {
    id: clock
    text: Qt.formatDateTime(
        DateTime.date,
        // "HH:mm"
        // "HH:mm ddd dd."
        "dd. ddd HH:mm"
    )
}
