import QtQuick 1.0
import com.nokia.symbian 1.0
import "Util.js" as Util

Page {
    id: container

    property string fontName: visual.defaultFontFamily
    property int fontSize: visual.defaultFontSize
    property color fontColor: visual.defaultFontColor
    property color fontColorLink: visual.defaultFontColorLink
    property color fontColorButton: visual.defaultFontColorButton
    property double margins: visual.margins
    property int reservationHeight: 48
    property int scrollBarWidth: visual.scrollBarWidth

    signal reservationClicked()

    width: 360
    height: 640

    Component.onCompleted: {
        Util.log("InfoView loaded");
    }

    InfoModel {
        id: infoModel
        onStatusChanged: {
            if (status == XmlListModel.Ready) {
                logo.source = infoModel.get(0).logo
                street.text = infoModel.get(0).street
                city.text = infoModel.get(0).city //+ ", " + infoModel.get(0).country
                country.text = infoModel.get(0).country
                telephone.text = infoModel.get(0).telephone
                description.text = infoModel.get(0).description
                // VKN TODO! GET THE OPENING DAYS & HOURS FROM THE MODEL!
                openDays.text = "Open\nMon to Thu:\nFriday:\nSaturday:\nSunday:"
                openHours.text = "\n11-22\n11-23\n13-23\n14-21"
            }
        }
    }

    Component {
        id: reservationDelegate

        Item {
            height: 40
            width: container.width-container.margins - 4

            Image {
                id: reservation_icon
                height: 42
                width: 44
                source: visual.bookingIconSource
                fillMode: Image.PreserveAspectFit
                smooth: true
                anchors {
                    top: parent.top
                    left: parent.left
                }
            }

            Text {
                id: reservation
                anchors {
                    top: parent.top
                    left: reservation_icon.right
                    right: cancelButton.left
                    rightMargin: container.margins
                    leftMargin: container.margins
                }
                text: "You have reservation for "+people+((people == 1) ? " person" : " people")+" on "+dateTime
                wrapMode: Text.WordWrap
                color: container.fontColor
                font {
                    family: container.fontName
                    pixelSize: visual.infoViewReservationFontSize
                }
            }
            // Use toolbutton if you want to be able to make it flat
            Button {
                id: cancelButton
                anchors {
                    top: parent.top
                    right: parent.right
                    rightMargin: container.margins
                }
                text: qsTr("Cancel")
                onClicked: { cancelDialog.index = index; cancelDialog.dateTime = dateTime; cancelDialog.open() }
            }
        }
    }

    Rectangle {
        anchors.fill:  parent
        color: visual.defaultBackgroundColor
    }

    Flickable {
        id: flicker
        anchors {
            fill: container
            margins: container.margins
        }

        contentWidth: width
        contentHeight: column.height
        clip: true
        Column {
            id: column
            width: parent.contentWidth
            spacing: container.margins

            Item {
                height: logo.height
                width: parent.width

                Image {
                    id: logo
                    fillMode: "PreserveAspectFit"
                    smooth: true
                    height: container.height*0.25
                    width: height
                }

                Flow {
                    id: address
                    anchors {
                        left: logo.right
                        bottom: call.top
                        margins: container.margins
                    }
                    width:  container.width*0.3
                    spacing: 4
                    Text {
                        id: street
                        color: container.fontColor
                        font {
                            family: container.fontName
                            pixelSize: visual.infoViewAddressFontSize
                        }
                    }
                    Text {
                        id: city
                        color: container.fontColor
                        font {
                            family: container.fontName
                            pixelSize: visual.infoViewAddressFontSize
                        }
                    }
                    Text {
                        id: country
                        color: container.fontColor
                        font {
                            family: container.fontName
                            pixelSize: visual.infoViewAddressFontSize
                        }
                    }
                }

                Button {
                    id: reserve_button

                    anchors {
                        right: parent.right
                        rightMargin: container.margins
                        verticalCenter: address.verticalCenter
                    }
                    iconSource: visual.bookingButtonSource
                    onClicked: {
                        // Trigger Tab -change to BookingView
                        appState.cameFromView = "InfoView"
                        reservationClicked();
                    }
                }

                Item {
                    id: call
                    anchors {
                        left: logo.right
                        bottom: logo.bottom
                        margins: container.margins
                    }

                    height: call_icon.height
                    width: call_icon.width+telephone.width

                    Text {
                        id: telephone
                        anchors {
                            bottom: call.bottom
                            verticalCenter: parent.verticalCenter
                        }
                        verticalAlignment: Text.AlignVCenter
                        color: container.fontColorLink
                        font {
                            family: container.fontName
                            pixelSize: visual.infoViewFontSize
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: { callDialog.phoneNumber = telephone.text; callDialog.open() }
                        }
                    }
                }

                Button {
                    id: call_icon

                    anchors {
                        right: parent.right
                        rightMargin: container.margins
                        verticalCenter: call.verticalCenter
                    }
                    iconSource: visual.callButtonSource
                    onClicked: { callDialog.phoneNumber = telephone.text; callDialog.open() }
                }
            }

            ListView {
                id: reservations
                width: parent.width
                height: (count < 2 ? count : 2)*(reservationHeight+spacing)
                model: reservationsModel
                delegate: reservationDelegate
                clip: true
                spacing: container.margins
                keyNavigationWraps: true
                preferredHighlightBegin: 0
                preferredHighlightEnd: reservationHeight
                highlightRangeMode: ListView.StrictlyEnforceRange
                onMovementEnded: presenter.restart
            }

            Timer {
                id: presenter
                interval: 5000; running: true; repeat: true
                onTriggered: if (!reservations.moving && reservations.count > 2) reservations.incrementCurrentIndex()
            }

            Rectangle {
                height: 1
                width: flicker.width
                color: fontColor
            }

            Text {
                id: description
                wrapMode: Text.WordWrap
                width: flicker.width
                color: container.fontColor
                font {
                    family: container.fontName
                    pixelSize: visual.infoViewFontSize
                }
            }

            // Restaurant opening days & hours and a delicious image.
            Item {
                width: flicker.width
                height: 140
                anchors.top: description.bottom
                anchors.topMargin: container.margins

                Text {
                    id: openDays
                    width: 120
                    anchors.left: parent.left
                    color: container.fontColor
                    font {
                        family: container.fontName
                        pixelSize: visual.infoViewFontSize
                    }
                }
                Text {
                    id: openHours
                    width: 80
                    anchors.left: openDays.right
                    color: container.fontColor
                    font {
                        family: container.fontName
                        pixelSize: visual.infoViewFontSize
                    }
                }
                Image {
                    id: infoImg
                    fillMode: Image.PreserveAspectFit
                    anchors.left: openHours.right
                    // VKN TODO! CHANGE THIS!
                    source: "content/placeholder_food.png"
                }
            }
        }
    }

    ScrollBar {
        id: scrollBar
        flickableItem: flicker
        interactive: false
        anchors {
            right: parent.right
            top: parent.top
        }
    }

    QueryDialog {
        id: cancelDialog
        titleText: qsTr("Remove reservation?")
        message: qsTr("Are you sure you want to cancel your reservation on "+dateTime+"?")
        acceptButtonText: qsTr("Remove")
        rejectButtonText: qsTr("Cancel")
        property string dateTime: ""
        property int index: 0
        onAccepted: {
            reservationsModel.remove(index)
        }
    }

    QueryDialog {
        id: callDialog
        titleText: qsTr("Call restaurant")
        message: qsTr("Call the restaurant at "+phoneNumber+"?")
        acceptButtonText: qsTr("Call")
        rejectButtonText: qsTr("Cancel")
        property string phoneNumber: ""
        onAccepted: {
            Util.log("Invoking a call "+telephone.text); Qt.openUrlExternally("tel:"+telephone.text)
        }
    }
}
