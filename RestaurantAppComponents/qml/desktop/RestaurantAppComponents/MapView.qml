import QtQuick 1.1
import com.nokia.symbian 1.1

import "Util.js" as Util

Page {
    id: container

    property string fontName: visual.defaultFontFamily
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

    Image {
        anchors.fill: parent
        source: visual.backgroundImageSource
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

    OviMapTile {
        id: tile

        anchors.centerIn: parent
        width: appState.inLandscape ? 630 : 350
        height: appState.inLandscape ? (visual.isE6 ? 320 : 250) : 520
        latitude: container.latitude
        longitude: container.longitude
        minZoomLevel: container.minZoomLevel
        maxZoomLevel: container.maxZoomLevel
    }
}
