import QtQuick 1.0

Item {
    id: container

    signal tabButtonClicked(string targetView, string buttonName);

    // To adjust the navibar:
    // Adjust the gap you want between buttons, it will be applied as margin as well
    // Set the button count to how many Buttons you add
    // Width of the buttons is calculated automatically
    property int gap: (container.width-buttonCount*buttonWidth)/(buttonCount+1)
    property int margins: 8
    property int buttonCount: 4
    //property int buttonWidth: ((container.width - ( (buttonCount-1)*container.gap)) / buttonCount);
    property int buttonHeight: container.height-2*margins
    property int buttonWidth: container.height
    property bool show: true
    property string selectedButton: "infoButton"

    property string fontName: "Helvetica"
    property int fontSize: 14
    property color fontColor: "black"
    property color backgroundBarColor: "white"

    property string infoButtonSource: "content/info_button.png"
    property string menuButtonSource: "content/menu_button.png"
    property string mapButtonSource: "content/map_button.png"
    property string bookingButtonSource: "content/booking_button.png"

    property string infoButtonPressedSource: "content/info_button_pressed.png"
    property string menuButtonPressedSource: "content/menu_button_pressed.png"
    property string mapButtonPressedSource: "content/map_button_pressed.png"
    property string bookingButtonPressedSource: "content/booking_button_pressed.png"

    // Default values, change when using
    width: 360
    height: 100

    Rectangle {
        height: container.height*0.4
        anchors {
            left: container.left
            right: container.right
            verticalCenter: container.verticalCenter
        }
        color: backgroundBarColor
    }

    Row {
        anchors {
            left: container.left
            right: container.right
            verticalCenter: container.verticalCenter
            leftMargin: gap
            rightMargin: gap
        }
        spacing: container.gap

        ImageButton {
            buttonName: "infoButton"
            target: "infoView"
            width: buttonWidth
            height: buttonHeight
            active: container.selectedButton === buttonName
            bgImage: infoButtonSource
            bgImagePressed: infoButtonPressedSource
            onClicked: { container.selectedButton = buttonName; container.tabButtonClicked(target, buttonName) }
        }
        ImageButton {
            buttonName: "menuButton"
            target: "menuGridView"
            width: buttonWidth
            height: buttonHeight
            active: container.selectedButton === buttonName
            bgImage: menuButtonSource
            bgImagePressed: menuButtonPressedSource
            onClicked: { container.selectedButton = buttonName; container.tabButtonClicked(target, buttonName) }
        }
        ImageButton {
            buttonName: "mapButton"
            target: "mapView"
            width: buttonWidth
            height: buttonHeight
            active: container.selectedButton === buttonName
            bgImage: mapButtonSource
            bgImagePressed: mapButtonPressedSource
            onClicked: { container.selectedButton = buttonName; container.tabButtonClicked(target, buttonName) }
        }
        ImageButton {
            buttonName: "bookingButton"
            target: "bookingView"
            width: buttonWidth
            height: buttonHeight
            active: container.selectedButton === buttonName
            bgImage: bookingButtonSource
            bgImagePressed: bookingButtonPressedSource
            onClicked: { container.selectedButton = buttonName; container.tabButtonClicked(target, buttonName) }
        }
    }

}
