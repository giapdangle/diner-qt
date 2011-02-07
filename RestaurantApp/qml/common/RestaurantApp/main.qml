import QtQuick 1.0
import "Util.js" as Util

Rectangle {
    id: mainWindow

    // Connect the the orientation sensor signal to our handler function
    Connections {
        target: filter // this is available only on device, on desktop you get warnings
        onOrientationChanged: orientationChanged(orientation)
    }

    Component.onCompleted: {
        Util.log("main.qml loaded");
        viewSwitcher.switchView(infoView, 0, true);
    }

    // Handle orientation changes
    function orientationChanged(orientation) {
        if (orientation === 0) {
            Util.log("Orientation UNKNOWN");
            mainWindow.rotation = 0;
        } else if (orientation === 1) {
            Util.log("Orientation TOP POINTING UP");
            mainWindow.rotation = 0;
        } else if (orientation === 2) {
            Util.log("Orientation TOP POINTING DOWN");
            mainWindow.rotation = 180;
        } else if (orientation === 3) {
            Util.log("Orientation LEFT POINTING UP");
            mainWindow.rotation = 270;
        } else if (orientation === 4) {
            Util.log("Orientation RIGHT POINTING UP");
            mainWindow.rotation = 90;
        } else if (orientation === 5) {
            Util.log("Orientation FACE POINTING UP");
            mainWindow.rotation = 0;
        } else if (orientation === 6) {
            Util.log("Orientation FACE POINTING DOWN");
            mainWindow.rotation = 0;
        }
    }

    // screen width and height are set from C++ main
    width: screenWidth
    height: screenHeight
    color: "darkslategrey"

    Visual {
        id: visual
    }

    // All views have a title bar
    TitleBar {
        id: titleBar
        // Anchors titlebar to left,top and right. Then set height
        // Use grouping if possible.
        anchors {
            top: mainWindow.top
            left: mainWindow.left
            right: mainWindow.right
        }
        height: 80
        fontName: visual.defaultFontFamily
        fontSize: visual.titleFontSize
        fontColor: visual.titleFontColor
        text: qsTr("FutuDiner")
        //iconSource: ""  // TODO: set icon when gfx available
        showingBackButton: false

        onBackButtonClicked: {
            Util.log("Back-button clicked. Came from view: " + viewName);
        }
        onExitButtonClicked: {
            Util.exitApp("Exit-button clicked");
        }
    }

    // This item will contain the views that we switch between
    Item {
        id: contentPane
        clip: true
        anchors {
            top: titleBar.bottom
            left: mainWindow.left
            right: mainWindow.right
            bottom: naviBar.top
        }

        // View switcher component, handles the view switching and animation
        ViewSwitcher {
            id: viewSwitcher
            // Rooted in contentPane
            root: contentPane
        }

        ViewLoader {
            id: infoView
            viewSource: "InfoView.qml"
            keepLoaded: true
        }
        ViewLoader {
            id: menuView
            viewSource: "MenuGridView.qml"
            keepLoaded: true
        }
        ViewLoader {
            id: mapView
            viewSource: "MapView.qml"
            keepLoaded: true
        }
        ViewLoader {
            id: bookingView
            viewSource: "BookingView.qml"
            keepLoaded: true
        }
    }

    TabBar {
        id: naviBar
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            leftMargin: 10
            rightMargin: 10
        }
        height: visual.tabBarHeight;
        fontName: visual.tabBarButtonFont
        fontSize: visual.tabBarButtonFontSize
        fontColor: visual.tabBarButtonFontColor

        onTabButtonClicked: {
            Util.log("Tab-bar button clicked: " + buttonName);
            if (buttonName === "infoButton") {
                viewSwitcher.switchView(infoView, 0, "instant");
            } else if (buttonName === "menuButton") {
                viewSwitcher.switchView(menuView, 0, "instant");
            } else if (buttonName === "mapButton") {
                viewSwitcher.switchView(mapView, 0, "instant");
            } else if (buttonName === "bookingButton") {
                viewSwitcher.switchView(bookingView, 0, "instant");
            }
        }
    }
}


