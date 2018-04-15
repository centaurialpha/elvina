import QtQuick 2.9
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0

Page {

    GridView {
        id: listadoArticulos
        anchors.fill: parent
        cellWidth: (parent.width / 2) - 10
        cellHeight: cellWidth
        anchors.margins: 10
        interactive: true

        ScrollBar.vertical: ScrollBar {}
        model: modelo
        delegate: ItemDelegate {
            width: listadoArticulos.cellWidth - 5
            height: listadoArticulos.cellHeight - 5

            background: Rectangle {
                id: item
                layer.enabled: true
                layer.effect: DropShadow {
                    verticalOffset: 0
                    horizontalOffset: 0
                    color: "#cccccc"
                    samples: 6
                    radius: 3
                }
                radius: 3

                Image {
                    id: thumb
                    source: fotos[0]
                    anchors.top: parent.top
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width - 40
                    height: parent.height - 40
                    fillMode: Image.PreserveAspectFit
                }
                Label {
                    id: itemTitulo
                    anchors.top: thumb.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.bold: true
                    text: nombre
                }
                Label {
                    anchors.top: itemTitulo.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "$ " + precio
                    font.pointSize: 9
                }

            }
            onClicked: {
                listadoArticulos.currentIndex = index;
            }
        }
    }
}
