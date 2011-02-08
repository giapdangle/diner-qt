import QtQuick 1.0

Item {
    id: container

    signal clicked(string itemId)

    property string itemId: "NOT SET"
    property int margins: 10
    property string fontName: "Helvetica"
    property int fontSize: 10
    property color fontColor: "black"

    width: 360
    height: 60

    Rectangle {
        anchors{
            fill: parent
            margins: container.margins
        }

        radius: 5
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
        MouseArea {
            anchors.fill:  parent
            onClicked: container.clicked(container.itemId);
        }
    }
}
