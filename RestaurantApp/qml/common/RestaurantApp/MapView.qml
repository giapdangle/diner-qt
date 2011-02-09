import QtQuick 1.0
import "Util.js" as Util

Item {
    id: container

    property int scrollBarWidth: 8
    property string fontName: "Helvetica"
    property int fontSize: 13
    property color fontColor: "black"
    property double margins: 8

    property double latitude: 61.50097409814573
    property double longitude: 23.76720428466797

    property string street: ""
    property string city: ""
    property string country: ""
    property string telephone: ""
    property string url: ""
    property string minZoomLevel: ""
    property string maxZoomLevel: ""
    // Default values, change when using
    width: 360
    height: 640

    Component.onCompleted: {
        Util.log("MapView loaded");
    }

    InfoModel {
        id: infoModel
        onStatusChanged: {
            if(status == XmlListModel.Ready) {
                Util.log("Model ready");
                container.latitude = infoModel.get(0).latitude;
                container.longitude = infoModel.get(0).longitude;
                container.street = infoModel.get(0).street;
                container.city = infoModel.get(0).city;
                container.country = infoModel.get(0).country;
                container.telephone = infoModel.get(0).telephone;
                container.url = infoModel.get(0).url
                container.minZoomLevel = infoModel.get(0).minZoomLevel;
                container.maxZoomLevel = infoModel.get(0).maxZoomLevel;
            }
        }
    }

    Column {
        id: column
        spacing: container.margins
        anchors {
            fill:  parent
            margins: 10
        }
        OviMapTile {
            width: parent.width
            height: width-100
            latitude: container.latitude
            longitude: container.longitude
            minZoomLevel: container.minZoomLevel
            maxZoomLevel: container.maxZoomLevel
        }

        Rectangle {
            id: addressBox
            property bool zoomedIn: false
            height: info.height+2*container.margins
            width: info.width+2*container.margins
            color: "gold"
            x: -width/4
            y: -height/4
            scale: 0.5

            Column {
                id: info
                anchors.centerIn: parent
                spacing: 8
                Column {
                    id: address
                    spacing: 4
                    Text {
                        id: street
                        text: container.street
                        color: container.fontColor
                        font {
                            family: container.fontName
                            pointSize: 2*container.fontSize
                        }
                        smooth: true
                    }
                    Text {
                        id: city
                        text: container.city
                        color: container.fontColor
                        font {
                            family: container.fontName
                            pointSize: 2*container.fontSize
                        }
                        smooth: true
                    }
                    Text {
                        id: country
                        text: container.country
                        color: container.fontColor
                        font {
                            family: container.fontName
                            pointSize: 2*container.fontSize
                        }
                        smooth: true
                    }
                }
                Item {
                    id: call

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
                        text: container.telephone
                        anchors {
                            bottom: call.bottom
                            left: call_icon.right
                            rightMargin: container.margins
                        }
                        color: container.fontColor
                        font {
                            family: container.fontName
                            pointSize: 2*container.fontSize
                        }
                    }
                    MouseArea {
                        anchors.fill: call
                        onClicked: { Util.log("Invoking a call "+telephone.text); Qt.openUrlExternally("tel:"+telephone.text) }
                    }
                }
                Item {
                    id: www

                    height: www_icon.height
                    width: www_icon.width+telephone.width

                    Image {
                        id: www_icon
                        source: "gfx/placeholder_icon.png"
                        fillMode: "PreserveAspectFit"
                        smooth: true
                        height: container.height*0.1
                        width: height
                    }
                    Text {
                        id: url
                        text: container.url
                        anchors {
                            bottom: www.bottom
                            left: www_icon.right
                            rightMargin: container.margins
                        }
                        color: container.fontColor
                        font {
                            family: container.fontName
                            pointSize: 2*container.fontSize
                        }
                    }
                    MouseArea {
                        anchors.fill: www
                        onClicked: { Util.log("Launched url "+url.text); Qt.openUrlExternally(url.text) }
                    }
                }
            }

            MouseArea {
                x: address.x; y: address.y; width: addressBox.width; height: address.height
                onClicked: addressBox.zoomedIn = !addressBox.zoomedIn
            }

            Behavior on scale { NumberAnimation { duration: 200 } }            
            transitions: Transition { AnchorAnimation { duration: 100 } }

            states: State {
                name: "zoomedIn"; when: addressBox.zoomedIn
                PropertyChanges { target: addressBox; scale: 1.0;}
                AnchorChanges { target: addressBox; anchors.horizontalCenter: column.horizontalCenter; anchors.verticalCenter: column.verticalCenter }
            }
        }
    }
}
