import QtQuick 1.1

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
    // Selected id when clicked on menu category from the grid
    property string selectedMenuCategoryId: ""
    // Selected name when clicked on menu category from the grid
    property string selectedMenuCategoryTitle: ""
    // Selected icon when clicked on menu category from the grid
    property string selectedMenuCategoryIconSource: ""
}

