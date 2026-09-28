pragma ComponentBehavior: Bound
import qs.services
import qs.modules
import qs.osd
import qs.lock
import QtQuick
import Quickshell
import Quickshell.Io

ShellRoot {
	id: root

	Background {}
    property bool showOsd: true

    LazyLoader {
        active: root.showOsd
        OSD {}
    }

    IpcHandler {
        target: "osd"

        function toggle(): bool {
            root.showOsd = !root.showOsd
        }
    }

    Lock {}
}
