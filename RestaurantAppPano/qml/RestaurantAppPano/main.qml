import QtQuick 1.0

Item {
    id: root

    width: 360
    height: 640

    Panorama {
        id: panorama
        anchors.fill:  parent

        // Title bar
        titleBarColor: "lightblue"
        titleBarTextColor: "black"
        titleBarText: qsTr("Diner")
        titleBarOpacity: 0.85

        headerBarOpacity: 0.90

        // Content headings
    }

}
