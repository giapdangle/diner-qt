import QtQuick 1.0
import "Util.js" as Util

Item {
    id: container

    property int scrollBarWidth: 8
    property string fontName: visual.defaultFontFamily
    property int fontSize: visual.defaultFontSize
    property int infoFontSize: visual.defaultFontSize*2-4 // Zoomed size
    property color fontColor: visual.defaultFontColor
    property color fontColorLink: visual.defaultFontColorLink
    property double margins: visual.margins

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

    Flickable {
        anchors.fill: parent
        contentWidth: parent.width
        contentHeight: tile.height + addressBox.height

    Column {
        id: column
        spacing: container.margins
        anchors {
            fill:  parent
            margins: container.margins
        }
        OviMapTile {
            id: tile
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
            height: info.height+4*container.margins
            width: info.width+4*container.margins
            color: "transparent"
            radius: 20

            transform: Scale {
                id: addressScale;
                origin.x: 0; origin.y: 0
                xScale: 0.7; yScale: 0.7
                Behavior on xScale { NumberAnimation { duration: 200 } }
                Behavior on yScale { NumberAnimation { duration: 200 } }
            }

            Column {
                id: info
                anchors.centerIn: parent
                spacing: container.margins
                Column {
                    id: address
                    spacing: 4
                    Text {
                        id: street
                        text: container.street
                        color: container.fontColor
                        font {
                            family: container.fontName
                            pointSize: container.infoFontSize
                        }
                        smooth: true
                    }
                    Text {
                        id: city
                        text: container.city
                        color: container.fontColor
                        font {
                            family: container.fontName
                            pointSize: container.infoFontSize
                        }
                        smooth: true
                    }
                    Text {
                        id: country
                        text: container.country
                        color: container.fontColor
                        font {
                            family: container.fontName
                            pointSize: container.infoFontSize
                        }
                        smooth: true
                    }
                }/*
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
                        smooth: true
                        anchors {
                            bottom: call.bottom
                            left: call_icon.right
                            leftMargin: container.margins
                        }
                        color: container.fontColorLink
                        font {
                            family: container.fontName
                            pointSize: container.infoFontSize
                        }
                    }
                    MouseArea {
                        anchors.fill: call
                        onClicked: { Util.log("Invoking a call "+telephone.text); Qt.openUrlExternally("tel:"+telephone.text) }
                    }
                }*/
                Item {
                    id: call
                    height: call_button.height
                    width: call_button.width+telephone.width
                    ImageButton {
                        id: call_button
                        bgImage: visual.callButtonSource
                        bgImagePressed: visual.callButtonPressedSource
                        height: container.height*0.1
                        width: height
                        onClicked: { Util.log("Invoking a call "+telephone.text); Qt.openUrlExternally("tel:"+telephone.text) }
                    }
                    Text {
                        id: telephone
                        text: container.telephone
                        color: container.fontColorLink
                        smooth: true
                        anchors {
                            bottom: call.bottom
                            left: call_button.right
                            leftMargin: container.margins
                        }
                        font {
                            family: container.fontName
                            pointSize: container.infoFontSize
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: { Util.log("Invoking a call "+telephone.text); Qt.openUrlExternally("tel:"+telephone.text) }
                        }
                    }
                }

                Item {
                    id: www

                    height: www_button.height
                    width: www_button.width+url.width

                    ImageButton {
                        id: www_button
                        bgImage: visual.wwwButtonSource
                        bgImagePressed: visual.wwwButtonPressedSource
                        height: container.height*0.1
                        width: height
                        onClicked: { Util.log("Launched url "+url.text); Qt.openUrlExternally(url.text) }
                    }
                    Text {
                        id: url                        
                        text: container.url
                        color: container.fontColorLink
                        smooth: true
                        anchors {
                            bottom: www.bottom
                            left: www_button.right
                            leftMargin: container.margins
                        }
                        font {
                            family: container.fontName
                            pointSize: container.infoFontSize
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: { Util.log("Launched url "+url.text); Qt.openUrlExternally(url.text) }
                        }
                    }
                }
            }

            Image {
                id: zoom_icon
                source: addressBox.zoomedIn ? visual.zoomiOutSource : visual.zoomiInSource
                smooth: true
                anchors {
                    top: addressBox.top
                    right: addressBox.right
                    margins: container.margins
                }
            }


            MouseArea {
                x: address.x; y: address.y; width: addressBox.width; height: address.height
                onClicked: addressBox.zoomedIn = !addressBox.zoomedIn
            }

            Behavior on color { ColorAnimation { duration: 200 } }
            transitions: Transition { AnchorAnimation { duration: 200 } }

            states: State {
                name: "zoomedIn"; when: addressBox.zoomedIn
                PropertyChanges { target: addressBox; color: "white"}
                PropertyChanges { target: addressScale; xScale: 1.0; yScale: 1.0 }
                AnchorChanges { target: addressBox; anchors.horizontalCenter: column.horizontalCenter;
                                anchors.verticalCenter: column.verticalCenter; }
            }
        }
    }

    } // Flickable
}
