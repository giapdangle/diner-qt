import QtQuick 1.0
import com.nokia.symbian 1.1
//import com.meego 1.0 // for Meego components
//import Qt.labs.components.native 1.0 // RnD: use currently installed components (Meego or Symbian)
import "Components.js" as Util

Window {
    id: root
    width: 360
    height: 640

    StatusBar {
        id: statusBar
    }

    // All views have a title bar
    TitleBar {
        id: titleBar
        // Anchors titlebar to left,top and right. Then set height
        // Use grouping if possible.
        anchors {
            top: statusBar.bottom
            left: parent.left
            right: parent.right
        }
        height: appState.inLandscape ? mainWindow.width * 0.12 : mainWindow.height*0.12
//        icon.visible: false
        title: ""
        titleImageSource: visual.titleImageSource
        titleFontSize: visual.titleFontSize
        titleFontColor: visual.titleFontColor
        titleFontBold: true
        titleBackgroundColor: visual.titleBackgroundColor
        captionFontName: visual.captionFontFamily
        captionFontSize: visual.captionFontSize
        captionFontColor: visual.captionFontColor
        captionBackgoundColor: visual.captionBackgroundColor
        caption: appState.currentCaption
        exitButtonSource: visual.exitButtonSource
        exitButtonPressedSource: visual.exitButtonPressedSource
        backButtonSource: visual.backButtonSource
        backButtonPressedSource: visual.backButtonPressedSource
        showingBackButton: false

        onBackButtonClicked: {
            Util.log("Back-button clicked. Came from view: " + viewName);
            appState.currentViewName = viewName;
        }
        onExitButtonClicked: {
            Util.exitApp("Exit-button clicked");
        }
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
    }

    TabBar {
        id: tabBar
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            //top: statusBar.bottom
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
        anchors { left: parent.left; right: parent.right; top: titleBar.bottom; bottom: tabBar.top }
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
    }
}
