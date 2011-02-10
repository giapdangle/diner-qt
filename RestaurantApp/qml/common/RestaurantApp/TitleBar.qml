import QtQuick 1.0
import "Components.js" as Util

Rectangle {
    id: container

    signal exitButtonClicked
    signal backButtonClicked(string viewName)

    property bool showingBackButton: false
    property int margin: 8

    property string iconSource: "gfx/placeholder_icon.png"
    property alias icon: titleIcon
    property string title: "TITLE"
    property string caption: "CAPTION"
    property string titleFontName: "Helvetica"
    property int titleFontSize: 24
    property color titleFontColor: "black"
    property bool titleFontBold: false
    property string captionFontName: "Helvetica"
    property int captionFontSize: 24
    property color captionFontColor: "black"
    property bool captionFontBold: false

    // Default values, change when using
    width: 360
    height: 80
    color: "lightgray"

    Rectangle {
        anchors {
            top: captionText.top
            bottom: captionText.bottom
            left: container.left
            right: container.right
        }
        color: "#fffaee"
    }

    Image {
        id: titleIcon
        source: parent.iconSource
        fillMode: "PreserveAspectFit"
        smooth: true
        height: container.height-2*margin
        anchors {
            left: parent.left
            verticalCenter: parent.verticalCenter
            margins: container.margin
        }
    }

    Text {
        id: titleText
        smooth: true
        clip: true
        anchors {
            top: titleIcon.top
            //bottom: titleIcon.bottom
            left: titleIcon.right
            right: exitButton.left
            leftMargin: container.margin
            rightMargin: container.margin
        }
        color: container.titleFontColor

        font {
            bold: container.titleFontBold
            family: container.titleFontName
            pointSize: container.titleFontSize
        }

        text: container.title
        elide: Text.ElideLeft
        textFormat: Text.RichText
        wrapMode: Text.Wrap
        //verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }

    Text {
        id: captionText
        clip: true
        anchors {
            top: titleText.bottom
            //bottom: titleIcon.bottom
            left: titleIcon.right
            right: exitButton.left
            leftMargin: container.margin
            rightMargin: container.margin
        }
        color: container.captionFontColor

        font {
            bold: container.captionFontBold
            family: container.captionFontName
            pointSize: container.captionFontSize
        }
        text: container.caption
        elide: Text.ElideLeft
        textFormat: Text.RichText
        wrapMode: Text.Wrap
        //verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }    

    TitleBarButton {
        id: exitButton
        visible: !showingBackButton        
        width: container.height
        height: container.height
        scale: 0.8
        anchors.top: container.top
        anchors.right: container.right
        anchors.margins: 0
        //x: parent.width - width - y
        bgImage: "gfx/exit_button.png"
        bgImagePressed: "gfx/exit_button_pressed.png";

        onClicked: {
            container.exitButtonClicked()
        }
    }

    TitleBarButton {
        visible: showingBackButton
        y: 10
        anchors.top: container.top
        anchors.right: container.right
        anchors.margins: 0
        width: container.height
        height: container.height
        scale: 0.8
        //x: parent.width - width - y
        bgImage: "gfx/back_button.png"
        bgImagePressed: "gfx/back_button_pressed.png";

        onClicked: {
            container.backButtonClicked(appState.cameFromView)
        }
    }
}
