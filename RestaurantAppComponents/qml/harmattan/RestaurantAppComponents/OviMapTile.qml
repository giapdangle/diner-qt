import QtQuick 1.0
import com.nokia.meego 1.0
import "Util.js" as Util

Rectangle {
    id: container

    property int minZoomLevel: 11
    property int maxZoomLevel: 17
    property int zoomFactor: 14
    property double latitude: 61.50097409814573
    property double longitude: 23.76720428466797
    property string mapMode: "normal"
    property int margins: 8
    property int zoomButtonSize: 48

    // You can use this function as the mapImage source-property to get a real map tile from Ovi Maps Tile Rendering API
    function getOviMapsTileUrl(lat, lng, zoom, w, h) {
        var url = "http://m.ovi.me/?c="+lat+","+lng+"&z="+zoom+ "&w="+w+"&h="+h; //+"&u=5h";
        if (container.mapMode === "hybrid") {
            url = url + "&t=1";
        }

        Util.log(url);
        return url;
    }

    function getLocalMapTile(zoom, landscape) {
        if (zoom < minZoomLevel) {
            return "content/map/" + minZoomLevel + (landscape ? "_landscape.png" : ".png");
        }
        if (zoom > maxZoomLevel) {
            return "content/map/" + maxZoomLevel + (landscape ? "_landscape.png" : ".png");
        }

        return "content/map/" + zoom + (landscape ? "_landscape.png" : ".png");
    }

    width: 300
    height: 300
    clip: true
    border {
        color: "black"
        width: 2
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
        smooth: true
        source: getLocalMapTile(container.zoomFactor, appState.inLandscape);
    }

    Button {
        id: zoomPlus

        width: 64
        height: 64
        enabled: container.zoomFactor < container.maxZoomLevel
        visible: enabled
        iconSource: "content/plus_button.png"
        anchors {
            top: mapImage.top
            left: mapImage.left
            topMargin: container.margins
            leftMargin: container.margins
        }
        onClicked:  {
            if (container.zoomFactor < container.maxZoomLevel) {
                container.zoomFactor++;
            }
        }
    }

    Button {
        width: 64
        height: 64
        enabled: container.zoomFactor > container.minZoomLevel
        visible: enabled
        iconSource: "content/minus_button.png"
        anchors {
            top: zoomPlus.bottom
            left: mapImage.left
            topMargin: container.margins
            leftMargin: container.margins
        }
        onClicked: container.zoomFactor--

    }
}
