import QtQuick 1.1
import com.nokia.symbian 1.1
import "Util.js" as Util

Page {
    id: container

    property string fontName: visual.defaultFontFamily
    property color fontColor: visual.defaultFontColor
    property color fontColorLink: visual.defaultFontColorLink
    property color fontColorButton: visual.defaultFontColorButton
    property double margins: visual.margins
    property int reservationHeight: visual.infoViewReservationItemHeight

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
                city.text = infoModel.get(0).city
                country.text = infoModel.get(0).country
                telephone.text = infoModel.get(0).telephone
                description.text = infoModel.get(0).description
                openDays.text = "Open\nMon to Thu:\nFriday:\nSaturday:\nSunday:"
                openHours.text = "\n11-22\n11-23\n13-23\n14-21"
            }
        }
    }

    Component {
        id: reservationDelegate

        Item {
            height: container.reservationHeight
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
                    leftMargin: container.margins*2
                }
                text: "You have reservation for "
                      + people + ((people == 1) ? " person" : " people")
                      + " on " + dateTime
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
                onClicked: {
                    cancelDialog.index = index;
                    cancelDialog.dateTime = dateTime;
                    cancelDialog.open()
                }
            }
        }
    }

    Image {
        anchors.fill: parent
        source: visual.backgroundImageSource
    }

    Flickable {
        id: flicker
        anchors {
            fill: container
        }

        contentWidth: width
        contentHeight: column.height
        clip: true
        Column {
            id: column
            width: parent.width
            spacing: container.margins
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
                margins: container.margins
            }

            Item {
                height: logo.height
                width: parent.width

                Image {
                    id: logo
                    fillMode: "PreserveAspectFit"
                    smooth: true
                    height: appState.inLandscape ? container.height*0.4
                                                 : container.height*0.25
                    width: height
                }

                Flow {
                    id: address
                    anchors {
                        left: logo.right
                        top: logo.top
                        margins: container.margins
                    }
                    width: container.width*0.3
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
                        top: address.top
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
                        top: address.bottom
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
                        verticalAlignment: visual.isE6 ? Text.AlignTop
                                                       : Text.AlignVCenter
                        color: container.fontColorLink
                        font {
                            family: container.fontName
                            pixelSize: visual.infoViewFontSize
                        }
                        MouseArea {
                            anchors.fill: parent

                            onClicked: {
                                Util.log("Invoking a call "+telephone.text);
                                Qt.openUrlExternally("tel:"+telephone.text);
                            }
                        }
                    }
                }

                Button {
                    id: call_icon

                    anchors {
                        right: parent.right
                        rightMargin: container.margins
                        verticalCenter: visual.isE6 ? undefined
                                                    : call.verticalCenter
                        bottom: visual.isE6 ? call.verticalCenter : undefined
                    }
                    iconSource: visual.callButtonSource

                    onClicked: {
                        Util.log("Invoking a call "+telephone.text);
                        Qt.openUrlExternally("tel:"+telephone.text);
                    }
                }
            }

            Rectangle {
                visible: reservations.height > 0
                height: 1
                width: column.width
                color: fontColor
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
                interval: 5000
                running: true
                repeat: true
                onTriggered: {
                    if (!reservations.moving && reservations.count > 2) {
                        reservations.incrementCurrentIndex();
                    }
                }
            }

            Rectangle {
                height: 1
                width: column.width
                color: fontColor
            }

            Text {
                id: description
                wrapMode: Text.WordWrap
                textFormat: Text.RichText
                width: column.width
                color: container.fontColor
                font {
                    family: container.fontName
                    pixelSize: visual.infoViewFontSize
                }
                onLinkActivated: {
                    Util.log("Launched url "+link);
                    Qt.openUrlExternally(link);
                }
            }

            // Restaurant opening days & hours and a delicious image.
            Item {
                width: column.width
                height: openDays.height*1.2
                anchors.top: description.bottom
                anchors.topMargin: container.margins

                Text {
                    id: openDays
                    anchors.left: parent.left
                    color: container.fontColor
                    font {
                        family: container.fontName
                        pixelSize: visual.infoViewFontSize
                    }
                }
                Text {
                    id: openHours
                    anchors.left: openDays.right
                    anchors.right: infoImg.left
                    color: container.fontColor
                    font {
                        family: container.fontName
                        pixelSize: visual.infoViewFontSize
                    }

                    horizontalAlignment: Text.AlignHCenter
                }
                Image {
                    id: infoImg

                    height: parent.height * 0.88
                    width: height
                    fillMode: Image.PreserveAspectFit
                    anchors.right: parent.right
                    anchors.rightMargin: container.margins*3
                    smooth: true
                    source: visual.foodTeaserSource
                }
            }
        }
    }

    ScrollDecorator {
        id: scrollBar
        flickableItem: flicker
        anchors {
            right: parent.right
            top: parent.top
        }
    }

    QueryDialog {
        id: cancelDialog
        titleText: qsTr("Remove reservation?")
        message: qsTr("Are you sure you want to cancel your reservation on "
                      + dateTime + "?")
        acceptButtonText: qsTr("Remove")
        rejectButtonText: qsTr("Cancel")
        property string dateTime: ""
        property int index: 0
        onAccepted: {
            reservationsModel.remove(index)
        }
    }
}
