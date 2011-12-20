// Visual style for Symbian
import QtQuick 1.1

Item {
    // E6 has different screen resolution & aspect ratio (640x480), thus
    // there's some differentation for it separately.
    property bool isE6: false

    // General
    property string defaultFontFamily: "Helvetica"
    property color defaultFontColor: "#45291a"
    property color defaultFontColorLink: "#7c0505"
    property color defaultFontColorButton: "#ffffff"
    property color defaultBackgroundColor: "#d9d3b5"
    property double margins: 4
    property int spacing: 8
    property int defaultItemHeight: 48

    property string callButtonSource: "content/call_button.png"
    property string wwwButtonSource: "content/www_button.png"
    property string titleImageSource: "content/title.png"
    property string cancelButtonSource: "content/cancel_button.png"
    property string bookingIconSource: "content/booking_icon.png"
    property string backgroundImageSource: "content/background.jpg"
    property string foodTeaserSource: "content/food_teaser.png"

    // Title bar
    property int titleFontSize: platformStyle.fontSizeLarge
    property color titleFontColor: "#ffffff"
    property color titleBackgroundColor: "#7c0505"

    property string captionFontFamily: defaultFontFamily
    property int captionFontSize: platformStyle.fontSizeLarge
    property color captionFontColor: "#ffffff"
    property color captionBackgroundColor: "#770d0f"

    property string exitButtonSource: "content/exit_button.png"
    property string backButtonSource: "content/back_button.png"

    // Tab bar
    property string infoButtonSource: "content/info_button.png"
    property string menuButtonSource: "content/menu_button.png"
    property string mapButtonSource: "content/map_button.png"
    property string bookingButtonSource: "content/booking_button.png"

    // Info view
    property int infoViewReservationItemHeight: isE6 ? 60 : 40
    property int infoViewReservationFontSize: platformStyle.fontSizeSmall
    property int infoViewAddressFontSize: isE6 ? platformStyle.fontSizeSmall
                                               : platformStyle.fontSizeMedium
    property int infoViewFontSize: isE6 ? platformStyle.fontSizeSmall
                                        : platformStyle.fontSizeMedium
    
    // Menu grid view
    property int menuGridViewFontSize: isE6 ? 9 : 10

    // Menu list view
    property color menuListViewBackgroundColor: "#f9f6f6"
    property color menuListViewDishTitleFontColor: "#7c0505"
    property color menuListViewDishFontColor: defaultFontColor
    property int menuListTitleFontSize: 8
    property int menuListItemFontSize: 6

    // Map view
    property string zoomiInSource: "content/zoom_in.png"
    property string zoomiOutSource: "content/zoom_out.png"

    // Booking view
    property int bookingViewFontSize: isE6 ? platformStyle.fontSizeSmall
                                           : platformStyle.fontSizeMedium
}
