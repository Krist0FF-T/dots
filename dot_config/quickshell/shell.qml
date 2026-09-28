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
