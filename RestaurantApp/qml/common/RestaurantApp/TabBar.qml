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

            fontName: container.fontName
            fontSize: container.fontSize
            fontColor: container.fontColor

            onClicked: container.tabButtonClicked(target, button);
        }
        Button {
            buttonName: "menuButton"
            target: "menuListView"
            width: buttonWidth
            height: buttonHeight
            text: qsTr("Menu");

            fontName: container.fontName
            fontSize: container.fontSize
            fontColor: container.fontColor

            onClicked: container.tabButtonClicked(target, button);
        }
        Button {
            buttonName: "mapButton"
            target: "mapView"
            width: buttonWidth
            height: buttonHeight
            text: qsTr("Map");

            fontName: container.fontName
            fontSize: container.fontSize
            fontColor: container.fontColor

            onClicked: container.tabButtonClicked(target, button);
        }
        Button {
            buttonName: "bookingButton"
            target: "bookingView"
            width: buttonWidth
            height: buttonHeight
            text: qsTr("Book");

            fontName: container.fontName
            fontSize: container.fontSize
            fontColor: container.fontColor

            onClicked: container.tabButtonClicked(target, button);
        }
    }

}
