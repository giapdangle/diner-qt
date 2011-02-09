import QtQuick 1.0
import "Util.js" as Util

Rectangle {
    id: container

    property int zoomFactor: 14
    property double latitude: 61.50097409814573
    property double longitude: 23.76720428466797
    property string mapMode: "normal"

    width: 300
    height: 300
    clip: true
    border {
        color: "black"
        width: 2
    }


    // You can use this function as the mapImage source-property to get a real map tile from Ovi Maps Tile Rendering API
    function getOviMapsTileUrl(lat, lng, zoom, w, h) {
        var url = "http://m.ovi.me/?c="+lat+","+lng+"&z="+zoom+ "&w="+w+"&h="+h; //+"&u=5h";
        if (container.mapMode === "hybrid") {
            url = url + "&t=1";
        }

        Util.log(url);
        return url;
    }

    function getLocalMapTile(zoom) {
        return "content/map/" + zoom + ".jpg";
    }

    // Map tile fills the whole item
    Image {
        id: mapImage
        anchors {
            fill: parent
            margins: 2
        }
        // Uncomment this line to get real map tile over the network
        //source: getOviMapsTileUrl(container.latitude, container.longitude, container.zoomFactor, container.width, container.height);
        source: getLocalMapTile(container.zoomFactor);
    }

    // Draw zoom buttons on top
    Rectangle {
        id: zoomPlusRect
        width: 50
        height: 50
        radius: 5
        border {
            color: "black"
            width: 1
        }

        color: zoomPlusMouseArea.containsMouse ? "orange" : "lightgray";
        anchors {
            top: mapImage.top
            right: mapImage.right
            topMargin: 10
            rightMargin: 10
        }

        Text {
            anchors.centerIn: parent
            font {
                family: "Helvetica"
                pointSize: 24
            }
            text: "+"
        }

        MouseArea {
            id: zoomPlusMouseArea
            anchors.fill: parent
            onClicked:  {
                if (container.zoomFactor < 17) {
                    container.zoomFactor++;
                }
            }
        }
    }

    Rectangle {
        width: 50
        height: 50
        radius: 5
        clip: true
        border {
            color: "black"
            width: 1
        }
        color: zoomMinusMouseArea.containsMouse ? "orange" : "lightgray";
        anchors {
            bottom: mapImage.bottom
            right: mapImage.right
            bottomMargin: 10
            rightMargin: 10
        }
        Text {
            anchors.centerIn: parent
            font {
                family: "Helvetica"
                pointSize: 24
            }
            text: "-"
        }
        MouseArea {
            id: zoomMinusMouseArea
            anchors.fill: parent
            onClicked:  {
                if (container.zoomFactor > 0) {
                    container.zoomFactor--;
                }
            }
        }
    }

    Rectangle {
        width: 120
        height: 50
        radius: 5
        border {
            color: "black"
            width: 1
        }

        color: hybridMouseArea.containsMouse ? "orange" : "lightgray";
        anchors {
            top: mapImage.top
            right: zoomPlusRect.left
            topMargin: 10
            rightMargin: 10
        }

        Text {
            anchors.centerIn: parent
            font {
                family: "Helvetica"
                pointSize: 14
            }
            text: container.hybrid ? qsTr("Map") : qsTr("Hybrid")
        }

        MouseArea {
            id: hybridMouseArea
            anchors.fill: parent
            onClicked:  {
                if (container.mapMode === "normal") {
                    container.mapMode = "hybrid"
                } else {
                    container.mapMode = "normal"
                }
            }
        }
    }
}
