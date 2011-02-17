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
    property int margins: 4

    Component.onCompleted: {
        Util.log("BookingViewLandscape loaded");
    }


    Column {
        anchors.fill:  parent
        anchors.margins: container.margins
        spacing: 1.3*container.margins

        Row {
            width: parent.width
            spacing: 1.3*container.margins

            Column {
                width: parent.width/2
                spacing: container.margins

                Text {
                    width: parent.width
                    font.family: container.fontName
                    font.pointSize: container.fontSize
                    color: container.fontColor
                    text: qsTr("Name")
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
                    text: qsTr("")
                    focus: true
                    KeyNavigation.down: phoneEntry
                }
            }
            Column {
                width: parent.width/2
                spacing: container.margins
                Text {
                    width: parent.width
                    font.family: container.fontName
                    font.pointSize: container.fontSize
                    color: container.fontColor
                    text: qsTr("Phone number")
                }
                TextEntry {
                    id: phoneEntry
                    width: parent.width
                    height: visual.defaultItemHeight
                    fontName: container.fontName
                    fontColor: container.fontColor
                    fontSize: container.fontSize
                    bg: visual.textFieldComponent
                    bgActive: visual.textFieldActiveComponent
                    text: qsTr("");
                    KeyNavigation.up: nameEntry
                }
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
                itemBackground: visual.buttonComponent
                itemBackgroundPressed: visual.buttonPressedComponent                
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
                    width: dateReel.width*0.4
                    font.family: container.fontName
                    font.pointSize: container.fontSize
                    color: container.fontColor
                    text: qsTr("Year")
                }
                Text {
                    width: dateReel.width*0.3
                    font.family: container.fontName
                    font.pointSize: container.fontSize
                    color: container.fontColor
                    text: qsTr("Month")
                }
                Text {
                    width: dateReel.width*0.3
                    font.family: container.fontName
                    font.pointSize: container.fontSize
                    color: container.fontColor
                    text: qsTr("Day")
                }
                Text {
                    font.family: container.fontName
                    font.pointSize: container.fontSize
                    color: container.fontColor
                    text: qsTr("Available times")
                }
            }
            Row {
                width: parent.width
                spacing: container.margins
                DateReel {
                    id: dateReel
                    width: parent.width*0.6
                    height: visual.defaultItemHeight
                    fontName: container.fontName
                    fontColor: container.fontColorButton
                    fontSize: container.fontSize
                    itemBackground: visual.buttonComponent
                    itemBackgroundPressed: visual.buttonPressedComponent                    
                }
                TimeReel {
                    id: timeReel
                    width: parent.width*0.4
                    height: visual.defaultItemHeight
                    //anchors.horizontalCenter: parent.horizontalCenter
                    fontName: container.fontName
                    fontColor: container.fontColorButton
                    fontSize: container.fontSize
                    itemBackground: visual.buttonComponent
                    itemBackgroundPressed: visual.buttonPressedComponent                    
                }
            }

        }
        Button {
            width: parent.width*0.7
            anchors.horizontalCenter: parent.horizontalCenter
            height: visual.defaultItemHeight
            fontName: container.fontName
            fontColor: container.fontColorButton
            fontSize: container.fontSize
            text: qsTr("Make reservation")
            onClicked: { dialog.show(); numberReel.close(); dateReel.closeAll(); timeReel.close() }
            bg: visual.buttonComponent
            bgPressed: visual.buttonPressedComponent
        }
    } //Column


    ModalDialog {
        id: dialog
        text: "Table for " + numberReel.getNumber() + " people, " + dateReel.getDate() + ", " + timeReel.getTime()
        anchors.fill:  parent
        fontName: container.fontName
        fontColor: container.fontColorButton
        fontColorButton: container.fontColorButton
        fontSize: container.fontSize
        buttonBackground: visual.buttonComponent
        buttonBackgroundPressed: visual.buttonPressedComponent
        onAccepted: {
            reservationsModel.addReservation(nameEntry.text, phoneEntry.text, numberReel.getNumber(), dateReel.getDate() +", "+ timeReel.getTime())
        }
        z: 1000
    }

}
