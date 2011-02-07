// Visual style for Maemo
import QtQuick 1.0

Item {
    property string defaultFontFamily: "Helvetica"  // Defaults to correct ones in device

    // Title bar
    property color titleColor: "#44aa33"
    property int titleFontSize: 12
    property color titleFontColor: "black

    // Tab bar
    property int tabBarHeight: 120
    property string tabBarButtonFont: defaultFontFamily
    property int tabBarButtonFontSize: 8
    property color tabBarButtonFontColor: "red"
}
