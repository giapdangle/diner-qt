import QtQuick 1.0
import com.nokia.symbian 1.0
import com.nokia.extras 1.0
import "Util.js" as Util

Page {
    id: container

    property string fontName: visual.defaultFontFamily
    property int fontSize: visual.bookingViewFontSize
    property color fontColor: visual.defaultFontColor
    property color fontColorLink: visual.defaultFontColorLink
    property color fontColorButton: visual.defaultFontColorButton
    property int margins: 4

    signal actionCompleted()
    function done() {
        reserveDialog.open();
    }
    function cancel() {
        container.actionCompleted();
    }

    // Internal attributes, do not change from outside!
    // Used in adding the reservation.
    property variant _currentDate: new Date()
    property int _year: _currentDate.getFullYear()
    property int _month: _currentDate.getMonth()
    property int _day: _currentDate.getDate()
    property string _hour: "18:00"

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
                anchors.topMargin: container.margins * 2

                Text {
                    font.family: container.fontName
                    font.pixelSize: container.fontSize
                    color: container.fontColor
                    text: qsTr("Table for <b>" + personCountSlider.value + "</b> people")
                }
            }

            // Picker slider for the person count
            Item {
                width: parent.width
                height: personCountSlider.height
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
                    anchors.right: parent.right
                    anchors.verticalCenter: personCountSlider.verticalCenter
                    font.family: container.fontName
                    font.pixelSize: container.fontSize
                    color: container.fontColor
                    text: personCountSlider.maximumValue
                }
            } // Slider picker row

            // Date picker column
            Column {
                width: parent.width
                spacing: container.margins

                Text {
                    id: dateText


                    font.family: container.fontName
                    font.pixelSize: container.fontSize
                    color: container.fontColor
                    text: qsTr("Date: ")
                }

                Button {
                    height: visual.defaultItemHeight
                    width: parent.width
                    text: container._year + "-" + container._month + "-" + container._day
                    onClicked: datePicker.open();
                }

                DatePickerDialog {
                     id: datePicker

                     titleText: qsTr("Date of birth")
                     acceptButtonText: qsTr("Accept")
                     rejectButtonText: qsTr("Reject")

                     year: container._year
                     month: container._month
                     day: container._day

                     onAccepted: {
                         container._year = datePicker.year;
                         container._month = datePicker.month;
                         container._day = datePicker.day
                     }
                 }
            } // Date picker column

            // Time picker column
            Column {
                width: parent.width
                spacing: container.margins

                Text {
                    font.family: container.fontName
                    font.pixelSize: container.fontSize
                    color: container.fontColor
                    text: qsTr("Time: ")
                }

                Button {
                    height: visual.defaultItemHeight
                    width: parent.width
                    text: container._hour

                    onClicked: timePicker.open()
                }

                TimePickerDialog {
                    id: timePicker

                    titleText: qsTr("Available times")
                    acceptButtonText: qsTr("Accept")
                    rejectButtonText: qsTr("Reject")
                    fields: DateTime.Hours

                    onAccepted: {
                        container._hour = timePicker.hour + ":00"
                    }
                }
            } // Time picker column

            Item {
                id: empty
                //spacing: container.margins
                height: visual.defaultItemHeight
                width: parent.width
            }

        } //Column
    }

    // Confirmation dialog for actually making the table reservation.
    QueryDialog {
        id: reserveDialog

        // A private date member, just to make the code look a bit cleaner.
        property string _date: container._year +
                               "-" + container._month +
                               "-" + container._day

        titleText: qsTr("Table reservation step 2/2")
        message: qsTr("Reserve a table under '" + nameEntry.text + "' for " +
                      personCountSlider.value + " people on " + _date + ", " +
                      container._hour)
        acceptButtonText: qsTr("Reserve")
        rejectButtonText: qsTr("Cancel")

        onAccepted: {
            reservationsModel.addReservation(
                        nameEntry.text, phoneEntry.text,
                        personCountSlider.value,
                        _date + ", " + container._hour);
            // Accepted, emit signal in order to continue.
            actionCompleted();
        }
    }
}
