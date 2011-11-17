import QtQuick 1.1
import "Components.js" as Util

Rectangle {
    id: container

    property int margins: 8
    property string iconSource: "content/placeholder_icon.png"
    property string caption: "CAPTION"
    property string captionFontName: "Helvetica"
    property int captionFontSize: 24
    property color captionFontColor: "black"
    property bool captionFontBold: false
    property color captionBackgoundColor: "white"

    // Default values, change when using
    width: 360
    height: 25
    color: captionBackgoundColor

    Text {
        id: captionText

        anchors {
            bottom: container.bottom
            left: parent.left
            right: parent.right
            leftMargin: container.margins
            rightMargin: container.margins
        }

        font {
            bold: container.captionFontBold
            family: container.captionFontName
            pointSize: container.captionFontSize
        }

        clip: true
        color: container.captionFontColor
        text: container.caption
        elide: Text.ElideLeft
        textFormat: Text.RichText
        horizontalAlignment: Text.AlignHCenter
    }
}
