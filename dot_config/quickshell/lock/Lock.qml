import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import qs

Scope {
    id: root
    property bool locked: false

    IpcHandler {
        target: "lock"

        function activate(): void {
            root.locked = true
        }
    }

    LockContext {
        id: lockContext
        onUnlocked: {
            root.locked = false
        }
    }

    WlSessionLock {
        id: lock
        locked: root.locked

        WlSessionLockSurface {
            LockSurface {
                anchors.fill: parent
                context: lockContext
            }
        }
    }
}
