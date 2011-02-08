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

    function getOviMapsTileUrl() {
        var url = "http://m.ovi.me/?c="+latitude+","+longitude+"&z="+zoomFactor+ "&w="+container.width+"&h="+container.height+"&u=5h";
        if (container.mapMode === "hybrid") {
            url = url + "&t=1";
        }

        Util.log(url);
        return url;
    }

    function getOviMapsTileUrlPOIs() {
        var url = "http://m.ovi.me/?z="+zoomFactor+ "&w="+container.width+"&h="+container.height+"&poi=61.510234,23.777203,61.610234,23.677203";
        Util.log(url);
        return url;
    }

    // Map tile fills the whole item
    Image {
        id: mapImage
        anchors {
            fill: parent
            margins: 2
        }
        source: getOviMapsTileUrl();
        //source: getOviMapsTileUrlPOIs();
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
