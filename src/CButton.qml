import QtQuick 2.10
import QtQuick.Controls 2.2

Item {
    property string iconName: ""
    property string color: "white"
    ToolButton {
        contentItem: Text {
            font.family: "fontawesome"
            text: iconName
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            color: color
        }
    }
}
