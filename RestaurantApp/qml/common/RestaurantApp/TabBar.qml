import QtQuick 1.0

Item {
    id: container

    signal tabButtonClicked(string targetView, string buttonName);

    property bool wide: true

    property int gap: !wide ? (container.height-buttonCount*buttonHeight)/(buttonCount+1) : (container.width-buttonCount*buttonWidth)/(buttonCount+1)

    property int margins: 8
    property int buttonCount: 4

    property int buttonWidth: !wide ? container.width : container.height
    property int buttonHeight: !wide ? container.width-2*margins : container.height-2*margins

    property bool show: true
    property string selectedButton: button1.buttonName  // Initially focus the 1st button

    property string fontName: "Helvetica"
    property int fontSize: 14
    property color fontColor: "black"
    property color backgroundBarColor: "white"

    property string button1Background: "gfx/button.png"
    property string button1BackgroundSelected: "gfx/button_pressed.png"
    property alias button1Text: button1.text

    property string button2Background: "gfx/button.png"
    property string button2BackgroundSelected: "gfx/button_pressed.png"
    property alias button2Text: button2.text

    property string button3Background: "gfx/button.png"
    property string button3BackgroundSelected: "gfx/button_pressed.png"
    property alias button3Text: button3.text

    property string button4Background: "gfx/button.png"
    property string button4BackgroundSelected: "gfx/button_pressed.png"
    property alias button4Text: button4.text

    // Default values, change when using
    width: 360
    height: 100

    Rectangle {
        width: !wide ? container.width*0.4 : undefined
        height: wide ? container.height*0.4 : undefined
        anchors {
            top: !wide ? container.top : undefined
            bottom: !wide ? container.bottom : undefined
            horizontalCenter: !wide ? container.horizontalCenter : undefined
            left: !wide ? undefined :  container.left
            right: !wide ?  undefined : container.right
            verticalCenter: !wide ? undefined : container.verticalCenter
        }
        color: backgroundBarColor
    }


    Grid {
        rows: wide ? 1 : buttonCount
        columns: wide ? buttonCount : 1

        anchors {
            left: wide ? container.left : undefined
            right: wide ? container.right : undefined
            verticalCenter: !wide ? container.verticalCenter : undefined
            leftMargin: gap
            rightMargin: gap
        }
        spacing: container.gap

        ImageButton {
            id: button1
            buttonName: "infoButton"
            target: "infoView"
            width: buttonWidth
            height: buttonHeight
            active: container.selectedButton === buttonName
            bgImage: container.button1Background
            bgImagePressed: container.button1BackgroundSelected
            fontName: container.fontName
            fontSize: container.fontSize
            fontColor: container.fontColor
            onClicked: { container.selectedButton = buttonName; container.tabButtonClicked(target, buttonName) }
        }
        ImageButton {
            id: button2
            buttonName: "menuButton"
            target: "menuGridView"
            width: buttonWidth
            height: buttonHeight
            active: container.selectedButton === buttonName
            bgImage: container.button2Background
            bgImagePressed: container.button2BackgroundSelected
            fontName: container.fontName
            fontSize: container.fontSize
            fontColor: container.fontColor
            onClicked: { container.selectedButton = buttonName; container.tabButtonClicked(target, buttonName) }
        }
        ImageButton {
            id: button3
            buttonName: "mapButton"
            target: "mapView"
            width: buttonWidth
            height: buttonHeight
            active: container.selectedButton === buttonName
            bgImage: container.button3Background
            bgImagePressed: container.button3BackgroundSelected
            fontName: container.fontName
            fontSize: container.fontSize
            fontColor: container.fontColor
            onClicked: { container.selectedButton = buttonName; container.tabButtonClicked(target, buttonName) }
        }
        ImageButton {
            id: button4
            buttonName: "bookingButton"
            target: "bookingView"
            width: buttonWidth
            height: buttonHeight
            active: container.selectedButton === buttonName
            bgImage: container.button4Background
            bgImagePressed: container.button4BackgroundSelected
            fontName: container.fontName
            fontSize: container.fontSize
            fontColor: container.fontColor
            onClicked: { container.selectedButton = buttonName; container.tabButtonClicked(target, buttonName) }
        }
    }

}
