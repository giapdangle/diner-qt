import QtQuick 1.0
import "Util.js" as Util

Rectangle {
    id: mainWindow

    Component.onCompleted: {
        Util.log("main.qml loaded, width: " + width + " height: " + height)
        viewSwitcher.switchView(infoView, 0, true);
    }

    BookingView {visible: false}

    // Orientation check
    onHeightChanged: {
        if(width > height) {
            Util.log("Landscape")
            appState.inLandscape = true
        } else {
            Util.log("Portrait")
            appState.inLandscape = false
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
    //width: 800
    //height: 480
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
            right: naviBarVertical.left
            bottom: naviBarHorizontal.top
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


    // TabBar is vertical and is on the right side
    TabBar {
        id: naviBarVertical
        show: appState.inLandscape
        wide: false

        anchors {
            top:  titleBar.bottom
            bottom: mainWindow.bottom
            right: mainWindow.right
        }
        width: mainWindow.width*0.12

        fontName: visual.tabBarButtonFont
        fontSize: visual.tabBarButtonFontSize
        fontColor: visual.tabBarButtonFontColor

        state: show ? "visible" : "hidden"

        states: [
            State {
                name: "hidden"
                AnchorChanges {
                    target: naviBarVertical
                    anchors.right: undefined
                    anchors.left: mainWindow.right
                }
            }
        ]
        //transitions: Transition { AnchorAnimation { duration: 300;  easing.type: Easing.InOutQuad } }
        onTabButtonClicked: {
            Util.log("Tab-bar button clicked: " + buttonName);
            appState.currentViewName = targetView
        }
    }

    // TabBar is horizontal and is on the bottom
    TabBar {
        id: naviBarHorizontal
        show: !appState.inLandscape
        wide: true

        anchors {
            bottom: mainWindow.bottom
            left: mainWindow.left
            right: mainWindow.right
        }
        //height: mainWindow.height*0.12
        height: mainWindow.height*0.12

        fontName: visual.tabBarButtonFont
        fontSize: visual.tabBarButtonFontSize
        fontColor: visual.tabBarButtonFontColor

        state: show ? "visible" : "hidden"

        states: [
            State {
                name: "hidden"
                AnchorChanges {
                    target: naviBarHorizontal
                    anchors.top: mainWindow.bottom
                    anchors.bottom: undefined
                }
            }
        ]

        //transitions: Transition { AnchorAnimation { duration: 300;  easing.type: Easing.InOutQuad } }
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
            PropertyChanges { target: naviBarVertical; show: false }
            PropertyChanges { target: naviBarHorizontal; show: false }
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


