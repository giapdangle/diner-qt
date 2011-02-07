// Visual style for Maemo
import QtQuick 1.0

Item {
    SystemPalette { id: activePalette; colorGroup: SystemPalette.Active }

    property color applicationBackgroundStartColor: "#fbfbfb"
    property color applicationBackgroundEndColor: "#f5f5f5"
    property color titleBarBackgroundColor: "transparent"
    property color windowActiveTextColor: "black"
    property color buttonPassiveColor: "grey"
    property color buttonActiveColor: Qt.darker(buttonPassiveColor)
    property color buttonTextColor: "black"
    property color buttonBorderColor: Qt.darker(buttonPassiveColor)

    property int generalMargin: 4
    property int scrollBarWidth: 2*generalMargin
    property int listViewSpacing: 0 //4

    property string defaultFontFamily: "Helvetica"  // Defaults to correct ones in device    
    property int fontPointSizeTitle: 10
    property int fontPointSizeButton: 8
    property int fontPointSizeListItem: 6
    property int fontPointSizeBody: 8
    property color titleColor: "#44aa33"
}
