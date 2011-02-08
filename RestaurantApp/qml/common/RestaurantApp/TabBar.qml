import QtQuick 1.0

Item {
    id: container

    signal tabButtonClicked(string targetView, string buttonName);

    // To adjust the navibar:
    // Adjust the gap you want between buttons, it will be applied as margin as well
    // Set the button count to how many Buttons you add
    // Width of the buttons is calculated automatically
    property int gap: 10
    property int buttonCount: 4
    property int buttonWidth: ((container.width - ( (buttonCount-1)*container.gap)) / buttonCount);
    property int buttonHeight: container.height - 2*gap
    property bool show: true
    property string selectedButton: "infoButton"

    property string fontName: "Helvetica"
    property int fontSize: 14
    property color fontColor: "black"

    // Default values, change when using
    width: 360
    height: 100

    Row {
        anchors {
            topMargin: container.gap
            fill: parent
        }
        spacing: container.gap

        Button {
            buttonName: "infoButton"
            target: "infoView"
            width: buttonWidth
            height: buttonHeight
            text: qsTr("Info");            
            active: container.selectedButton === buttonName

            fontName: container.fontName
            fontSize: container.fontSize
            fontColor: container.fontColor

            onClicked: { container.selectedButton = buttonName; container.tabButtonClicked(target, buttonName) }
        }
        Button {
            buttonName: "menuButton"
            target: "menuGridView"
            width: buttonWidth
            height: buttonHeight
            text: qsTr("Menu");
            active: container.selectedButton === buttonName

            fontName: container.fontName
            fontSize: container.fontSize
            fontColor: container.fontColor

            onClicked: { container.selectedButton = buttonName; container.tabButtonClicked(target, buttonName) }
        }
        Button {
            buttonName: "mapButton"
            target: "mapView"
            width: buttonWidth
            height: buttonHeight
            text: qsTr("Map");
            active: container.selectedButton === buttonName

            fontName: container.fontName
            fontSize: container.fontSize
            fontColor: container.fontColor

            onClicked: { container.selectedButton = buttonName; container.tabButtonClicked(target, buttonName) }
        }
        Button {
            buttonName: "bookingButton"
            target: "bookingView"
            width: buttonWidth
            height: buttonHeight
            text: qsTr("Book");
            active: container.selectedButton === buttonName

            fontName: container.fontName
            fontSize: container.fontSize
            fontColor: container.fontColor

            onClicked: { container.selectedButton = buttonName; container.tabButtonClicked(target, buttonName) }
        }
    }

}
