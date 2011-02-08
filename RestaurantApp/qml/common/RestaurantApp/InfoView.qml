import QtQuick 1.0
import "Util.js" as Util

Rectangle {
    id: container
    property double margins: 8
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
                country.text = infoModel.get(0).country
                telephone.text = infoModel.get(0).telephone
            }
        }
    }

    Image {
        id: logo
        fillMode: "PreserveAspectFit"
        smooth: true
        height: 0.2*container.height
        anchors {
            left: parent.left
            verticalCenter: parent.verticalCenter
            margins: container.margins
        }
    }
    Column {
        Text {
            id: street
        }
        Text {
            id: city
        }
        Text {
            id: country
        }
        Text {
            id: telephone
        }
    }
}
