import QtQuick 1.0

// Dimmer Item consists of Fader and one rectangle, two states and animations between them.
// - Fader: Dimms the background & captures mouse events.
// - Rect #2: Shows an Ok/Cancel dialog with some text on it.
// - States: Handles the opacity changes for rects 1 & 2.
// - Transitions: Transitions between the dialog showing/hiding states smoothly.
Item {
    id: modalDialog

    // Text to be shown within the modal dialog.
    property string text: ""

    property string fontName: "Helvetica"
    property int fontSize: 14
    property int buttonFontSize: fontSize
    property int textFontSize: fontSize
    property color fontColor: "white"
    property color fontColorButton: "black"
    property Component buttonBackground
    property Component buttonBackgroundPressed
    property bool showCancelButton: true

    // Signals that are emitted from Ok/Cancel -buttons.
    signal accepted
    signal cancelled

    // This function will start showing the dialog.
    function show () {
        modalDialog.state = "show";
    }

    // Use Fader component to dim the background & prevent key/touch events
    // to items lying underneath the dialog. I.e. makes the dialog "modal".
    Fader {
        id: fadeRect
        anchors.fill:  parent

        // Bind main dialog's state with fader's corresponding states.
        state: modalDialog.state == "show" ? "faded" : ""
        transitionDuration: 300 // Use the same transition time as for the main dialog
    }

    // Rectangle that shows some dialog graphics, text and "Ok" & "Cancel" buttons.
    // Consists of rectangle containing some text & two buttons in a row.
    Item {
        id: dialog

        opacity: 0
        anchors.left: parent.left
        width: parent.width
        height: column.height
        anchors.verticalCenter: parent.verticalCenter

        Column {
            id: column
            width: parent.width
            //anchors.centerIn: parent.horizontalCenter
            spacing: 10

            // Given text, centered within the dialog.
            Text {
                id: dlgText
                width: parent.width
                text: modalDialog.text
                color: modalDialog.fontColor
                font {
                    family: modalDialog.fontName
                    pointSize: modalDialog.textFontSize
                }
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter
            }

            // Under the text field there's two clickable buttons.
            Row {
                spacing: 10
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    bottomMargin: 25
                }

                Button {
                    id: okButton
                    text: "OK"
                    fontColor: modalDialog.fontColorButton
                    fontName: modalDialog.fontName
                    fontSize: modalDialog.buttonFontSize
                    bg: modalDialog.buttonBackground
                    bgPressed: modalDialog.buttonBackgroundPressed
                    // On click emit "accepted" signal via the main level dialog Item
                    // and hide the dialog.
                    onClicked: {
                        console.log("Dialog Ok Button pressed");
                        modalDialog.state = "";
                        modalDialog.accepted();
                    }
                }

                Button {
                    id: cancelButton
                    text: "Cancel"
                    fontColor: modalDialog.fontColorButton
                    fontName: modalDialog.fontName
                    fontSize: modalDialog.buttonFontSize
                    bg: modalDialog.buttonBackground
                    bgPressed: modalDialog.buttonBackgroundPressed
                    visible: modalDialog.showCancelButton

                    // On click emit "cancelled" signal via the main level dialog Item
                    // and hide the dialog.
                    onClicked: {
                        console.log("Dialog Cancel Button pressed");
                        modalDialog.state = "";
                        modalDialog.cancelled();
                    }
                }
            } // Row
        }

    }

    // Originally, keep the dialog hidden. When the "show" state is being entered,
    // we show the dialog with opacity 1. The Fader component has its own
    // states & transitions, which are triggered simultaneously with ModalDialog's
    // own transitions.
    states: [
        State {
            name: ""
            PropertyChanges {
                target: dialog
                opacity: 0
            }
        },
        State {
            name: "show"
            PropertyChanges {
                target: dialog
                opacity: 1
            }
        }
    ]

    // The transitions handle changing the dialog states smoothly by animating the opacity.
    transitions: [
        Transition {
            from: ""
            to: "show"
            SequentialAnimation {
                NumberAnimation { properties: "opacity"; easing.type: Easing.Linear; duration: 300 }
            }
        },
        Transition {
            from: "show"
            to: ""
            NumberAnimation { properties: "opacity"; easing.type: Easing.Linear; duration: 300 }
        }
    ]
}
