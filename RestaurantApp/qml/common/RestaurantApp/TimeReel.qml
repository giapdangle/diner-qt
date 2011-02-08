import Qt 4.7

Item {
    id: container
    width: 140
    height: 60
    property string fontName: 'Helvetica'
    property int fontSize: 22
    property int margin: 10
    property color color: "#444444"
    property Gradient gradient: Gradient {
        GradientStop { position: 0.3; color: "#eeeeee" }
        GradientStop { position: 1.0; color: "#dddddd" }
    }

    Component {
        id: timeDelegate
        Rectangle {
            width: container.width
            height: container.height
            gradient: container.gradient
            Text {
                anchors.centerIn: parent
                text: hours + ":" + minutes + " " + daytime
                color: container.color
                font.pixelSize: container.fontSize
                font.family: container.fontName
            }
        }
    }

    Reel {
        id: time
        width: container.width
        height: container.height
        itemsShown: 6
        model: times
        delegate: timeDelegate
        Rectangle {
            anchors.fill: parent
            border.width: 1
            border.color: container.color
            color: "transparent"
        }
    }


    // TODO: fetch dates from backend
    ListModel {
        id: times
        ListElement {
            hours: "06"
            minutes: "01"
            daytime: "a.m."
        }
        ListElement {
            hours: "06"
            minutes: "01"
            daytime: "a.m."
        }
        ListElement {
            hours: "06"
            minutes: "01"
            daytime: "a.m."
        }
        ListElement {
            hours: "06"
            minutes: "01"
            daytime: "a.m."
        }
        ListElement {
            hours: "06"
            minutes: "01"
            daytime: "a.m."
        }
        ListElement {
            hours: "06"
            minutes: "01"
            daytime: "a.m."
        }
        ListElement {
            hours: "06"
            minutes: "01"
            daytime: "a.m."
        }
        ListElement {
            hours: "06"
            minutes: "01"
            daytime: "a.m."
        }
        ListElement {
            hours: "06"
            minutes: "01"
            daytime: "a.m."
        }
    }
}
