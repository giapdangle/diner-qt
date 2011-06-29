import QtQuick 1.0
import com.nokia.symbian 1.0
//import com.meego 1.0 // for Meego components
//import Qt.labs.components.native 1.0 // RnD: use currently installed components (Meego or Symbian)

Window {
    id: root
    width: 360
    height: 640

    StatusBar {
        id: statusBar
    }

    ReservationsModel {
        id: reservationsModel
    }

    Visual {
        id: visual
    }

    // Properties.
    AppStateVars {
        id: appState
        currentCaption: "Information"
        //fontSize: visual.defaultFontSize
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
        anchors { left: parent.left; right: parent.right; top: statusBar.bottom; bottom: tabBar.top }
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
