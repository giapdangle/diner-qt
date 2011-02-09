import QtQuick 1.0
import "Util.js" as Util

XmlListModel {
    source: "content/restaurant.xml"
    query: "/restaurant/info"

    XmlRole { name: "name"; query: "name/string()" }
    XmlRole { name: "logo"; query: "logo/string()" }
    XmlRole { name: "street"; query: "address/street/string()" }
    XmlRole { name: "city"; query: "address/city/string()" }
    XmlRole { name: "country"; query: "address/country/string()" }
    XmlRole { name: "latitude"; query: "address/coordinates/latitude/string()" }
    XmlRole { name: "longitude"; query: "address/coordinates/longitude/string()" }
    XmlRole { name: "telephone"; query: "telephone/string()" }
    XmlRole { name: "url"; query: "url/string()" }
    XmlRole { name: "description"; query: "description/string()" }

    onStatusChanged: {
        if(status == XmlListModel.Ready) {
            Util.log("InfoViewModel Status: ready")
        } else if(status == XmlListModel.Error) {
            Util.log("InfoViewModel Status: error")
        } else if(status == XmlListModel.Loading) {
            Util.log("InfoViewModel Status: loading")
        }
    }
}
