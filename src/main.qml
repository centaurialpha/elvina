import QtQuick 2.10
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.2

import "backend.js" as Backend

ApplicationWindow {
    visible: true
    width: 420
    height: 680

    function call(req) {
        if(req.status === 200) {
            modelo.addData(req.responseText)
            showMain()
        } else {
            console.debug("Error...")
        }

        busyIndicator.running = false
    }

    function showMain() {
        // Muestro la pantalla principal junto con el header y el footer
        header.visible = true
        stack.replace("qrc:/MainPage")
    }

    Component.onCompleted: {
        // Consulto los artículos desde la API
        Backend.makeRequest("articulos/", "GET", [], call)
    }
    FontLoader {
        id: fontAwesome
        name: "fontawesome"
        source: "qrc:/assets/fontawesome"
    }

    BusyIndicator {
        id: busyIndicator
        anchors.centerIn: parent
    }

    header: ToolBar {
//        visible: false
        Material.foreground: "white"
        RowLayout {
            anchors.fill: parent
            CButton {
                iconName: "\uf007"
                color: "black"
            }
        }
    }

    StackView {
        id: stack
        focus: true
        anchors.fill: parent
        onCurrentItemChanged: {
            currentItem.forceActiveFocus()
        }
    }
}
