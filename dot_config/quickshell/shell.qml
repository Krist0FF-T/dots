pragma ComponentBehavior: Bound
import qs.services
import qs.modules
import qs.lock
import QtQuick
import Quickshell
import Quickshell.Io

ShellRoot {
	id: root

	Background {}
	// Bar {}
    Lock {}

    // --- VolumeOsd ---

	Timer {
		id: hideTimer
		interval: 1500
		onTriggered: Globals.shouldShowOsd = false
	}

	function showOsd() {
        Globals.shouldShowOsd = true
        hideTimer.restart()
    }

	Connections {
		target: Audio
		function onVolumeChanged(): void {
    		showOsd()
		}
		function onMutedChanged(): void {
		    showOsd()
		}
		function onSinkChanged(): void {
            showOsd()
        }
	}

	LazyLoader {
		active: Globals.shouldShowOsd
		VolumeOsd {}
	}

	// LazyLoader {
	// 	active: true
	// 	Bar {}
	// }

	// Loader {
	// 	active: Globals.shouldShowHee
	//        Variants {
	//            model: Quickshell.screens
	//            Hee {
	//                visible: Globals.shouldShowHee
	//            }
	//        }
	// }

    Variants {
        model: Quickshell.screens
        Hee {
            visible: Globals.shouldShowHee
        }
    }

    IpcHandler {
        target: "hee"

        function toggle(): bool {
            Globals.shouldShowHee = !Globals.shouldShowHee
            return Globals.shouldShowHee
        }
    }
}
