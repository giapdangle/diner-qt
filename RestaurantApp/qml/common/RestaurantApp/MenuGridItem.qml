import QtQuick 1.0

Item {
    id: container

    property int margins: 10
    property string fontName: "Helvetica"
    property int fontSize: 32
    property color fontColor: "black"

    width: 120
    height: 120

    Rectangle {
        anchors{
            fill: parent
            margins: container.margins
        }

        radius: 10
        color: "steelblue"
        Text {
            anchors.centerIn: parent
            text: title
            font {
                family: container.fontName
                pointSize: container.fontSize
            }
            color: container.fontColor
        }
    }
}
