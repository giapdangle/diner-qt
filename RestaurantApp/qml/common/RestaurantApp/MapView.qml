import QtQuick 1.0
import "Util.js" as Utl

Rectangle {
    // Default values, change when using
    width: 360
    height: 640
    color: "darkgray"

    Component.onCompleted: {
        Util.log("MapView loaded");
    }

}
