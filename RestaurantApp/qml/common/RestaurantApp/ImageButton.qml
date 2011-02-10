import QtQuick 1.0

Item {
    id: container

    property string buttonName: "NOT SET"
    property string target: "NOT SET"
    property string text: ""

    property bool active: false
    property string bgImage: "gfx/placeholder_icon.png"
    property string bgImagePressed: "gfx/placeholder_icon.png"
    property string bgImageActive: bgImagePressed

    signal clicked(string target, string button)

    width: 50
    height: 50

    opacity: enabled ? 1.0 : 0.5

    Image {
        id: background
        source: bgImage;
        fillMode: "PreserveAspectFit"
        anchors.fill: parent
        smooth: true
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: container.clicked(container.target, container.buttonName);
    }

    states: [
        State {
            name: 'pressed'; when: mouseArea.pressed
            PropertyChanges { target: background; source: bgImagePressed; }
        },
        State {
            name: 'active'; when: container.active
            PropertyChanges { target: background; source: bgImageActive; }
        }
    ]


}
