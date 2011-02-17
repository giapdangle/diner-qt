import QtQuick 1.0

Item {
    id: container
    width: 81
    height: 60
    property string fontName: 'Helvetica'
    property int fontSize: 22
    property color fontColor: "#444444"
    property int margin: 8
    property Component itemBackground: Component {
        BorderImage {
            border { top: 8; bottom: 8; left: 8; right: 8 }
            source: "gfx/button.png"
        }
    }
    property Component itemBackgroundPressed: Component {
        BorderImage {
            border { top: 8; bottom: 8; left: 8; right: 8 }
            source: "gfx/button_pressed.png"
        }
    }
    signal opened()
    function close() {
        reel.close();
    }

    Component {
        id: listDelegate
        Button {
            width: container.width
            height: container.height
            text: number
            fontColor: container.fontColor
            fontName: container.fontName
            fontSize: container.fontSize
            bg: itemBackground
            bgPressed: itemBackgroundPressed
            onClicked: { reel.index = index; reel.toggle() }
        }
    }

    Reel {
        id: reel
        width: container.width
        height: container.height
        itemsShown: 6
        model: listModel
        delegate: listDelegate
        autoClose: false
        onOpened: container.opened()
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

    function getNumber() {
        return listModel.get(reel.index).number
    }
}
