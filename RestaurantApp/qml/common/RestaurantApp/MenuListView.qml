import QtQuick 1.0
import "Util.js" as Util

Rectangle {
    width: 100
    height: 62
    Component.onCompleted: {
        Util.log("MenuListView loaded");
    }
}
