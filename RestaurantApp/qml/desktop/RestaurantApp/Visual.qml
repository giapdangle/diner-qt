// Visual style for desktop
import QtQuick 1.0

Item {
    // General
    property string defaultFontFamily: "Tahoma"  // Defaults to correct ones in device
    property int defaultFontSize: 24
    property color defaultFontColor: "black"
    property color defaultFontColorLink: "#7c0505"
    property color defaultBackgroundColor: "#d9d3b5"

    property int scrollBarWidth: 8
    property string callIconSource: "gfx/call_icon.png"
    property string wwwIconSource: "gfx/www_icon.png"
    property string titleImageSource: "gfx/title.png"


    // Title bar
    property int titleFontSize: 48
    property color titleFontColor: "#ffffff"
    property color titleBackgroundColor: "#7c0505"

    property string captionFontFamily: defaultFontFamily
    property int captionFontSize: 20
    property color captionFontColor: "#5a57c5"
    property color captionBackgroundColor: "#ffffff"

    // Tab bar    
    property string tabBarButtonFont: defaultFontFamily
    property int tabBarButtonFontSize: 16
    property color tabBarButtonFontColor: "#ffffff"

    // Info view

    // Menu grid view


    // Menu list view


    // Map view


    // Booking view


}
