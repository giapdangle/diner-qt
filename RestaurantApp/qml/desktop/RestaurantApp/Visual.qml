// Visual style for desktop
import QtQuick 1.0

Item {
    SystemPalette { id: activePalette; colorGroup: SystemPalette.Active }

    property color buttonTextColor: "black"

    property int generalMargin: 4
    property int scrollBarWidth: 2*generalMargin
    property int listViewSpacing: 0 //4

    property string defaultFontFamily: "Tahoma"  // Defaults to correct ones in device

    // Title bar
    property color titleColor: "#44aa33"
    property int titleFontSize: 24

    // Tab bar
    property int tabBarHeight: 80
    property int tabBarButtonFont: defaultFontFamily
    property int tabBarButtonFontSize: 16
    property color tabBarButtonFontColor: "black"
}
