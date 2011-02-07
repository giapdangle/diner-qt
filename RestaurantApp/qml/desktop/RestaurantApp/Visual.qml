// Visual style for desktop
import QtQuick 1.0

Item {
    property string defaultFontFamily: "Tahoma"  // Defaults to correct ones in device

    // Title bar
    property color titleColor: "#44aa33"
    property int titleFontSize: 24
    property color titleFontColor: "black"

    // Tab bar
    property int tabBarHeight: 80
    property string tabBarButtonFont: defaultFontFamily
    property int tabBarButtonFontSize: 16
    property color tabBarButtonFontColor: "black"
}
