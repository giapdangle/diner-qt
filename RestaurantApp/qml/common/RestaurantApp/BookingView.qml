import QtQuick 1.0
import "Util.js" as Util

Item {
    id:container
    // Default values, change when using
    width: 360
    height: 640    

    property string fontName: visual.defaultFontFamily
    property int fontSize: visual.defaultFontSize
    property color fontColor: visual.defaultFontColor
    property color fontColorLink: visual.defaultFontColorLink
    property color fontColorButton: visual.defaultFontColorButton
    property int margins: 8

    Component.onCompleted: {
        Util.log("BookingView loaded");
    }

    Column {
        anchors.fill:  parent
        anchors.margins: container.margins
        spacing: 1.5*container.margins
        Column {
            width: parent.width
            spacing: container.margins
            Text {
                width: parent.width
                font.family: container.fontName
                font.pointSize: container.fontSize
                color: container.fontColor
                text: "Name"
            }
            TextEntry {
                id: nameEntry
                width: parent.width
                height: visual.defaultItemHeight
                fontName: container.fontName
                fontColor: container.fontColor
                fontSize: container.fontSize
                bg: visual.textFieldComponent
                bgActive: visual.textFieldActiveComponent
                //bgImage: visual.textFieldSource
                //bgImageActive: visual.textFieldSource
                text:"Melanie Eats"
            }
        }
        Column {
            width: parent.width
            spacing: container.margins
            Text {
                width: parent.width
                font.family: container.fontName
                font.pointSize: container.fontSize
                color: container.fontColor
                text: qsTr("Phone number")
            }
            TextEntry {
                id:phoneEntry
                width:parent.width
                height: visual.defaultItemHeight
                fontName: container.fontName
                fontColor: container.fontColor
                fontSize: container.fontSize
                bg: visual.textFieldComponent
                bgActive: visual.textFieldActiveComponent
                //bgImage: visual.textFieldSource
                //bgImageActive: visual.textFieldSource
                text:"914-499-1900"
            }
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
            NumberReel {
                id: numberReel
                height: visual.defaultItemHeight
                fontName: container.fontName
                fontColor: container.fontColorButton
                fontSize: container.fontSize
            }
            Text {
                anchors.verticalCenter: parent.verticalCenter
                font.family: container.fontName
                font.pointSize: container.fontSize
                color: container.fontColor
                text: qsTr("people")
            }
        }
        Column {
            width: parent.width
            spacing: container.margins
            Row {
                spacing: container.margins
                width: parent.width

                Text {
                    id: yearText
                    width: (parent.width-2*parent.spacing)*0.4
                    font.family: container.fontName
                    font.pointSize: container.fontSize
                    color: container.fontColor
                    text: qsTr("Year")
                }
                Text {
                    id: monthText
                    width: (parent.width-2*parent.spacing)*0.3
                    font.family: container.fontName
                    font.pointSize: container.fontSize
                    color: container.fontColor
                    text: qsTr("Month")
                }
                Text {
                    id: dayText
                    width: (parent.width-2*parent.spacing)*0.3
                    font.family: container.fontName
                    font.pointSize: container.fontSize
                    color: container.fontColor
                    text: qsTr("Day")
                }
            }
            DateReel {
                id: dateReel
                width: parent.width
                height: visual.defaultItemHeight
                fontName: container.fontName
                fontColor: container.fontColorButton
                fontSize: container.fontSize
            }
        }
        Column {
            width: parent.width
            spacing: container.margins
            Text {
                anchors.left:  timeReel.left
                font.family: container.fontName
                font.pointSize: container.fontSize
                color: container.fontColor
                text: qsTr("Available times")
            }
            TimeReel {
                id: timeReel
                width: parent.width
                height: visual.defaultItemHeight
                fontName: container.fontName
                fontColor: container.fontColorButton
                fontSize: container.fontSize
            }
        }
        Button {
            width: parent.width
            height: visual.defaultItemHeight
            fontName: container.fontName
            fontColor: container.fontColorButton
            fontSize: container.fontSize
            text: qsTr("Make reservation")
            onClicked: dialog.show()
            bg: visual.buttonComponent
            bgPressed: visual.buttonPressedComponent
            //bgImage: visual.buttonSource
            //bgImagePressed: visual.buttonPressedSource
        }
    } //Column

    ModalDialog {
        id: dialog
        text: "Tables for "+numberReel.number() +" people, " + dateReel.date() + ", " + timeReel.time()
        anchors.fill:  parent
        fontName: container.fontName
        fontColor: container.fontColorButton
        fontColorButton: container.fontColorButton
        fontSize: container.fontSize
        buttonBackground: visual.buttonComponent
        buttonBackgroundPressed: visual.buttonPressedComponent
        onAccepted: {
            reservationsModel.addReservation(nameEntry.text, phoneEntry.text, numberReel.number(), dateReel.date() +", "+ timeReel.time())
        }
    }

}
