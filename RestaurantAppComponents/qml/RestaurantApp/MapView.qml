import QtQuick 1.0
import com.nokia.symbian 1.0
//import com.meego 1.0
import "Util.js" as Util

Page {
    id: container

    width: 360
    height: 640

    property int scrollBarWidth: visual.scrollBarWidth
    property string fontName: visual.defaultFontFamily
    property int fontSize: visual.defaultFontSize
    property int infoFontSize: visual.infoFontSize
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
    property int minZoomLevel: 12
    property int maxZoomLevel: 17

    Component.onCompleted: {
        Util.log("MapView loaded");
    }

    Rectangle {
        anchors.fill:  parent
        color: visual.defaultBackgroundColor
    }

    InfoModel {
        id: infoModel

        onStatusChanged: {
            if (status == XmlListModel.Ready) {
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

    Grid {
        columns: appState.inLandscape ? 2 : 1
        rows: appState.inLandscape ? 1 : 2
        spacing: container.margins

        anchors {
            fill: parent
            margins: container.margins
        }

        // First grid item will be the Map tile.
        OviMapTile {
            id: tile

            //width: appState.inLandscape ? prent.width*0.6 : parent.width
            //height: width-100
            x: 20
            width: 350
            height: 262
            latitude: container.latitude
            longitude: container.longitude
            minZoomLevel: container.minZoomLevel
            maxZoomLevel: container.maxZoomLevel
        }

        // Second grid item is the "column of three" (address, phone number & www)
        Column {
            id: info

            spacing: container.margins
            // 1st row containes the address info & button for popup
            // dialog showing the info in detail.
            Item {
                width: container.width
                height: (container.height - 20) / 6

                MouseArea {
                    onClicked: addressDialog.open()
                    anchors.fill: parent

                    Column {
                        id: address

                        anchors.verticalCenter: parent.verticalCenter
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
                    }
                }

                Button {
                    id: zoom_button

                    anchors {
                        right: parent.right
                        rightMargin: container.margins * 3
                        verticalCenter: parent.verticalCenter
                    }
                    iconSource: visual.zoomiInSource
                    onClicked: { addressDialog.open(); }
                }
            }

            // 2nd row has the phone number and a button to make the call.
            Item {
                width: container.width
                height: (container.height - 20) / 6

                Text {
                    id: telephone

                    text: container.telephone
                    color: container.fontColorLink
                    smooth: true
                    anchors {
                        left: parent.left
                        leftMargin: container.margins
                        bottomMargin: container.margins + 10
                        verticalCenter: parent.verticalCenter
                    }

                    font {
                        family: container.fontName
                        pointSize: container.infoFontSize
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: { callDialog.phoneNumber = telephone.text; callDialog.open(); }
                    }
                }

                Button {
                    id: call_button

                    anchors {
                        right: parent.right
                        rightMargin: container.margins * 3
                        verticalCenter: parent.verticalCenter
                    }

                    iconSource: visual.callButtonSource
                    onClicked: { callDialog.phoneNumber = telephone.text; callDialog.open(); }
                }
            }

            // 3rd row has the web address & button to launch the browser.
            Item {
                width: container.width
                height: (container.height - 20) / 6

                Text {
                    id: url

                    text: container.url
                    color: container.fontColorLink
                    smooth: true
                    anchors {
                        left: parent.left
                        leftMargin: container.margins
                        bottomMargin: container.margins + 10
                        verticalCenter: parent.verticalCenter
                    }

                    font {
                        family: container.fontName
                        pointSize: container.infoFontSize
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            wwwDialog.wwwAddress = url.text;
                            wwwDialog.open();
                        }
                    }
                }

                Button {
                    id: www_button

                    anchors {
                        right: parent.right
                        rightMargin: container.margins * 3
                        verticalCenter: parent.verticalCenter
                    }
                    iconSource: visual.wwwButtonSource
                    onClicked: {
                        Util.log("Launched url "+url.text);
                        wwwDialog.wwwAddress = url.text;
                        wwwDialog.open();
                        //Qt.openUrlExternally(url.text)
                    }
                }
            }
        }
    }

    QueryDialog {
        id: addressDialog
        titleText: qsTr("Address")
        message: qsTr(container.street + "\n" + container.city + "\n" + container.country)
        acceptButtonText: qsTr("Ok")
        onAccepted: {
            // Nuthin'.
        }
    }

    QueryDialog {
        id: wwwDialog
        titleText: qsTr("Open in browser")
        message: qsTr("Open " + wwwAddress + " in browser?")
        acceptButtonText: qsTr("Open")
        rejectButtonText: qsTr("Cancel")
        property string wwwAddress: ""
        onAccepted: {
             Qt.openUrlExternally(wwwAddress)
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
