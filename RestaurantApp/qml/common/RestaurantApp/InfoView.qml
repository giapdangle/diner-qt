import QtQuick 1.0
import "Util.js" as Util

Rectangle {
    id: container
    property string fontName: "Helvetica"
    property int fontSize: 12
    property color fontColor: "black"
    property double margins: 8
    property int reservationHeight: 40
    // Default values, change when using
    width: 360
    height: 640
    color: "lightsteelblue"

    Component.onCompleted: {
        Util.log("InfoView loaded");
    }

    InfoModel {
        id: infoModel
        onStatusChanged: {
            if(status == XmlListModel.Ready) {
                logo.source = infoModel.get(0).logo
                street.text = infoModel.get(0).street
                city.text = infoModel.get(0).city
                country.text = infoModel.get(0).country;
                telephone.text = infoModel.get(0).telephone
                description.text = infoModel.get(0).description
            }
        }
    }

    Component {
        id: reservationDelegate

        Item {
            height: reservationHeight
            width: container.width

            Text {
                id: reservation
                anchors {
                    top: parent.top
                    left: parent.left
                    right: cancelButton.left
                    rightMargin: container.margins
                }
                text: "You have reservation for "+people+((people == 1) ? " person" : " people")+" on "+(new Date(dateTime))
                wrapMode: Text.WordWrap
                color: container.fontColor
                font {
                    family: container.fontName
                    pointSize: container.fontSize
                }
            }
            Button {
                id: cancelButton
                anchors {
                    top: parent.top
                    right: parent.right
                    rightMargin: container.margins
                }
                width: 60
                height: reservationHeight
                text: qsTr("Cancel");
                fontName: container.fontName
                fontSize: container.fontSize
                fontColor: container.fontColor

                //onClicked: cancelReservation()
            }
        }
    }
    Flickable {
        id: flicker
        anchors {
            top: container.top
            left: container.left
            right: container.right
            margins: container.margins
        }

        height: container.height
        contentWidth: width
        contentHeight: column.height
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
                            pointSize: container.fontSize
                        }
                    }
                    Text {
                        id: city
                        color: container.fontColor
                        font {
                            family: container.fontName
                            pointSize: container.fontSize
                        }
                    }
                    Text {
                        id: country
                        color: container.fontColor
                        font {
                            family: container.fontName
                            pointSize: container.fontSize
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

                    Image {
                        id: call_icon
                        source: "gfx/placeholder_icon.png"
                        fillMode: "PreserveAspectFit"
                        smooth: true
                        height: container.height*0.1
                        width: height
                    }
                    Text {
                        id: telephone
                        anchors {
                            bottom: call.bottom
                            left: call_icon.right
                            margins: container.margins
                        }
                        color: container.fontColor
                        font {
                            family: container.fontName
                            pointSize: container.fontSize
                        }
                    }
                    MouseArea {
                        anchors.fill: call
                        onClicked: { Util.log("Invoking a call "+telephone.text); Qt.openUrlExternally("tel:"+telephone.text) }
                    }
                }
            }

            ListView {
                id: reservations
                width: parent.width
                height: count*(reservationHeight+spacing)
                model: reservationsModel
                delegate: reservationDelegate
                interactive: false
                focus: true
                spacing: container.margins
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
                    pointSize: container.fontSize
                }
            }
        }
    }
}
