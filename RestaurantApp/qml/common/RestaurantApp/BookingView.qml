import QtQuick 1.0
import "Util.js" as Util

Rectangle {
    width: screenWidth
    height: screenHeight
    color: "turquoise"

    Component.onCompleted: {
        Util.log("BookingView loaded");
    }
}
