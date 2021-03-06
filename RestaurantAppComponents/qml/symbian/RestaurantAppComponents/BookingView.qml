import QtQuick 1.1
// We are using TimePickerDialog & DatePickerDialog from the com.nokia.extras.
import com.nokia.extras 1.1
import com.nokia.symbian 1.1
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

    Image {
        anchors.fill: parent
        source: visual.backgroundImageSource
    }

    Flickable {
        id: flicker
        anchors.fill: parent

        contentHeight: column.height
        clip: true
        interactive: appState.inLandscape

        FocusScope {
            anchors.fill: parent
            anchors.margins: container.margins*3
            Column {
                id: column
                width: parent.width
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
                            onFocusChanged: console.log("nameEntry focusChanged: "
                                                        + focus)
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
                            onFocusChanged: console.log("phoneEntry focusChanged: "
                                                        + focus)
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
                        text: qsTr("Table for <b>" + personCountSlider.value
                                   + "</b> people")
                    }
                }

                // Picker slider for the person count
                Item {
                    width: parent.width
                    height: personCountSlider.height
                    anchors.horizontalCenter: parent.horizontalCenter

                    Text {
                        id: minimumText
                        anchors.left: parent.left
                        text: personCountSlider.minimumValue
                        font.family: container.fontName
                        font.pixelSize: container.fontSize
                        color: container.fontColor
                        anchors.verticalCenter: personCountSlider.verticalCenter
                        horizontalAlignment: Text.AlignLeft
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
                        anchors.right: parent.right
                        anchors.verticalCenter: personCountSlider.verticalCenter
                        font.family: container.fontName
                        font.pixelSize: container.fontSize
                        color: container.fontColor
                        text: personCountSlider.maximumValue
                        horizontalAlignment: Text.AlignRight
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
                        text: container._year + "-" + container._month
                              + "-" + container._day
                        onClicked: datePicker.open();
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
                } // Time picker column

                Item {
                    id: empty
                    //spacing: container.margins
                    height: visual.defaultItemHeight
                    width: parent.width
                }

            } //Column
        }
    }

    Loader {
        sourceComponent: appState.inLandscape ? scrollBar : undefined
        anchors {
            right: parent.right
            top: parent.top
        }

        Component {
            id: scrollBar
            ScrollDecorator {
                anchors {
                    right: parent.right
                    top: parent.top
                }
                flickableItem: flicker
            }
        }
    }

    DatePickerDialog {
         id: datePicker

         titleText: qsTr("Date")
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

    // Confirmation dialog for actually making the table reservation.
    QueryDialog {
        id: reserveDialog

        // A private date member, just to make the code look a bit cleaner.
        property string _date: container._year +
                               "-" + container._month +
                               "-" + container._day

        titleText: qsTr("Table reservation confirmation")
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
