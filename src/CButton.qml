import QtQuick 2.10
import QtQuick.Controls 2.2
ToolButton {
    property alias color: texto.color
    property alias icono: texto.text
    contentItem: Text {
        id: texto
        font.family: "fontawesome"
        text: icon
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        color: color
        font.pointSize: 18
    }
}

