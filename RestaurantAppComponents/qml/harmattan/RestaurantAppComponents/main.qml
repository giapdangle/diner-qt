import QtQuick 1.1
import com.nokia.meego 1.0

import "Components.js" as Util

Window {
    id: root
    anchors.fill: parent

    Component.onCompleted: {
        // "theme" comes magically from somewhere. No clue where.
        theme.inverted = true;
        tabGroup.currentTab = infoTab;
    }

    StatusBar {
        id: statusBar
        anchors.top: parent.top
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
        inLandscape: !root.inPortrait
    }

    // -----------------------------------------------------------------------
    // Define three different kinds of ToolBars/TabBars. The Default toolbar
    // is used in Info-, MenuGrid- and MapViews. Booking tab bar is used only
    // in the BookingView and the menuTabBar is used when in the MenuListView.
    // -----------------------------------------------------------------------
    //
    // Defines the "Main ToolBar" layout, shown on each Page view, but replaced
    // by menuListTools when in MenuListView and hidden when in BookingView.
    ToolBarLayout {
        id: defaultTools

        // There's no "Back" -button on Harmattan, because the Swipe
        // is being used to exit the application.
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

    // A bit differend kind of ToolBar for MenuListView.
    // Introduces the "Back" -button for returning
    ToolBarLayout {
        id: menuListTools

        ToolIcon {
            iconId: "toolbar-back"

            onClicked: {
                if (appState.showBackButton === true) {
                    appState.showBackButton = false;
                    // When returning to Menu Grid view, hide the special
                    // tab bar and show the default one.
                    sharedToolBar.tools = defaultTools;
                    pageStack.pop();
                }
            }
        }

        ToolIcon {
            id: reserveButton

            iconSource: visual.bookingButtonSource
            onClicked: {
                // Show the BookingView's own TabBar.
                appState.cameFromView = "MenuView";
                tabGroup.currentTab = bookingTab;
            }
        }

        ToolIcon {
            iconSource: ""
            enabled: false
        }
    }

    // BookingView has it's completely own ToolBar(Layout).
    ToolBarLayout {
        id: bookingTools

        ToolButton {
            text: qsTr("Done")
            onClicked: {
                bookingTab.done();
            }
        }
        ToolButton {
            text: qsTr("Cancel")
            onClicked: {
                bookingTab.cancel();
            }
        }
    }

    // The ToolBar instance itself. Default tools layout defined above.
    ToolBar {
        id: sharedToolBar

        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        tools: defaultTools
    }

    // The group of pages that are being used as the base for the different Tabs.
    // Each Tab/Page takes care of updating the titleBar caption.
    TabGroup {
        id: tabGroup

        anchors {
            left: parent.left;
            right: parent.right;
            top: titleBar.bottom;
            bottom: sharedToolBar.top
        }

        InfoView {
            id: infoTab
            tools: defaultTools
            anchors.fill: parent

            // Change the Tab to BookingView & change the correct TabBar in place.
            onReservationClicked: {
                tabGroup.currentTab = bookingTab;
            }

            // Change the current view caption
            onStatusChanged: {
                if (status == PageStatus.Activating) {
                    appState.currentCaption = qsTr("Diner information");
                }
            }
        }

        // The main level Page item acts as a tab placeholder for the TabGroup.
        Page {
            id: menuTab
            anchors.fill: parent

            // MenuListView is a sub-page for the MenuGridView, thus they
            // are defined within the pageStack.
            PageStack {
                id: pageStack
                anchors.fill: parent

                MenuGridView {
                    id: menu
                    anchors.fill: parent
                    tools: defaultTools

                    onMenuItemClicked: {
                        // If some menu item was selected, show its contents.
                        pageStack.push(menuList);
                        // Change the correct tools in place.
                        sharedToolBar.tools = menuListTools;
                    }

                    onStatusChanged: {
                        if (status == PageStatus.Activating) {
                            appState.currentCaption = qsTr("A la Carte");
                        }
                    }
                }

                MenuListView {
                    id: menuList

                    anchors.fill: parent
                    tools: menuListTools
                    onStatusChanged: {
                        // Navigating deeper the PageStack causes the back
                        // button to behave differently.
                        if (status == PageStatus.Active) {
                            appState.showBackButton = true;
                            appState.currentCaption =
                                    appState.selectedMenuCategoryTitle;
                        } else {
                            appState.showBackButton = false;
                        }
                    }
                }
            }

            // Start with the MenuGridView first.
            Component.onCompleted: {
                pageStack.push(menu);
            }
        }

        MapView {
            id: mapTab
            tools: defaultTools
            anchors.fill: parent

            // Change the current view caption
            onStatusChanged: {
                if (status == PageStatus.Activating) {
                    appState.currentCaption = qsTr("Location on map");
                }
            }
        }

        BookingView {
            id: bookingTab
            anchors.fill: parent
            tools: bookingTools

            onStatusChanged: {
                if (status == PageStatus.Activating) {
                    appState.currentCaption = qsTr("Diner table reservation");
                    sharedToolBar.tools = bookingTools;
                } else if (status == PageStatus.Deactivating) {
                    if (appState.cameFromView == "MenuView") {
                        sharedToolBar.tools = menuListTools;
                    } else {
                        // Set the default tools
                        sharedToolBar.tools = defaultTools;
                    }
                }
            }

            onActionCompleted: {
                // Reservation made successfully! Determine, in which view
                // we should return.
                if (appState.cameFromView == "InfoView") {
                    // Return to InfoView tab.
                    tabGroup.currentTab = infoTab;
                } else {
                    // Came from "MenuView".
                    // Return to MenuListView tab.
                    tabGroup.currentTab = menuTab;
                }
            }
        }
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

        height: appState.inLandscape ? root.width*0.04 : root.height*0.06
        width: root.width
        captionFontName: visual.captionFontFamily
        captionFontSize: visual.captionFontSize
        captionFontColor: visual.captionFontColor
        captionBackgoundColor: visual.captionBackgroundColor
        caption: appState.currentCaption
    }
}
