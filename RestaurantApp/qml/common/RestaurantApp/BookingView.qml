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
            text: "Phone number"
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
            anchors.margins: container.margins
            anchors.horizontalCenter: parent.horizontalCenter
            Text {
                anchors.verticalCenter: parent.verticalCenter
                font.family: container.fontName
                font.pointSize: container.fontSize
                color: container.fontColor
                text: "Table for"
            }
            TextEntry {
                id:peopleEntry
                anchors.verticalCenter: parent.verticalCenter
                width:50
                fontName: container.fontName
                fontColor: container.fontColor
                fontSize: container.fontSize
                text:"20"
            }
            Text {
                anchors.verticalCenter: parent.verticalCenter
                font.family: container.fontName
                font.pointSize: container.fontSize
                color: container.fontColor
                text: "people"
            }
        }
        /*
        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            Column {
                Text {
                    font.family: container.fontName
                    font.pointSize: container.fontSize
                    color: container.fontColor
                    text: "Year"
                }
                Text { text: "2011" }
            }
            Column {
                Text {
                    font.family: container.fontName
                    font.pointSize: container.fontSize
                    color: container.fontColor
                    text: "Month"
                }
                Text { text: "2" }
            }
            Column {
                Text {
                    font.family: container.fontName
                    font.pointSize: container.fontSize
                    color: container.fontColor
                    text: "Day"
                }
                Text { text: "20" }
            }
        }
            */
        DateReel {
            anchors.horizontalCenter: parent.horizontalCenter
            //clip: true
        }
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            font.family: container.fontName
            font.pointSize: container.fontSize
            color: container.fontColor
            text: "Available times"
        }
        TimeReel {
            anchors.horizontalCenter: parent.horizontalCenter
            id: timeReel
          //  clip: true

        }
        Button {
            width: parent.width
            text: "Make reservation"
        }
    } //Column
}
