import QtQuick 1.0

Flickable {
    id: container

    property int panoramaWidth:  1600
    property int panoramaHeight: 640
    property alias titleBarColor: titleBar.color
    property alias titleBarTextColor: titleText.color
    property alias titleBarText: titleText.text
    property alias titleBarOpacity: titleBar.opacity

    property alias headerBarOpacity: headerBar.opacity
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
        color: container.titleBarColor
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
            font.pixelSize: 42
            color: container.titleBarColor
        }
    }

    Rectangle {
        id: headerBar
        x: 0
        y: titleBar.y + titleBar.height
        width:  parent.width
        height: 80
        opacity: 0.85
        color: "white"
    }

}
