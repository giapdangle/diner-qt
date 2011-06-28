import QtQuick 1.0
import com.nokia.symbian 1.0

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
                city.text = infoModel.get(0).city + ", " + infoModel.get(0).country
                //country.text = infoModel.get(0).country;
                telephone.text = infoModel.get(0).telephone
                description.text = infoModel.get(0).description
            }
        }
    }

    Component {
        id: reservationDelegate

        Item {
            height: 40
            width: container.width-container.margins- 4

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
                    pointSize: visual.infoViewReservationFontSize
                }
            }
//            ImageButton {
//                id: cancelButton
//                anchors {
//                    top: parent.top
//                    right: parent.right
//                    rightMargin: container.margins
//                }
//                height: 40
//                width: 76
//                bgImage: visual.cancelButtonSource
//                bgImagePressed: visual.cancelButtonPressedSource
//                onClicked: { dialog.index = index; dialog.dateTime = dateTime; dialog.show() }
//            }
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
                    height: container.height*0.3
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
                            pointSize: visual.infoViewAddressFontSize
                        }
                    }
                    Text {
                        id: city
                        color: container.fontColor
                        font {
                            family: container.fontName
                            pointSize: visual.infoViewAddressFontSize
                        }
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
//                    ImageButton {
//                        id: call_icon
//                        bgImage: visual.callButtonSource
//                        bgImagePressed: visual.callButtonPressedSource
//                        height: container.height*0.1
//                        width: height
//                        onClicked: { Util.log("Invoking a call "+telephone.text); Qt.openUrlExternally("tel:"+telephone.text) }
//                    }
                    Text {
                        id: telephone
                        anchors {
                            bottom: call.bottom
                            left: call_icon.right
                            margins: container.margins
                        }
                        color: container.fontColorLink
                        font {
                            family: container.fontName
                            pointSize: visual.infoViewFontSize
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: { Util.log("Invoking a call "+telephone.text); Qt.openUrlExternally("tel:"+telephone.text) }
                        }
                    }
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
                    pointSize: visual.infoViewFontSize
                }
            }
        }
    }

//    // ScrollBar indicator. Take the bottommost search field height into account.
//    ScrollBar {
//        id: scrollBar
//        scrollArea: flicker
//        height: flicker.height
//        width: container.scrollBarWidth
//        anchors.right: container.right
//    }

//    ModalDialog {
//        id: dialog
//        text: "Are you sure you want to cancel your reservation on "+dateTime+"?"
//        property string dateTime: ""
//        property int index: 0
//        anchors.fill:  parent
//        fontName: container.fontName
//        fontColor: container.fontColorButton
//        fontColorButton: container.fontColorButton
//        fontSize: container.fontSize
//        buttonBackground: visual.buttonComponent
//        buttonBackgroundPressed: visual.buttonPressedComponent
//        onAccepted: {
//            reservationsModel.remove(index)
//        }
//    }


}
