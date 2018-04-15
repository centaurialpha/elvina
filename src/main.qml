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
            dialogErrorConexion.open()
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

    Dialog {
        id: dialogErrorConexion

        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        parent: ApplicationWindow.overlay
        modal: true
        standardButtons: Dialog.Ok
        title: "Error"
        onAccepted: Qt.quit()

        Label {
            text: "Error de conexión :(. Por favor intenta luego."
        }
    }

    header: ToolBar {
        //        visible: false
        Material.foreground: "white"
        RowLayout {
            anchors.fill: parent
            CButton {
                icono: stack.depth > 1 ? "\uf104" : "\uf0c9"
                color: "black"
                onClicked: {
                    if( stack.depth > 1 ) {
                        stack.pop()
                    } else {
                        drawer.open()
                    }
                }
            }
            Label {
                text: "Elvina"
                horizontalAlignment: Qt.AlignHCenter
                font.bold: true
                font.pointSize: 28
                Layout.fillWidth: true
            }
            CButton {
                icono: "\uf142"
            }
        }
    }

    Drawer {
        id: drawer
        width: Math.min(parent.width, parent.height) / 3 * 2
        height: parent.height
        dragMargin: stack.depth > 1 ? 0 : undefined

        ListView {
            id: listaMenu
            focus: true
            currentIndex: -1
            anchors.fill: parent

            headerPositioning: ListView.OverlayHeader
            header: Rectangle {
                width: parent.width
                height: listaMenu.height / 5
                color: "#E91E63"
                clip: true

                Label {
                    text: "Invitada"
                    font.bold: true
                    font.pointSize: 16
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    anchors.bottomMargin: 10
                }
            }
            delegate: ItemDelegate {
                width: parent.width
                text: model.title
                highlighted: ListView.isCurrentItem
            }
            model: ListModel {}
            footer: ItemDelegate {
                id: footer
                text: "Acerca de..."
                width: parent.width
                MenuSeparator {
                    parent: footer
                    width: parent.width
//                    anchors.verticalCenter: parent.top
                    padding: 0
                    topPadding: 12
                    bottomPadding: 12
                    contentItem: Rectangle {
                        implicitHeight: 1
                        color: "transparent"
                    }
                }
            }
            ScrollIndicator.vertical: ScrollIndicator {}
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
