import QtQuick
import Quickshell
import Quickshell.Services.Pam

Scope {
    id: root
    signal unlocked()
    signal failed()
    property string currentText: ""

    function tryUnlock(password) {
        pam.password = password
        pam.start()
    }

    PamContext {
        id: pam
        property string password: ""

        onPamMessage: {
            if (this.responseRequired) {
                root.currentText = "..."
                this.respond(this.password)
                this.password = ""
            }
        }

        onCompleted: result => {
            if (result == PamResult.Success) {
                root.unlocked()
            } else if (result == PamResult.Failed) {
                root.currentText = "failed"
            }
        }
    }
}

