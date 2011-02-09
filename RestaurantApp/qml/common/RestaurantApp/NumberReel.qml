import Qt 4.7

Item {
    id: container
    width: 60
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
        id: listDelegate
        Rectangle {
            width: container.width
            height: container.height
            gradient: container.gradient
            Text {
                anchors.centerIn: parent
                text: number
                color: container.color
                font.pixelSize: container.fontSize
                font.family: container.fontName
            }
        }
    }

    Reel {
        id: reel
        width: container.width
        height: container.height
        itemsShown: 6
        model: listModel
        delegate: listDelegate
        Rectangle {
            anchors.fill: parent
            border.width: 1
            border.color: container.color
            color: "transparent"
        }
    }

    ListModel {
        id: listModel
        ListElement { number: "1" }
        ListElement { number: "2" }
        ListElement { number: "3" }
        ListElement { number: "4" }
        ListElement { number: "5" }
        ListElement { number: "6" }
        ListElement { number: "7" }
        ListElement { number: "8" }
        ListElement { number: "9" }
        ListElement { number: "10" }
    }

    function number() {
        return listModel.get(reel.index).number
    }
}
