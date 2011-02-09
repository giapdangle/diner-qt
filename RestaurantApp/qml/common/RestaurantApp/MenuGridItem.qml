import QtQuick 1.0

Item {
    id: container

    signal clicked(string itemId)

    property int margins: 10
    property string fontName: "Helvetica"
    property int fontSize: 10
    property color fontColor: "black"
    property int textHeight: 20

    width: 120
    height: width + textHeight

    Item {
        anchors{
            fill: parent
            margins: container.margins
        }

        clip: true
        Column {
            x: 0; y: 0
            width: parent.width
            height: parent.height

            Image {
                id: icon
                source: "content/" + iconSource
                width: parent.width
                height: parent.height - container.textHeight
            }

            Text {
                id: label
                width: parent.width
                text: title
                height: container.textHeight
                wrapMode: Text.WordWrap
                font {
                    family: container.fontName
                    pointSize: container.fontSize
                }
                color: container.fontColor
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
            MouseArea {
                anchors.fill:  parent
                onClicked: container.clicked(itemId);
            }
        }
    }
}
