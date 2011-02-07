import QtQuick 1.0
import "Util.js" as Utl

Rectangle {
    width: screenWidth
    height: screenHeight
    color: "darkgray"

    Component.onCompleted: {
        Util.log("MapView loaded");
    }

}
