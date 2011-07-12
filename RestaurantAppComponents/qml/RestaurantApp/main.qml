import QtQuick 1.0
import com.nokia.symbian 1.0
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
        height: appState.inLandscape ? root.width * 0.12 : root.height*0.12
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
            showingBackButton = false;
            pageStack.pop();
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
        }
        TabButton {
            tab: tab1
            text: qsTr("Info")
            iconSource: pressed ? visual.infoButtonPressedSource : visual.infoButtonSource
        }
        TabButton {
            tab: tab2;
            text: qsTr("Menu")
            iconSource: pressed ? visual.menuButtonPressedSource : visual.menuButtonSource
        }
        TabButton {
            tab: tab3;
            text: qsTr("Map")
            iconSource: pressed ? visual.mapButtonPressedSource : visual.mapButtonSource
        }
        TabButton {
            tab: tab4;
            text: qsTr("Booking")
            iconSource: pressed ? visual.bookingButtonPressedSource : visual.bookingButtonSource
        }
    }

    TabGroup {
        id: tabGroup
        anchors { left: parent.left; right: parent.right; top: titleBar.bottom; bottom: tabBar.top }
        InfoView {
            id: tab1
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
                        // Control showing the back -button in the title bar.
                        if (status == PageStatus.Active) {
                            titleBar.showingBackButton = true;
                        } else {
                            titleBar.showingBackButton = false;
                        }
                    }
                }
            }

            // Start with the MenuGridView first.
            Component.onCompleted: {
                pageStack.push(menu)
            }
        }

        MapView {
            id: tab3
        }

        BookingView {
            id: tab4
        }
    }
}
