import QtQuick 1.0

Item {
    id: container

    signal clicked(string itemId, string title, string iconSource)

    property int margins: 10
    property string fontName: "Helvetica"
    property int fontSize: 10
    property color fontColor: "black"
    property int textHeight: 20

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
    }
}
