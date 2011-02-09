import QtQuick 1.0
import "Util.js" as Util

Rectangle {
    id:container
    // Default values, change when using
    width: 360
    height: 640
    color: "turquoise"

    property string fontName: "Helvetica"
    property int fontSize: 14
    property color fontColor: "black"
    property int margins: 10

    Component.onCompleted: {
        Util.log("BookingView loaded");
    }

    Column {
        anchors.fill:  parent
        anchors.margins: container.margins
        spacing: 4
        Text {
            width:parent.width
            font.family: container.fontName
            font.pointSize: container.fontSize
            color: container.fontColor
            text: "Name"
        }
        TextEntry {
            id: nameEntry
            width:parent.width
            fontName: container.fontName
            fontColor: container.fontColor
            fontSize: container.fontSize
            text:"Melanie Eats"
        }
        Text {
            width:parent.width
            font.family: container.fontName
            font.pointSize: container.fontSize
            color: container.fontColor
            text: qsTr("Phone number")
        }
        TextEntry {
            id:phoneEntry
            width:parent.width
            fontName: container.fontName
            fontColor: container.fontColor
            fontSize: container.fontSize
            text:"914-499-1900"
        }

        Row {
            spacing: 10
            anchors.margins: container.margins
            anchors.horizontalCenter: parent.horizontalCenter
            Text {
                anchors.verticalCenter: parent.verticalCenter
                font.family: container.fontName
                font.pointSize: container.fontSize
                color: container.fontColor
                text: qsTr("Table for")
            }
            NumberReel { id: numberReel }
            Text {
                anchors.verticalCenter: parent.verticalCenter
                font.family: container.fontName
                font.pointSize: container.fontSize
                color: container.fontColor
                text: qsTr("people")
            }
        }
        DateReel {
            id: dateReel
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            font.family: container.fontName
            font.pointSize: container.fontSize
            color: container.fontColor
            text: qsTr("Available times")
        }
        TimeReel {
            anchors.horizontalCenter: parent.horizontalCenter
            id: timeReel
        }
        Button {
            width: parent.width
            text: qsTr("Make reservation")
            onClicked: dialog.show()
        }
    } //Column


    ModalDialog {
        id: dialog
        text: "Tables for "+numberReel.selectedNumber() +" people, " + dateReel.selectedDate() + ", " + timeReel.getSelectedTime()
        anchors.fill:  parent
    }

}
