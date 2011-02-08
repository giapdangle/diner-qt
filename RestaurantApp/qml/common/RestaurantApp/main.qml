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
            //mainWindow.rotation = 0;
            appState.inLandscape = false;
        } else if (orientation === 1) {
            Util.log("Orientation TOP POINTING UP");
            //mainWindow.rotation = 0;
            appState.inLandscape = false;
        } else if (orientation === 2) {
            Util.log("Orientation TOP POINTING DOWN");
            //mainWindow.rotation = 180;
            appState.inLandscape = false;
        } else if (orientation === 3) {
            Util.log("Orientation LEFT POINTING UP");
            //mainWindow.rotation = 270;
            appState.inLandscape = true;
        } else if (orientation === 4) {
            Util.log("Orientation RIGHT POINTING UP");
            //mainWindow.rotation = 90;
            appState.inLandscape = true;
        } else if (orientation === 5) {
            Util.log("Orientation FACE POINTING UP");
            //mainWindow.rotation = 0;
            appState.inLandscape = false;
        } else if (orientation === 6) {
            Util.log("Orientation FACE POINTING DOWN");
            //mainWindow.rotation = 0;
            appState.inLandscape = false;
        }
    }

    // Properties.
    AppStateVars {
        id: appState
        currentCaption: "Information"
    }

    // screen width and height are set from C++ main
    width: 360
    height: 640
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
        titleFontName: visual.defaultFontFamily
        titleFontSize: visual.titleFontSize
        titleFontColor: visual.titleFontColor
        captionFontName: visual.defaultFontFamily
        captionFontSize: visual.titleFontSize-6
        captionFontColor: visual.titleFontColor
        title: qsTr("Diner")
        caption: appState.currentCaption
        //iconSource: ""  // TODO: set icon when gfx available
        showingBackButton: false

        onBackButtonClicked: {
            Util.log("Back-button clicked. Came from view: " + viewName);
            appState.currentViewName = viewName;
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
            id: menuGridView
            viewSource: "MenuGridView.qml"
            keepLoaded: true
        }
        ViewLoader {
            id: menuListView
            viewSource: "MenuListView.qml"
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
            left: mainWindow.left
            right: mainWindow.right
            leftMargin: 10
            rightMargin: 10
        }
        height: visual.tabBarHeight;
        fontName: visual.tabBarButtonFont
        fontSize: visual.tabBarButtonFontSize
        fontColor: visual.tabBarButtonFontColor

        state: show ? "visible" : "hidden"

        states: [
            State {
                name: "visible"
                AnchorChanges { target: naviBar; anchors.bottom: mainWindow.bottom; anchors.top: undefined }
            },
            State {
                name: "hidden"
                AnchorChanges { target: naviBar; anchors.bottom: undefined; anchors.top: mainWindow.bottom }
            }
        ]

        transitions: Transition { AnchorAnimation { duration: 400;  easing.type: Easing.InOutQuad } }
        onTabButtonClicked: {
            Util.log("Tab-bar button clicked: " + buttonName);
            appState.currentViewName = targetView
        }
    }
    states: [
        State {
            when: appState.inLandscape
            name: "landscape"
            // Animate the view switch with viewSwitcher
            StateChangeScript { script: Util.log("LANDSCAPEEN"); }
        },
        State {
            when: appState.currentViewName === "infoView";
            name: "showingInfoView"
            // Animate the view switch with viewSwitcher
            PropertyChanges { target: appState; currentCaption: "Information" }
            StateChangeScript { script: viewSwitcher.switchView(infoView,0, "instant"); }

        },
        State {
            when: appState.currentViewName === "menuGridView";
            name: "showingMenuGridView"
            PropertyChanges { target: appState; currentCaption: "À la Carte" }
            StateChangeScript { script: viewSwitcher.switchView(menuGridView,0, "instant"); }
        },
        State {
            when: appState.currentViewName === "menuListView";
            name: "showingMenuListView"
            PropertyChanges { target: naviBar; show: false }
            PropertyChanges { target: titleBar; showingBackButton: true }
            PropertyChanges { target: appState; cameFromView: "menuGridView" }
            StateChangeScript { script: viewSwitcher.switchView(menuListView,0, "instant"); }
        },
        State {
            when: appState.currentViewName === "mapView";
            name: "showingMapView"
            PropertyChanges { target: appState; currentCaption: "Location on Map" }
            StateChangeScript { script: viewSwitcher.switchView(mapView,0, "instant"); }
        },
        State {
            when: appState.currentViewName === "bookingView";
            name: "showingBookingView"
            PropertyChanges { target: appState; currentCaption: "Table Reservations" }
            StateChangeScript { script: viewSwitcher.switchView(bookingView,0, "instant"); }
        }
    ]
}


