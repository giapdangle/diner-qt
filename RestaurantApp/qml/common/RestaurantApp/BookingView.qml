import QtQuick 1.0
import "Util.js" as Util

Rectangle {
    // Default values, change when using
    width: 360
    height: 640
    color: "turquoise"

    Component.onCompleted: {
        Util.log("BookingView loaded");
    }
}
