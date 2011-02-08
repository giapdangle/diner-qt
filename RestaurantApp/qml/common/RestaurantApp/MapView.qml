import QtQuick 1.0
import "Util.js" as Util

Item {
    id: container

    property double latitude: 61.50097409814573
    property double longitude: 23.76720428466797

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
            }
        }
    }

    OviMapTile {
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            margins: 10
        }
        height: width
        latitude: container.latitude
        longitude: container.longitude
    }
}
