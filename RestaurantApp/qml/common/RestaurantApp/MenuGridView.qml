import QtQuick 1.0
import "Util.js" as Util

Item {
    id: container
    signal menuItemClicked(string itemId);

    property string fontName: visual.defaultFontFamily
    property int fontSize: visual.menuGridViewFontSize
    property color fontColor: visual.defaultFontColor
    property color fontColorLink: visual.defaultFontColorLink
    property double margins: visual.margins

    property int scrollBarWidth: visual.scrollBarWidth
    property int spacing: visual.margins

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
            margins: container.margins
        }
        cellWidth: appState.inLandscape ? width*0.3 : width*0.5
        cellHeight: cellWidth*0.9
        model: menuModel
        delegate: menuDelegate
        focus: true
    }

    Component {
        id: menuDelegate
        MenuGridItem {
            width: grid.cellWidth
            height: grid.cellHeight
            margins: container.margins
            fontName: container.fontName
            fontSize: container.fontSize
            fontColor: container.fontColor
            onClicked: {
                container.menuItemClicked(itemId);                
                appState.selectedMenuCategoryId = itemId;
                appState.selectedMenuCategoryTitle = title;
                appState.selectedMenuCategoryIconSource = iconSource;
                appState.currentViewName = "menuListView";
            }
        }
    }
}
