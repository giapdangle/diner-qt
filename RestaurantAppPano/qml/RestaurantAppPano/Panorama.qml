import QtQuick 1.0

Flickable {
    id: container

    property int panoramaWidth:  1440
    property int panoramaHeight: 640
    property alias titleBarColor: titleBar.color
    property alias titleBarOpacity: titleBar.opacity
    property alias titleBarTextColor: titleText.color
    property alias titleBarText: titleText.text
    property int titleBarTextSize: 48


    property alias headerBarColor: headerBar.color
    property color headerBarTextColor: "black"
    property alias headerBarOpacity: headerBar.opacity
    property int headerBarTextSize: 32

    property ListModel headerModel

    width: 360
    height: 640

    contentWidth: panoramaWidth
    contentHeight: panoramaHeight
    boundsBehavior: Flickable.StopAtBounds

    Image {
        id: backgroundImage
        x: 0; y: 0
        source: "panorama_background.png";
    }

    Rectangle {
        id: titleBar
        x: 0; y: 0
        width: parent.width
        height: 80
        color: "darkGray"
        opacity: 0.85
        Text {
            id: titleText
            x: 0
            y: 0
            verticalAlignment: Text.AlignVCenter
            text: container.titleBarText
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.left: parent.left
            font.pixelSize: container.titleBarTextSize
            color: container.titleBarColor
        }
    }

    Rectangle {
        id: headerBar
        x: 0
        y: titleBar.y + titleBar.height
        width:  parent.width
        height: 80
        opacity: 1.0
        color: "lightGray"
        Row {
            Repeater {
                model: headerModel

                Item {
                    width: headerBar.width / headerModel.count
                    height: headerBar.height
                    Text {
                        anchors.centerIn: parent
                        text: title
                        color :container.headerBarTextColor
                        font.pixelSize: container.headerBarTextSize
                    }
                }
            }
        }
    }

}
