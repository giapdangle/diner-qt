import QtQuick 1.0
import com.nokia.symbian 1.0
//import com.meego 1.0 // for Meego components

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

        // Anchors titlebar to left, top and right. Then set height
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

    // -----------------------------------------------------------------------
    // Define three different kinds of TabBars. The Default tab bar is being
    // used in Info-, MenuGrid- and MapViews. Booking tab bar is used only
    // in the BookingView and the menuTabBar is used when in the MenuListView.
    // -----------------------------------------------------------------------
    //
    // Defines the "Main TabBar", shown on each Page view, but hidden when
    // in BookingView & MenuListView.
    ToolBar {
        id: defaultTabBar

        visible: true   // This TabBar is visible by default.
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        tools: toolLayout
    }

    ToolBarLayout {
        id: toolLayout
        ToolButton {
            iconSource: visual.backButtonSource
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
        ButtonRow {
            TabButton {
                id: tabButton1
                tab: infoTab
                iconSource: visual.infoButtonSource
            }

            TabButton {
                id: tabButton2
                tab: menuTab
                iconSource: visual.menuButtonSource
            }

            TabButton {
                id: tabButton3
                tab: mapTab
                iconSource: visual.mapButtonSource
            }
        }
    }

    // BookingView has it's own tabs.
    TabBar {
        id: bookingTabBar

        visible: false
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        TabButton {
            text: qsTr("Done")
//            iconSource: visual.backButtonSource
            onClicked: {
                bookingTab.done();
            }
        }
        TabButton {
            text: qsTr("Cancel")
//            iconSource: visual.infoButtonSource
            onClicked: {
                bookingTab.cancel();
            }
        }
    }

    // And yet another kind of TabBar for MenuListView.
    TabBar {
        id: menuTabBar

        visible: false
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        TabButton {
            text: qsTr("Back")
            iconSource: visual.backButtonSource
            onClicked: {
                if (appState.showBackButton == true) {
                    appState.showBackButton = false;
                    // When returning to Menu Grid view, hide the special tab bar
                    // and show the default one.
                    menuTabBar.visible = false;
                    defaultTabBar.visible = true;
                    pageStack.pop();
                }
            }
        }

        // Placeholder buttons
        TabButton {
            visible: false
        }
        TabButton {
            visible: false
        }

        TabButton {
            id: reserveButton

            tab: bookingTab
            text: qsTr("Booking")
            iconSource: visual.bookingButtonSource
            onClicked: {
                // Show the BookingView's own TabBar, and hide this one.
                menuTabBar.visible = false;
                bookingTabBar.visible = true;
                appState.cameFromView = "MenuView";
            }
        }
    }

    // The group of pages that are being used as the base for the different Tabs.
    // Each Tab/Page takes care of updating the titleBar caption.
    TabGroup {
        id: tabGroup

        anchors {
            left: parent.left;
            right: parent.right;
            top: titleBar.bottom;
            bottom: defaultTabBar.top
        }

        InfoView {
            id: infoTab

            // Change the Tab to BookingView & change the correct TabBar in place.
            onReservationClicked: {
                tabGroup.currentTab = bookingTab;
                defaultTabBar.visible = false;
                menuTabBar.visible = false;
                bookingTabBar.visible = true;
            }

            // Change the current view caption
            onStatusChanged: {
                if (status == PageStatus.Activating) {
                    appState.currentCaption = qsTr("Reservation information");
                }
            }
        }

        // The main level Page item acts as a tab placeholder for the TabGroup.
        Page {
            id: menuTab

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
                        // Change the tab bar too
                        defaultTabBar.visible = false;
                        menuTabBar.visible = true;
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
            id: mapTab

            // Change the current view caption
            onStatusChanged: {
                if (status == PageStatus.Activating) {
                    appState.currentCaption = qsTr("Location on map");
                }
            }
        }

        BookingView {
            id: bookingTab

            onStatusChanged: {
                if (status == PageStatus.Activating) {
                    appState.currentCaption = qsTr("Diner table reservation step 1/2");
                }
            }

            onActionCompleted: {
                // Reservation made successfully! Determine, in which view
                // we should return.
                bookingTabBar.visible = false;
                if (appState.cameFromView == "InfoView") {
                    // Return to InfoView tab.
                    tabGroup.currentTab = infoTab;
                    // Restore the original TabBar
                    defaultTabBar.visible = true;
                } else {
                    // Came from "MenuView".
                    // Return to MenuListView tab.
                    tabGroup.currentTab = menuTab;
                    // Restore the menu view's own TabBar
                    menuTabBar.visible = true;
                }
            }
        }
    }
}
