import QtQuick 1.0

Item {
    id: container

    property int margins: 10
    property string fontName: "Helvetica"
    property int fontSize: 18
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
        clip: true
        Text {
            anchors.fill: parent
            text: title
            wrapMode: Text.WordWrap
            font {
                family: container.fontName
                pointSize: container.fontSize
            }
            color: container.fontColor
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }
    }
}
