import QtQuick 1.0

Item {
    id: container

    property string itemId: "NOT SET"
    property int margins: 8
    property int spacing: 8
    property string fontName: "Helvetica"
    property int titleFontSize: 12
    property int fontSize: 10
    property color fontColorTitle: "black"
    property color fontColor: "darkgrey"

    signal clicked(string itemId)

    width: 360
    // The height has to be at least the height of the image (so that the
    // images would be of the same size), but if the text altogether makes
    // the list item taller, than use the combined text height.
    height: dishTitle.height+dishDescription.height > dishImg.height ?
                dishTitle.height+dishDescription.height : dishImg.height

    Row {
        // Leave some room to the left.
        x: 4
        width: parent.width - container.spacing
        height: parent.height
        spacing: container.margins*2

        Item {
            id: dishImg
            width: parent.width * 0.2
            height: width

            Image {
                width: parent.width * 0.90
                height: width
                fillMode: Image.PreserveAspectFit
                smooth: true
                // Get the dish image from the XML. If not defined, default
                // back to the placeholder icon.
                source: dishIcon ? dishIcon : visual.foodTeaserSource
            }
        }

        Column {
            // Leave some room on top.
            y: 2
            x: 0
            width: parent.width * 0.8
            height: parent.height-2

            Text {
                id: dishTitle

                width: parent.width
                anchors {
                    leftMargin: container.margins
                    rightMargin: container.margins
                }

                text: title
                wrapMode: Text.WordWrap
                font {
                    family: container.fontName
                    pointSize: container.titleFontSize
                }
                color: fontColor
            }

            Text {
                id: dishDescription

                width: parent.width
                anchors {
                    leftMargin: container.margins
                    rightMargin: container.margins
                }
                text: description
                wrapMode: Text.WordWrap
                font {
                    family: container.fontName
                    pointSize: container.fontSize
                }
                color: container.fontColor
            }
        }
        MouseArea {
            onClicked: container.clicked(container.itemId);
        }
    }
}
