import QtQuick 1.0
import com.nokia.symbian 1.0

Window {
    width: 360
    height: 360

    StatusBar {
        id: statusBar
    }

    Visual {
        id: visual
    }

    TabBar {
        id: tabBar
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        TabButton {
            tab: tab1
            text: qsTr("Info")
        }
        TabButton {
            tab: tab2;
            text: qsTr("Menu")
        }
        TabButton {
            tab: tab3;
            text: qsTr("Map")
        }
        TabButton {
            tab: tab4;
            text: qsTr("Booking")
        }
    }

    TabGroup {
        id: tabGroup
        anchors { left: parent.left; right: parent.right; top: parent.top; bottom: tabBar.top }
    }

    InfoView {
        id: tab1
    }

    MenuGridView {
        id: tab2
    }

    MapView {
        id: tab3
    }

    BookingView {
        id: tab4
    }

    // add the tab content items to the tab group
    Component.onCompleted: {
        tabGroup.addTab(tab1)
        tabGroup.addTab(tab2)
        tabGroup.addTab(tab3)
        tabGroup.addTab(tab4)
    }
}
