import QtQuick 1.0
import com.nokia.symbian 1.0

Window {
    width: 360
    height: 360

    StatusBar {
        id: statusBar
    }

    TabBar {
        id: tabBar
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        TabButton {
            tab: tab1;
            text: qsTr("Tab 1")
        }
        TabButton {
            tab: tab2;
            text: qsTr("Tab 2")
        }
        TabButton {
            tab: tab3;
            text: qsTr("Tab 3")
        }
        TabButton {
            tab: tab4;
            text: qsTr("Tab 4")
        }
    }

    Page {
        id: tab1
    }
    Page {
        id: tab2
    }
    Page {
        id: tab3
    }
    Page {
        id: tab4
    }
}
