import QtQuick 1.0
import com.nokia.symbian 1.0
import "Util.js" as Util

Page {
    id:container

    property string fontName: visual.defaultFontFamily
    property int fontSize: visual.defaultFontSize
    property color fontColor: visual.defaultFontColor
    property color fontColorLink: visual.defaultFontColorLink
    property color fontColorButton: visual.defaultFontColorButton
    property int margins: 4

    width: 360
    height: 640

    Component.onCompleted: {
        Util.log("BookingViewPortrait loaded");
    }

    Rectangle {
        anchors.fill:  parent
        color: visual.defaultBackgroundColor
    }

    FocusScope {
        anchors.fill:  parent
        Column {
            anchors.fill:  parent
            anchors.margins: container.margins
            spacing: 1.3*container.margins

            Column {
                width: parent.width
                spacing: 1.3*container.margins

                Column {
                    id: nameEntryColumn
                    width: parent.width
                    spacing: container.margins

                    Text {
                        width: parent.width
                        font.family: container.fontName
                        font.pointSize: container.fontSize
                        color: container.fontColor
                        text: qsTr("Name")
                    }
                    TextField {
                        id: nameEntry
                        width: parent.width
                        height: visual.defaultItemHeight
                        text: qsTr("")
                        focus: true
                        KeyNavigation.down: phoneEntry
                        onFocusChanged: console.log("nameEntry  focusChanged: " + focus)
                    }
                }
                Column {
                    id: phoneEntryColumn
                    width: parent.width
                    spacing: container.margins
                    Text {
                        width: parent.width
                        font.family: container.fontName
                        font.pointSize: container.fontSize
                        color: container.fontColor
                        text: qsTr("Phone number")
                    }
                    TextField {
                        id: phoneEntry
                        width: parent.width
                        height: visual.defaultItemHeight
                        text: qsTr("");
                        focus: false
                        KeyNavigation.up: nameEntry
                        onFocusChanged: console.log("phoneEntry focusChanged: " + focus)
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
                ToolButton {
                    height: visual.defaultItemHeight
                }

                //                NumberReel {
                //                    id: numberReel
                //                    height: visual.defaultItemHeight
                //                    fontName: container.fontName
                //                    fontColor: container.fontColorButton
                //                    fontSize: container.fontSize
                //                    itemBackground: visual.buttonComponent
                //                    itemBackgroundPressed: visual.buttonPressedComponent
                //                }
                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    font.family: container.fontName
                    font.pointSize: container.fontSize
                    color: container.fontColor
                    text: qsTr("people")
                }
            }
            Row {
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
                    ToolButton {
                        height: visual.defaultItemHeight
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
                //                DateReel {
                //                    id: dateReel
                //                    width: parent.width
                //                    height: visual.defaultItemHeight
                //                    fontName: container.fontName
                //                    fontColor: container.fontColorButton
                //                    fontSize: container.fontSize
                //                    itemBackground: visual.buttonComponent
                //                    itemBackgroundPressed: visual.buttonPressedComponent
                //                }
            }
            Row {
                width: parent.width
                spacing: container.margins
                Text {
                    anchors.left:  timeReel.left
                    font.family: container.fontName
                    font.pointSize: container.fontSize
                    color: container.fontColor
                    text: qsTr("Available times")
                }
                ToolButton {
                    height: visual.defaultItemHeight
                }
                //                TimeReel {
                //                    id: timeReel
                //                    width: parent.width*0.4
                //                    height: visual.defaultItemHeight
                //                    anchors.horizontalCenter: parent.horizontalCenter
                //                    fontName: container.fontName
                //                    fontColor: container.fontColorButton
                //                    fontSize: container.fontSize
                //                    itemBackground: visual.buttonComponent
                //                    itemBackgroundPressed: visual.buttonPressedComponent
                //                }
            }
            Button {
                width: parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                height: visual.defaultItemHeight
                text: qsTr("Make reservation")
                onClicked: dialog.show()
            }
        } //Column


        //        ModalDialog {
        //            id: dialog
        //            text: "Table for " + numberReel.getNumber() + " people, " + dateReel.getDate() + ", " + timeReel.getTime()
        //            anchors.fill:  parent
        //            fontName: container.fontName
        //            fontColor: container.fontColorButton
        //            fontColorButton: container.fontColorButton
        //            fontSize: container.fontSize
        //            buttonBackground: visual.buttonComponent
        //            buttonBackgroundPressed: visual.buttonPressedComponent
        //            onAccepted: {
        //                reservationsModel.addReservation(nameEntry.text, phoneEntry.text, numberReel.getNumber(), dateReel.getDate() +", "+ timeReel.getTime())
        //            }
        //            z: 1000
        //        }
    }
}
