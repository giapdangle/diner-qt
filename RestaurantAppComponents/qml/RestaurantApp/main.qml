import QtQuick 1.0
import com.nokia.symbian 1.0
//import com.meego 1.0 // for Meego components
//import Qt.labs.components.native 1.0 // RnD: use currently installed components (Meego or Symbian)
import "Components.js" as Util

Window {
    id: root
    width: 360
    height: 640

    // Internal properties. Used for storing/restoring the height.
    property int _tabBarHeight: 0

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

        height: appState.inLandscape ? root.width * 0.04 : root.height*0.04
        captionFontName: visual.captionFontFamily
        captionFontSize: visual.captionFontSize
        captionFontColor: visual.captionFontColor
        captionBackgoundColor: visual.captionBackgroundColor
        caption: appState.currentCaption

//        icon.visible: false
//        title: ""
//        titleImageSource: visual.titleImageSource
//        titleFontSize: visual.titleFontSize
//        titleFontColor: visual.titleFontColor
//        titleFontBold: true
//        titleBackgroundColor: visual.titleBackgroundColor

//        exitButtonSource: visual.exitButtonSource
//        exitButtonPressedSource: visual.exitButtonPressedSource
//        backButtonSource: visual.backButtonSource
//        backButtonPressedSource: visual.backButtonPressedSource
//        showingBackButton: false

//        onBackButtonClicked: {
//            Util.log("Back-button clicked. Came from view: " + viewName);
//            appState.currentViewName = viewName;
//            showingBackButton = false;
//            pageStack.pop();
//        }
//        onExitButtonClicked: {
//            Util.exitApp("Exit-button clicked");
//        }
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
        currentCaption: qsTr("Information")
    }

    // Defines the "Main TabBar", shown on each Page view, but hidden when
    // in BookingView & MenuListView.
    TabBar {
        id: tabBar

        Component.onCompleted: {
            // Store the height so that it can be restored later.
            root._tabBarHeight = tabBar.height;
            console.log("TabBar height: " + root._tabBarHeight);
        }

        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        TabButton {
            text: qsTr("Back")
            iconSource: pressed ? visual.backButtonPressedSource : visual.backButtonSource
            onClicked: {
                if (appState.showBackButton == true) {
                    Util.log("Back-button clicked");
                    appState.showBackButton = false;
                    pageStack.pop();
                } else {
                    Util.exitApp("Back-button clicked");
                }
            }
        }
        TabButton {
            id: tabButton1;

            tab: tab1;
            text: qsTr("Info")
            iconSource: pressed ? visual.infoButtonPressedSource : visual.infoButtonSource
        }
        TabButton {
            id: tabButton2;

            tab: tab2;
            text: qsTr("Menu")
            iconSource: pressed ? visual.menuButtonPressedSource : visual.menuButtonSource
        }
        TabButton {
            id: tabButton3;

            tab: tab3;
            text: qsTr("Map")
            iconSource: pressed ? visual.mapButtonPressedSource : visual.mapButtonSource
//            iconSource: pressed ? visual.bookingButtonPressedSource : visual.bookingButtonSource
        }
    }

    TabGroup {
        id: tabGroup

        anchors {
            left: parent.left;
            right: parent.right;
            top: titleBar.bottom;
            bottom: tabBar.top
        }

        InfoView {
            id: tab1

            // Change the Tab to BookingView
            onReservationClicked: {
                tabGroup.currentTab = tab4;
            }

            // Change the current view caption
            onStatusChanged: {
                if (status == PageStatus.Activating) {
                    appState.currentCaption = qsTr("Diner reservation information");
                }
            }
        }

        // The main level Page item acts as a tab placeholder for the TabGroup.
        Page {
            id: tab2

            // MenuListView is a sub-page for the MenuGridView, thus they
            // are defined within the pageStack.
            PageStack {
                id: pageStack
                anchors.fill: parent

                MenuGridView {
                    id: menu
                    anchors.fill: parent
                    onMenuItemClicked: {
                        // If some menu item was selected, show its contents.
                        pageStack.push(menuList);
                    }
                }

                MenuListView {
                    id: menuList
                    anchors.fill: parent

                    onStatusChanged: {
                        // Navigating deeper the PageStack causes the back
                        // button to behave differently.
                        if (status == PageStatus.Active) {
                            appState.showBackButton = true;
                        } else {
                            appState.showBackButton = false;
                        }
                    }
                }
            }

            // Start with the MenuGridView first.
            Component.onCompleted: {
                pageStack.push(menu)
            }

            onStatusChanged: {
                if (status == PageStatus.Activating) {
                    appState.currentCaption = qsTr("Diner A la Carte");
                }
            }
        }

        MapView {
            id: tab3

            // Change the current view caption
            onStatusChanged: {
                if (status == PageStatus.Activating) {
                    appState.currentCaption = qsTr("Location on map");
                }
            }
        }

        BookingView {
            id: tab4

            onStatusChanged: {
                if (status == PageStatus.Activating) {
                    appState.currentCaption = qsTr("Diner table reservation step 1/2");

                    // Store the height so that it can be restored later.
                    root._tabBarHeight = tabBar.height;
                    console.log("TabBar height2: " + root._tabBarHeight);

                    tabBar.visible = false;
                    tabBar.height = 0;
                }
            }

            onActionCompleted: {
                console.log("Restoring TabBar height: " + root._tabBarHeight);
                tabGroup.currentTab = tab1;

                tabBar.height = root._tabBarHeight;
                tabBar.visible = true;
            }
        }
    }
}
