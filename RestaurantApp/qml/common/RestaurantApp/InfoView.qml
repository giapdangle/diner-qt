import QtQuick 1.0
import "Util.js" as Util

Rectangle {
    width: screenWidth
    height: screenHeight
    color: "lightsteelblue"

    Component.onCompleted: {
        Util.log("InfoView loaded");
    }
}
