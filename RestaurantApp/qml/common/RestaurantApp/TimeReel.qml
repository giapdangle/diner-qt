import QtQuick 1.0

Item {
    id: container
    width: 140
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

    Component {
        id: timeDelegate
        Button {
            width: container.width
            height: container.height
            text: hours + ":" + minutes + " " + daytime
            fontColor: container.fontColor
            fontName: container.fontName
            fontSize: container.fontSize
            bg: itemBackground
            bgPressed: itemBackgroundPressed
            onClicked: { time.index = index; time.toggle() }
        }
    }

    Reel {
        id: time
        width: container.width
        height: container.height
        itemsShown: 6
        model: times
        delegate: timeDelegate
        autoClose: false        
    }


    ListModel {
        id: times
        ListElement { hours: "6"; minutes: "00"; daytime: "pm" }
        ListElement { hours: "6"; minutes: "30"; daytime: "pm" }
        ListElement { hours: "7"; minutes: "00"; daytime: "pm" }
        ListElement { hours: "7"; minutes: "30"; daytime: "pm" }
        ListElement { hours: "8"; minutes: "00"; daytime: "pm" }
        ListElement { hours: "8"; minutes: "30"; daytime: "pm" }
        ListElement { hours: "9"; minutes: "00"; daytime: "pm" }
        ListElement { hours: "9"; minutes: "30"; daytime: "pm" }
        ListElement { hours: "10"; minutes: "00"; daytime: "pm" }
    }

    function getTime() {
        return times.get(time.index).hours + ":" + times.get(time.index).minutes + " " + times.get(time.index).daytime
    }
}
