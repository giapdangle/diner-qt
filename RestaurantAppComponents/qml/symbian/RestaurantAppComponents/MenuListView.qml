import QtQuick 1.0
import com.nokia.symbian 1.0
import "Util.js" as Util

Page {
    id: container

    property string fontName: visual.defaultFontFamily
    property int fontSize: visual.defaultFontSize
    property int fontSizeTitle: visual.menuListViewTitleSize
    property color fontColor: visual.menuListViewDishFontColor
    property color fontColorTitle: visual.menuListViewDishTitleFontColor
    property color fontColorLink: visual.defaultFontColorLink
    property double margins: visual.margins
    property int spacing: visual.spacing

    property int scrollBarWidth: visual.scrollBarWidth
    property int listItemheight: 80
    property string selectedCategoryId: appState.selectedMenuCategoryId
    property string selectedCategoryTitle: appState.selectedMenuCategoryTitle
    property string selectedCategoryIconSource: appState.selectedMenuCategoryIconSource

    width: 360
    height: 640

    Component.onCompleted: {
        Util.log("MenuListView loaded");
    }


    MenuModel {
        id: model
        // Get dishes only from under the selected category
        query: "/restaurant/menu/category[@id='"+container.selectedCategoryId+"']/dish"
        XmlRole { name: "description"; query: "string()" }
    }

    ScrollBar {
        flickableItem: listView
        anchors {
            top: listView.top;
            right: listView.right;
            }
        }

    Rectangle {
        id: categoryTitle
        anchors {
            left: parent.left
            right: parent.right
            leftMargin: -1
            rightMargin: -1
        }
        height: 80
        color: visual.menuListViewBackgroundColor
        border.width: 1
        border.color: "#7c0505"
        anchors.top: parent.top
        Image {
            id: icon
            source: container.selectedCategoryIconSource
            fillMode: Image.PreserveAspectFit
            smooth: true
            anchors {
                top: parent.top
                bottom: parent.bottom
                left: parent.left
                leftMargin: container.width*0.1
            }

        }
        Text {
            height: parent.height
            anchors.left: icon.right
            anchors.margins: container.margins
            text: container.selectedCategoryTitle
            color: container.fontColor
            font {
                family: container.fontName
                pointSize: container.fontSizeTitle
            }
            verticalAlignment: Text.AlignVCenter
        }
    }

    ListView {
        id: listView
        clip: true
        anchors {
            top: categoryTitle.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            topMargin: container.margins
        }
        model: model
        delegate: listDelegate
        focus: true
        spacing: 4*container.spacing
    }

    Component {
        id: listDelegate
        MenuListItem {
            width: listView.width            
            spacing: container.spacing
            margins: container.margins
            fontName: container.fontName
            fontSize: visual.menuListItemFontSize
            fontColor: container.fontColor
            fontColorTitle: container.fontColorTitle
        }
    }
}
