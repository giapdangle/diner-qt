import QtQuick 1.0

import "Util.js" as Util
import "Store.js" as Store

ListModel {
    id: model

    Component.onCompleted: {
        // Comment the following line and run once to restore the initial state with predefined content.
        Store.restore(model);
    }

    Component.onDestruction: {
        Store.store(model)
    }

    function addReservation(name, phone, people, dateTime) {
        Util.log("addReservation: "+name+" "+phone+" "+" "+people+" "+dateTime)
        model.append({"name": name,
                     "phone": phone,
                     "people": people,
                     "dateTime": dateTime})
    }
}
