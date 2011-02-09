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
                    pixelSize: container.fontSize
                }
            }
            Button {
                id: cancelButton
                anchors.top: parent.top
                anchors.right: parent.right
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

    Column {
        anchors.fill: container
        anchors.margins: container.margins
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
                        pixelSize: container.fontSize
                    }
                }
                Text {
                    id: city
                    color: container.fontColor
                    font {
                        family: container.fontName
                        pixelSize: container.fontSize
                    }
                }
                Text {
                    id: country
                    color: container.fontColor
                    font {
                        family: container.fontName
                        pixelSize: container.fontSize
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
                        pixelSize: container.fontSize
                    }
                }
                MouseArea {
                    anchors.fill: call
                    onClicked: { console.log("call"); Qt.openUrlExternally("tel:"+telephone) }
                }
            }
        }

        ListView {
            id: reservations            
            width: container.width
            height: count*(reservationHeight+spacing)
            model: reservationsModel
            delegate: reservationDelegate
            interactive: false
            focus: true
            spacing: container.margins
        }

        Rectangle {
            height: 1
            anchors {
                left: parent.left
                right: parent.right
            }
            color: fontColor
        }

        Text {
            id: description
            wrapMode: Text.WordWrap
            anchors {
                left: parent.left
                right: parent.right
            }
            color: container.fontColor
            font {
                family: container.fontName
                pixelSize: 0
            }
        }
    }
}
