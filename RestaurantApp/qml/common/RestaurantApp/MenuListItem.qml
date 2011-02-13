import QtQuick 1.0

Item {
    id: container

    signal clicked(string itemId)

    property int spacing: 0
    property string itemId: "NOT SET"
    property int margins: 8
    property string fontName: "Helvetica"
    property int fontSize: 8
    property color fontColor: "black"

    width: 360
    height: 60

    Rectangle {
        anchors{
            fill: parent
            margins: container.margins
        }

        radius: 5
        color: "#f9f6f6"
        clip: true
        Row {
            x: 0; y: 0
            width:  parent.width
            height: parent.height
            spacing: container.spacing

            Image {
                id: icon
                source: iconSource
                height: parent.height
                width: height
            }

            Text {
                width: parent.width - icon.width
                height: parent.height
                text: title
                wrapMode: Text.WordWrap
                font {
                    family: container.fontName
                    pointSize: container.fontSize
                }
                color: container.fontColor
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
            }
        }
        MouseArea {
            anchors.fill:  parent
            onClicked: container.clicked(container.itemId);
        }
    }
}
