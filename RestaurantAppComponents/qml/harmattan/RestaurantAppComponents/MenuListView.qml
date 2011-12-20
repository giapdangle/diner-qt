import QtQuick 1.1
import com.nokia.meego 1.0
import "Util.js" as Util

Page {
    id: container

    property string fontName: visual.defaultFontFamily
    property color fontColor: visual.menuListViewDishFontColor
    property color fontColorTitle: visual.menuListViewDishTitleFontColor
    property color fontColorLink: visual.defaultFontColorLink
    property double margins: visual.margins
    property int spacing: visual.spacing

    property int listItemheight: 80
    property string selectedCategoryId: appState.selectedMenuCategoryId
    property string selectedCategoryTitle: appState.selectedMenuCategoryTitle
    property string selectedCategoryIconSource: appState.selectedMenuCategoryIconSource

    Component.onCompleted: {
        Util.log("MenuListView loaded");
    }

    Image {
        anchors.fill: parent
        source: visual.backgroundImageSource
    }

    MenuModel {
        id: model
        // Get dishes only from under the selected category
        query: "/restaurant/menu/category[@id='"
               + container.selectedCategoryId + "']/dish"
        XmlRole { name: "dishIcon"; query: "@icon/string()" }
        XmlRole { name: "description"; query: "string()" }
        XmlRole { name: "price"; query: "@price/string()" }
    }

    ScrollDecorator {
        flickableItem: listView
        anchors {
            top: listView.top;
            right: listView.right;
            }
        }

    ListView {
        id: listView
        clip: true
        anchors.fill: parent
        anchors.topMargin: container.margins*2
        model: model
        delegate: listDelegate
        focus: true
        spacing: 2*container.spacing
    }

    Component {
        id: listDelegate
        MenuListItem {
            width: listView.width            
            spacing: container.spacing
            margins: container.margins
            fontName: container.fontName
            fontSize: visual.menuListItemFontSize
            titleFontSize: visual.menuListTitleFontSize
            fontColor: container.fontColor
            fontColorTitle: container.fontColorTitle
        }
    }
}
