import QtQuick 1.0
import "Components.js" as Util

Rectangle {
    id: container

    property bool showingBackButton: false
    property int margins: 8
    property string iconSource: "gfx/placeholder_icon.png"
    property alias icon: titleIcon
    property string title: "TITLE"
    property string caption: "CAPTION"
    property string titleImageSoucre: ""
    property string titleFontName: "Helvetica"
    property int titleFontSize: 24
    property color titleFontColor: "black"
    property color titleBackgroundColor: "lightgrey"
    property bool titleFontBold: false
    property string captionFontName: "Helvetica"
    property int captionFontSize: 24
    property color captionFontColor: "black"
    property bool captionFontBold: false
    property color captionBackgoundColor: "white"
    property string exitButtonSource: "gfx/exit_button.png"
    property string exitButtonPressedSource: "gfx/exit_button_pressed.png"
    property string backButtonSource: "gfx/back_button.png"
    property string backButtonPressedSource: "gfx/back_button_pressed.png"

    signal exitButtonClicked
    signal backButtonClicked(string viewName)

    // Default values, change when using
    width: 360
    height: 80
    color: titleBackgroundColor

    Rectangle {
        anchors {
            top: captionText.top
            bottom: captionText.bottom
            left: container.left
            right: container.right
        }
        color: captionBackgoundColor
    }

    Image {
        id: titleIcon
        source: parent.iconSource
        fillMode: "PreserveAspectFit"
        smooth: true
        height: container.height-2*margins
        anchors {
            left: parent.left
            verticalCenter: parent.verticalCenter
            margins: container.margins
        }
    }

    Image {
        id: titleImage
        source: container.titleImageSoucre
        fillMode: "PreserveAspectFit"
        smooth: true
        anchors {
            top: container.top
            left: titleIcon.right
            right: exitButton.left
            bottom: captionText.top
            margins: container.margins
        }
        height: container.height / 2
    }

    Text {
        id: titleText
        smooth: true
        anchors {
            top: container.top
            left: titleIcon.right
            right: exitButton.left
            bottom: captionText.top
            topMargin: container.margins
            leftMargin: container.margins
            rightMargin: container.margins
        }
        height: container.height / 2
        color: container.titleFontColor

        font {
            bold: container.titleFontBold
            family: container.titleFontName
            pointSize: container.titleFontSize
        }

        text: container.title
        elide: Text.ElideLeft
        textFormat: Text.RichText
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    Text {
        id: captionText
        clip: true
        anchors {
            bottom: container.bottom
            left: parent.left
            right: parent.right
            leftMargin: container.margins
            rightMargin: container.margins
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
        horizontalAlignment: Text.AlignHCenter
    }    

    ImageButton {
        id: exitButton
        visible: !showingBackButton        
        width: container.height
        height: container.height
        scale: 0.8
        anchors.top: container.top
        anchors.right: container.right
        anchors.margins: 0
        bgImage: container.exitButtonSource
        bgImagePressed: container.exitButtonPressedSource

        onClicked: {
            container.exitButtonClicked()
        }
    }

    ImageButton {
        visible: showingBackButton
        y: 10
        anchors.top: container.top
        anchors.right: container.right
        anchors.margins: 0
        width: container.height
        height: container.height
        scale: 0.8
        bgImage: container.backButtonSource
        bgImagePressed: container.backButtonPressedSource

        onClicked: {
            container.backButtonClicked(appState.cameFromView)
        }
    }
}
