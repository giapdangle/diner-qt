import QtQuick 1.0
import "Util.js" as Util

Item {
    id: container

    property string fontName: "Helvetica"
    property int fontSize: 12
    property color fontColor: "black"

    property int listItemheight: 80
    property string selectedCategoryId: appState.selectedMenuCategeoryId

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

    ListView {
        id: listView
        anchors {
            fill: parent
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
            onClicked: {
                Util.log("CLICK");
            }
        }
    }
}
