import QtQuick 1.0
import "Util.js" as Util

Item {
    id: container
    property int spacing: 20
    property string fontName: "Helvetica"
    property int fontSize: 24
    property color fontColor: "black"

    // Default values, change when using
    width: 360
    height: 640

    Component.onCompleted: {
        Util.log("MenuGridView loaded");
    }


    MenuModel {
        id: menuModel
    }

    GridView {
        id: grid
        contentItem.clip: true
        cacheBuffer: 8
        anchors {
            fill: parent
        }
        cellWidth: container.width / 2
        cellHeight: cellWidth
        model: menuModel
        delegate: menuDelegate
        focus: true
    }

    Component {
        id: menuDelegate
        MenuGridItem {
            width: grid.cellWidth
            height: grid.cellHeight
            margins: container.spacing
            fontName: container.fontName
            fontSize: container.fontSize
            fontColor: container.fontColor
        }
    }
}
