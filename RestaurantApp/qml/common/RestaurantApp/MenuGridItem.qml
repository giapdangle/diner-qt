import QtQuick 1.0

Item {
    id: container

    property int margins: 10
    property string fontName: "Helvetica"
    property int fontSize: 10
    property color fontColor: "black"
    property int textHeight: 20

    signal clicked(string itemId, string title, string iconSource)

    width: 120
    height: column.height

    Column {
        id: column
        x: 0; y: 0
        width: parent.width

        Image {
            id: icon
            source: iconSource
            fillMode: Image.PreserveAspectFit
            smooth: true
            width: container.width*0.7
            height: width
            anchors.horizontalCenter: parent.horizontalCenter
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
    }
    MouseArea {
        anchors.fill: parent
        onClicked: container.clicked(itemId, title, iconSource);
        onPressed: container.opacity = 0.5
        onReleased: container.opacity = 1
        // onPosChanged handler is a workaround to an issue where the item stays
        // "selected" (i.e. mousearea stays pressed for some reason, and does not
        // change to released correctly) when flicking scrolling the grid.
        onPositionChanged: container.opacity = 1
    }
}
