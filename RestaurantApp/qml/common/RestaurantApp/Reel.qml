import QtQuick 1.0

Rectangle {
    id: reel
    //property alias index: path.currentIndex
    property alias interactive: path.interactive
    property int index: 0
    property bool moving: false
    property ListModel model    
    property Component delegate
    property int itemsShown: 4
    property bool autoClose: true
    property alias closingDelay: clippingTimer.interval
    width: 100
    height: 100
    color: "transparent"
    clip: true
    // Bring to front if not clipped
    onClipChanged: clip ? shiftZ(reel, -500) : shiftZ(reel, 500)

    function shiftZ(obj, delta) {
        if(typeof obj.z != 'undefined') obj.z += delta
        if(obj.parent) shiftZ(obj.parent, delta) // Set z recursively to parent
    }

    onIndexChanged: path.currentIndex = reel.index/*; selectIndex()

    //TODO: figure out a way to access the enabled property on pathView instance
    function selectIndex() {
        var str = path.model.get(index).enabled ? "enabled" : "disabled";
        console.log("item " + path.model.get(index).number+" "+str+" "+path.model.get(index).enabled)

        if(path.model.get(index).enabled) {
            var checks = path.model.count/2+1;
            var last = path.model.count-1;
            for(var i = 1; i <= checks; i++) {
                if(path.model.get((index+i)%last).enabled) {
                    reel.index = (index+i)%last;
                    console.log("corrected up");
                    break;
                } else if (model.get((last+index-i)%last).enabled) {
                    reel.index = (last+index-i)%last;
                    console.log("corrected down");
                    break;
                }
            }
        }
    }*/

    PathView {
        id: path
        width: parent.width
        height: (pathItemCount-1)*parent.height
        pathItemCount: parent.itemsShown+1
        clip: true
        anchors.centerIn: parent
        model: parent.model
        delegate: reel.delegate
/*
        delegate: Loader {
            id: item
            sourceComponent: reel.delegate
            MouseArea {
                anchors.fill: parent
                onClicked: { reel.index = index; reel.clip = !reel.clip; clippingTimer.stop() }
            }
        }
*/
        preferredHighlightBegin: 0.5
        preferredHighlightEnd: 0.5
        highlightRangeMode: PathView.StrictlyEnforceRange
        focus: true

        path: Path {
            startX: path.x+path.width/2; startY: 1-reel.height/2
            PathLine {x: path.x+path.width/2; y: path.height+reel.height/2-1}
        }
        onMovementStarted: { reel.moving = true; clippingTimer.stop(); reel.clip = false}
        onMovementEnded: {            
            if(reel.autoClose) {
                clippingTimer.restart();
            }
            reel.index = path.currentIndex;
            reel.moving = false;
        }

        Timer {
            id: clippingTimer
            repeat: false; interval: 2000;
            triggeredOnStart: false; onTriggered: reel.clip = true
        }        
    }
}
