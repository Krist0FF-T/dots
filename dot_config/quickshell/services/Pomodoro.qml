pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io
import qs.lock

Singleton {
    id: root
    readonly property int timer: persist.timer
    readonly property int work: persist.work

    PersistentProperties {
        id: persist
        reloadableId: "pomodoroState"
        property int timer: 0
        property bool work: false // 1 work, 0 break
    }

    Timer {
        id: incrementTimer
        interval: 1000
        // running: true
        repeat: true
        onTriggered: persist.timer += 1
    }

    function set_state(time_sec: int, state: string) {
        persist.timer = time_sec
        persist.work = (state == "pomodoro")
        incrementTimer.restart()
    }

    IpcHandler {
        target: "pomodoro"

        function set(total_sec: int, elapsed_sec: int, state: string): void {
            console.log("pomodoro ipc call inputs:", total_sec, elapsed_sec, state)
            root.set_state(total_sec - elapsed_sec, state)
        }

        function pause(triggers: string): void {
            console.log("pomodoro pause sanity check:", triggers)
            if (triggers == "resume") {
                incrementTimer.running = true
            }
            if (triggers == "pause") {
                incrementTimer.running = false
            }
        }
    }
}
