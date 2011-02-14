import QtQuick 1.0
import "Util.js" as Util

Rectangle {
    id: mainWindow

    // Connect the the orientation sensor signal to our handler function
    Connections {
        target: filter // this is available only on device, on desktop you get warnings
        onOrientationChanged: { orientationChanged(orientation) }
    }

    Component.onCompleted: {
        Util.log("main.qml loaded, width: " + width + " height: " + height)
        viewSwitcher.switchView(infoView, 0, true);
    }

    // Handle orientation changes
    function orientationChanged(orientation) {
        if (orientation === 1) {
            Util.log("Orientation TOP POINTING UP");
            //appState.inLandscape = true
        } else if (orientation === 2) {
            Util.log("Orientation TOP POINTING DOWN");
            //appState.inLandscape = true
        } else if (orientation === 3) {
            Util.log("Orientation LEFT POINTING UP");
            //appState.inLandscape = false
        } else if (orientation === 4) {
            Util.log("Orientation RIGHT POINTING UP");
            //appState.inLandscape = false
        }
    }

    // Properties.
    AppStateVars {
        id: appState
        currentCaption: "Information"
        //fontSize: visual.defaultFontSize
    }

    ReservationsModel {
        id: reservationsModel
    }

    // screen width and height are set from C++ main
    width: 360
    height: 640
    color: visual.defaultBackgroundColor

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
        height: mainWindow.height*0.12
        icon.visible: false
        title: ""
        titleImageSoucre: visual.titleImageSource
        titleFontSize: visual.titleFontSize
        titleFontColor: visual.titleFontColor
        titleFontBold: true
        titleBackgroundColor: visual.titleBackgroundColor
        captionFontName: visual.captionFontFamily
        captionFontSize: visual.captionFontSize-6
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

    // This item will contain the views that we switch between
    Item {
        id: contentPane
        clip: true
        anchors {
            top: titleBar.bottom
            left: mainWindow.left
            right: naviBar.wide ? mainWindow.right : naviBar.left
            bottom: naviBar.wide ? naviBar.top : mainWindow.bottom
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

        wide: !appState.inLandscape

        anchors {
            top: wide ? undefined: titleBar.bottom
            bottom: mainWindow.bottom
            left: wide ? mainWindow.left : undefined
            right: mainWindow.right
        }
        width: wide ? undefined : mainWindow.width*0.12
        height: wide ? mainWindow.height*0.12 : undefined

        fontName: visual.tabBarButtonFont
        fontSize: visual.tabBarButtonFontSize
        fontColor: visual.tabBarButtonFontColor

        state: show ? "visible" : "hidden"

        states: [
            State {
                name: "hidden"
                AnchorChanges {
                    target: naviBar;
                    anchors.right: wide ? mainWindow.right : undefined
                    anchors.left:  wide ? mainWindow.left : mainWindow.right
                    anchors.top:  wide ? mainWindow.bottom : titleBar.bottom
                    anchors.bottom:  wide ? undefined : mainWindow.bottom
                }
            }
        ]

        transitions: Transition { AnchorAnimation { duration: 300;  easing.type: Easing.InOutQuad } }
        onTabButtonClicked: {
            Util.log("Tab-bar button clicked: " + buttonName);
            appState.currentViewName = targetView
        }
    }

    states: [
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
            PropertyChanges { target: appState; currentCaption: "A la Carte" }
            StateChangeScript { script: viewSwitcher.switchView(menuGridView,0, "instant"); }
        },
        State {
            when: appState.currentViewName === "menuListView";
            name: "showingMenuListView"
            PropertyChanges { target: naviBar; show: false }
            PropertyChanges { target: mainWindow; color: visual.menuListViewBackgroundColor }
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


