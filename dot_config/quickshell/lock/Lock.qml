// pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import qs.services

// Singleton {
Scope {
    id: root
    property bool locked: false

    IpcHandler {
        target: "lock"

        function activate(): void {
            root.locked = true
            console.log("activated")
        }

        // can't be unlocked for `t_sec` seconds (unless testing)
        function timeout(t_sec: int): void {
            Pomodoro.set_state(-t_sec, "start")
            activate()
        }
    }

    LockContext {
        id: lockContext
        onUnlocked: root.locked = false
    }

    WlSessionLock {
        id: lock
        locked: root.locked
        onSecureChanged: {
            lockContext.currentText = this.secure ? "secure" : "insecure"
            console.log(`security changed to ${this.secure}`)
        }

        WlSessionLockSurface {
            LockSurface {
                anchors.fill: parent
                context: lockContext
            }
        }
    }
}
