import QtQuick 1.0
import com.nokia.meego 1.0
import "Util.js" as Util

Page {
    width: 480
    height: 854

    id: container

    property string fontName: visual.defaultFontFamily
    property int fontSize: visual.menuGridViewFontSize
    property color fontColor: visual.defaultFontColor
    property color fontColorLink: visual.defaultFontColorLink
    property double margins: visual.margins

    property int scrollBarWidth: visual.scrollBarWidth
    property int spacing: visual.margins

    signal menuItemClicked(string itemId);

    Component.onCompleted: {
        Util.log("MenuGridView loaded");
        menuModel.reload();
        Util.log("Count: " + menuModel.count);
    }

    Image {
        anchors.fill: parent
        source: visual.backgroundImageSource
    }

    MenuModel {
        id: menuModel
    }

    ScrollBar {
        id: scrollBar
        scrollArea: grid
        anchors {
            right: parent.right
            top: parent.top
        }
    }

    GridView {
        id: grid
        contentItem.clip: true
        cacheBuffer: 8
        clip: true
        anchors {
            fill: parent
            margins: container.margins
        }
        cellWidth: appState.inLandscape ? width*0.32 : width*0.5
        cellHeight: appState.inLandscape ? cellWidth*0.60 : cellWidth*0.9
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
                appState.selectedMenuCategoryId = itemId;
                appState.selectedMenuCategoryTitle = title;
                appState.selectedMenuCategoryIconSource = iconSource;
                appState.currentViewName = "menuListView";
                container.menuItemClicked(itemId);
            }
        }
    }
}
