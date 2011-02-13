import QtQuick 1.0
import "Util.js" as Util

Item {
    id: container

    property string fontName: visual.defaultFontFamily
    property int fontSize: visual.defaultFontSize
    property color fontColor: visual.defaultFontColor
    property color fontColorLink: visual.defaultFontColorLink
    property double margins: visual.margins

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
    }

    ScrollBar { scrollArea: listView; width: container.scrollBarWidth; anchors.top: listView.top; anchors.right: listView.right; anchors.bottom: listView.bottom }

    Rectangle {
        id: categoryTitle
        anchors {
            left: parent.left
            right: parent.right
            leftMargin: -1
            rightMargin: -1
        }
        height: parent.height*0.08
        border.width: 1
        border.color: "#7c0505"
        anchors.top: parent.top
        Image {
            id: icon
            source: container.selectedCategoryIconSource
            fillMode: Image.PreserveAspectFit
            anchors {
                top: parent.top
                bottom: parent.bottom
                left: parent.left
                topMargin: container.margins
                bottomMargin: container.margins
                leftMargin: container.width*0.1
            }

        }
        Text {
            height: parent.height
            anchors.left: icon.right
            anchors.margins: container.margins
            text: container.selectedCategoryTitle
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
        }
        model: model
        delegate: listDelegate
        focus: true
    }

    Component {
        id: listDelegate
        MenuListItem {
            width: listView.width
            height: container.listItemheight
            fontName: container.fontName
            fontSize: container.fontSize
            fontColor: container.fontColor
            margins: container.margins
            onClicked: {
                Util.log("CLICK");
            }
        }
    }
}
