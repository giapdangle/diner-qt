import QtQuick 1.0

Item {
    id: root

    width: 360
    height: 640

    Panorama {
        id: panorama
        anchors.fill:  parent

        panoramaWidth: root.width * 4
        panoramaHeight: root.height

        // Title bar
        titleBarColor: "darkGray"
        titleBarTextColor: "black"
        titleBarText: qsTr("Diner")
        titleBarTextSize: 48
        titleBarOpacity: 0.85

        headerBarColor: "lightGray"
        headerBarOpacity: 0.9
        headerBarTextSize: 32
        headerBarTextColor: "black"

        headerModel:  ListModel {
            ListElement {
                title: "Page 1"
            }
            ListElement {
                title: "Page 2"
            }
            ListElement {
                title: "Page 3"
            }
            ListElement {
                title: "Page 4"
            }
        }

        // Content headings
    }

}
