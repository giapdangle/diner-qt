import QtQuick 1.0
import com.nokia.symbian 1.0
import "Components.js" as Util

Rectangle {
    id: container

    property int margins: 8
    property string iconSource: "gfx/placeholder_icon.png"
    property string caption: "CAPTION"
    property string captionFontName: "Helvetica"
    property int captionFontSize: 24
    property color captionFontColor: "black"
    property bool captionFontBold: false
    property color captionBackgoundColor: "white"

//    property bool showingBackButton: false
//    property alias icon: titleIcon
//    property string title: "TITLE"
//    property string titleImageSource: ""
//    property string titleFontName: "Helvetica"
//    property int titleFontSize: 24
//    property color titleFontColor: "black"
//    property color titleBackgroundColor: "lightgrey"
//    property bool titleFontBold: false
//    property string exitButtonSource: "gfx/exit_button.png"
//    property string exitButtonPressedSource: "gfx/exit_button_pressed.png"
//    property string backButtonSource: "gfx/back_button.png"
//    property string backButtonPressedSource: "gfx/back_button_pressed.png"

//    signal exitButtonClicked
//    signal backButtonClicked(string viewName)

    // Default values, change when using
    width: 360
    height: 25
    color: captionBackgoundColor

    Text {
        id: captionText

        anchors {
            bottom: container.bottom
            left: parent.left
            right: parent.right
            leftMargin: container.margins
            rightMargin: container.margins
        }

        font {
            bold: container.captionFontBold
            family: container.captionFontName
            pointSize: container.captionFontSize
        }

        clip: true
        color: container.captionFontColor
        text: container.caption
        elide: Text.ElideLeft
        textFormat: Text.RichText
        horizontalAlignment: Text.AlignHCenter
    }

//    Rectangle {
//        anchors {
//            top: captionText.top
//            bottom: captionText.bottom
//            left: container.left
//            right: container.right
//        }
//        color: captionBackgoundColor
//    }

//    Image {
//        id: titleIcon
//        source: parent.iconSource
//        fillMode: "PreserveAspectFit"
//        smooth: true
//        height: container.height-2*margins
//        anchors {
//            left: parent.left
//            verticalCenter: parent.verticalCenter
//            margins: container.margins
//        }
//    }

//    Image {
//        id: titleImage
//        source: container.titleImageSource
//        fillMode: "PreserveAspectFit"
//        smooth: true
//        anchors {
//            top: container.top
//            left: titleIcon.right
//            right: exitButton.left
//            bottom: captionText.top
//            margins: container.margins
//        }
//        height: container.height / 2
//    }

//    Text {
//        id: titleText
//        smooth: true
//        anchors {
//            top: container.top
//            left: titleIcon.right
//            right: exitButton.left
//            bottom: captionText.top
//            topMargin: container.margins
//            leftMargin: container.margins
//            rightMargin: container.margins
//        }
//        height: container.height / 2
//        color: container.titleFontColor

//        font {
//            bold: container.titleFontBold
//            family: container.titleFontName
//            pointSize: container.titleFontSize
//        }

//        text: container.title
//        elide: Text.ElideLeft
//        textFormat: Text.RichText
//        horizontalAlignment: Text.AlignHCenter
//        verticalAlignment: Text.AlignVCenter
//    }

//    Button {
//        id: exitButton
//        visible: !showingBackButton
//        anchors.top: container.top
//        anchors.right: container.right
//        anchors.margins: 10
//        iconSource: pressed ? container.exitButtonPressedSource : container.exitButtonSource
//        onClicked: {
//            container.exitButtonClicked()
//        }
//    }

//    Button {
//        visible: showingBackButton
//        y: 10
//        anchors.top: container.top
//        anchors.right: container.right
//        anchors.margins: 10
////        scale: 0.8
//        iconSource: pressed ? container.backButtonPressedSource : container.backButtonSource

//        onClicked: {
//            container.backButtonClicked(appState.cameFromView)
//        }
//    }
}
