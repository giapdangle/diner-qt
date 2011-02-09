import QtQuick 1.0
import "Util.js" as Util

Item {
    id: container
    signal menuItemClicked(string itemId);

    property string fontName: "Helvetica"
    property int fontSize: 16
    property color fontColor: "black"

    property int scrollBarWidth: 8
    property int spacing: 20

    // Default values, change when using
    width: 360
    height: 640

    Component.onCompleted: {
        Util.log("MenuGridView loaded");
        menuModel.reload();
        Util.log("Count: " + menuModel.count);
    }


    MenuModel {
        id: menuModel
    }

    ScrollBar { scrollArea: grid; width: container.scrollBarWidth; anchors.top: grid.top; anchors.right: grid.right; anchors.bottom: grid.bottom }

    GridView {
        id: grid
        contentItem.clip: true
        cacheBuffer: 8
        anchors {
            fill: parent
        }
        cellWidth: container.width / 2
        cellHeight: cellWidth/2
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
            onClicked: {
                container.menuItemClicked(itemId);
                appState.selectedMenuCategeoryId = itemId;
                appState.currentViewName = "menuListView";
            }
        }
    }
}
