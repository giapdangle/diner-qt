// Visual style for desktop
import QtQuick 1.0

Item {
    // General
    property string defaultFontFamily: "Tahoma"  // Defaults to correct ones in device
    property int defaultFontSize: 12
    //property color defaultFontColor: "#6f6a5c"
    property color defaultFontColor: "#767164"
    property color defaultFontColorLink: "#7c0505"
    property color defaultFontColorButton: "#ffffff"
    property color defaultBackgroundColor: "#d9d3b5"
    property double margins: 8
    property int spacing: 8
    property int defaultItemHeight: 48

    property int scrollBarWidth: 8
    property Component buttonComponent: Component {
        BorderImage {
            border { top: 8; bottom: 8; left: 8; right: 8 }
            source: "content/button.png"
        }
    }
    property Component buttonPressedComponent: Component {
        BorderImage {
            border { top: 8; bottom: 8; left: 8; right: 8 }
            source: "content/button_pressed.png"
        }
    }
    property Component textFieldComponent: Component {
        BorderImage {
            border { top: 8; bottom: 8; left: 8; right: 8 }
            source: "content/text_field.png"
        }
    }
    property Component textFieldActiveComponent: Component {
        BorderImage {
            border { top: 8; bottom: 8; left: 8; right: 8 }
            source: "content/text_field_active.png"
        }
    }

    property string callButtonSource: "content/call_button.png"
    property string callButtonPressedSource: "content/call_button_pressed.png"
    property string wwwButtonSource: "content/www_button.png"
    property string wwwButtonPressedSource: "content/www_button_pressed.png"
    property string titleImageSource: "content/title.png"
    property string cancelButtonSource: "content/cancel_button.png"
    property string cancelButtonPressedSource: "content/cancel_button.png"
    property string bookingIconSource: "content/booking_icon.png"


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
    property color menuListViewBackgroundColor: "#f9f6f6"
    property color menuListViewDishTitleFontColor: "#7c0505"
    property color menuListViewDishFontColor: "#938282"
    property int menutListViewTitleSize: 18


    // Map view
    property string zoomiInSource: "content/zoom_in.png"
    property string zoomiOutSource: "content/zoom_out.png"
    property int infoFontSize: 18


    // Booking view


}
