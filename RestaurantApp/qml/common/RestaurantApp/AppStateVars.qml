import QtQuick 1.0

QtObject {
    property bool loading: false
    property bool showBackButton: false;
    property bool fromLeft: false
    property bool inLandscape: false
    property string currentViewName: ""
    property string cameFromView: ""
    // Contains the title string
    property string currentTitle: ""
    // Contains the caption string
    property string currentCaption: ""
    // Populate this whenever you select a feed
    property string selectedFeedTitle: ""
    // Populate this whenever you select a feed item
    property string selectedFeedItemTitle: ""
}

