import QtQuick 1.0

Item {
    id: container

    property string itemId: "NOT SET"
    property int margins: 8
    property int spacing: 8
    property string fontName: "Helvetica"
    property int fontSize: 12
    property color fontColorTitle: "black"
    property color fontColor: "darkgrey"

    signal clicked(string itemId)

    width: 360
    height: dishTitle.height+dishDescription.height

    Column {
        x: 0; y: 0
        width:  parent.width
        height: parent.height
        spacing: container.spacing

        Text {
            id: dishTitle
            anchors {
                left: parent.left
                right: parent.right
                leftMargin: container.margins
                rightMargin: container.margins
            }

            text: title
            wrapMode: Text.WordWrap
            font {
                family: container.fontName
                pointSize: container.fontSize
                capitalization: Font.AllUppercase
            }
            color: container.fontColorTitle
        }

        Text {
            id: dishDescription
            anchors {
                left: parent.left
                right: parent.right
                leftMargin: container.margins
                rightMargin: container.margins
            }
            text: description
            wrapMode: Text.WordWrap
            font {
                family: container.fontName
                pointSize: container.fontSize
            }
            color: container.fontColor
        }
    }
    MouseArea {
        anchors.fill:  parent
        onClicked: container.clicked(container.itemId);
    }
}
