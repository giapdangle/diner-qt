.pragma library

var LOGGING_TAG = "RESTAURANT"

function log(message) {
    console.log("[" + LOGGING_TAG + "] " + message);
}

function exitApp(message) {
    if (message) {
        log("Exiting app: " + message);
    } else {
        log("Exiting app")
    }
    Qt.quit();
}
