import QtQuick 1.0

Item {
    id: container

    property string target: "NOT SET"
    property string text: "NOT SET"

    property string fontName: "Helvetica"
    property int fontSize: 14
    property color fontColor: "black"

    property bool active: false

    property string bgImage: 'gfx/text_field.png';
    property string bgImagePressed: 'gfx/button_pressed.png';
    property string bgImageActive: 'gfx/button_active.png';

    signal clicked(string target, string button)

    width: 140
    height: 60
    opacity: enabled ? 1.0 : 0.5    

    BorderImage {
        id: background
        border { top: 11; bottom: 40; left: 38; right: 38; }
        source: bgImage
        width: parent.width
        height: parent.height
    }

    TextInput {
        id: input
        text: parent.text

        anchors {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }
        font {
            family: container.fontName
            pointSize: container.fontSize
        }
        color: container.fontColor
    }


    states: [
        State {
            name: 'pressed'; when: input.focus
            PropertyChanges { target: background; source: bgImagePressed; border { left: 38; top: 37; right: 38; bottom: 15 } }
        },
        State {
            name: 'active'; when: input.focus
            PropertyChanges { target: background; source: bgImageActive; }
        }
    ]
}
