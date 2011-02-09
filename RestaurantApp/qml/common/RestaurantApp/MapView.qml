import QtQuick 1.0
import "Util.js" as Util

Item {
    id: container

    property int scrollBarWidth: 8

    property double latitude: 61.50097409814573
    property double longitude: 23.76720428466797

    property string street: ""
    property string city: ""
    property string country: ""
    property string telephone: ""
    property string description: ""
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
                container.street = infoModel.get(0).street
                container.city = infoModel.get(0).city
                container.country = infoModel.get(0).country;
                container.telephone = infoModel.get(0).telephone
                container.description = infoModel.get(0).description
            }
        }
    }

    Column {
        id: column
        anchors {
            fill:  parent
            margins: 10
        }
        OviMapTile {
            width: parent.width
            height: width-100
            latitude: container.latitude
            longitude: container.longitude
        }
        // TODO info texts
    }
}
