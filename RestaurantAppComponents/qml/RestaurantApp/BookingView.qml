import QtQuick 1.0
import com.nokia.symbian 1.1
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
                        font.pixelSize: container.fontSize
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
                        font.pixelSize: container.fontSize
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
                anchors.topMargin: container.margins
                anchors.leftMargin: container.margins
                anchors.rightMargin: container.margins
                anchors.horizontalCenter: parent.horizontalCenter
                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    font.family: container.fontName
                    font.pixelSize: container.fontSize
                    color: container.fontColor
                    text: qsTr("Table for <b>" + personCountSlider.value + "</b> people")
                }

            }
            Row {
                spacing: 10
                width: parent.width
                anchors.margins: container.margins
                anchors.horizontalCenter: parent.horizontalCenter
                Text {
                    width: 20
                    id: minimumText
                    anchors.left: parent.left
                    text: personCountSlider.minimumValue
                    font.family: container.fontName
                    font.pixelSize: container.fontSize
                    color: container.fontColor
                    anchors.verticalCenter: personCountSlider.verticalCenter
                }

                Slider {
                    id: personCountSlider
                    minimumValue: 1
                    maximumValue: 12
                    stepSize: 1
                    anchors.left: minimumText.right
                    anchors.right: maximumText.left
                }

                Text {
                    id: maximumText
                    width: 20
                    anchors.right:  parent.right
                    anchors.verticalCenter: personCountSlider.verticalCenter
                    font.family: container.fontName
                    font.pixelSize: container.fontSize
                    color: container.fontColor
                    text: personCountSlider.maximumValue
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
                        font.pixelSize: container.fontSize
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
                        font.pixelSize: container.fontSize
                        color: container.fontColor
                        text: qsTr("Month")
                    }
                    Text {
                        id: dayText
                        width: (parent.width-2*parent.spacing)*0.3
                        font.family: container.fontName
                        font.pixelSize: container.fontSize
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
                    //anchors.left:  timeReel.left
                    font.family: container.fontName
                    font.pixelSize: container.fontSize
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
                onClicked: {
                    // TODO get these
                    reserveDialog.personCount = 1
                    reserveDialog.date = "2011-06-24"
                    reserveDialog.time = "16:00"
                    reserveDialog.name = "Riussi"
                    reserveDialog.open();
                }
            }
        } //Column


        QueryDialog {
            id: reserveDialog
            titleText: qsTr("Make reservation")
            message: qsTr("Reserve a table under '" + name + "' for " + personCount + " people on " + date + ", " + time)
            acceptButtonText: qsTr("Reserve")
            rejectButtonText: qsTr("Cancel")
            property string name: ""
            property string phoneNumber: ""
            property int personCount: 0
            property string date: ""
            property string time: ""
            onAccepted: {
                reservationsModel.addReservation(name, phoneEntry.text, personCount, date +", "+ time)
            }
        }

    }
}
