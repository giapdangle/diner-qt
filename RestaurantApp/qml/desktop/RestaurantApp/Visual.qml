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
    property string callIconSource: "content/call_icon.png"
    property string wwwIconSource: "content/www_icon.png"
    property string titleImageSource: "content/title.png"


    // Title bar
    property int titleFontSize: 48
    property color titleFontColor: "#ffffff"
    property color titleBackgroundColor: "#7c0505"

    property string captionFontFamily: defaultFontFamily
    property int captionFontSize: 20
    property color captionFontColor: "#5a57c5"
    property color captionBackgroundColor: "#ffffff"

    property string exitButtonSource: "content/exit_button.png"
    property string exitButtonPressedSource: "content/exit_button_pressed.png"
    property string backButtonSource: "content/back_button.png"
    property string backButtonPressedSource: "content/back_button_pressed.png"

    // Tab bar    
    property string tabBarButtonFont: defaultFontFamily
    property int tabBarButtonFontSize: 16
    property color tabBarButtonFontColor: "#ffffff"

    property string infoButtonSource: "content/info_button.png"
    property string menuButtonSource: "content/menu_button.png"
    property string mapButtonSource: "content/map_button.png"
    property string bookingButtonSource: "content/booking_button.png"

    property string infoButtonPressedSource: "content/info_button_pressed.png"
    property string menuButtonPressedSource: "content/menu_button_pressed.png"
    property string mapButtonPressedSource: "content/map_button_pressed.png"
    property string bookingButtonPressedSource: "content/booking_button_pressed.png"

    // Info view

    // Menu grid view


    // Menu list view


    // Map view


    // Booking view


}
