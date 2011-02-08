import QtQuick 1.0

XmlListModel {
    source: "restaurant.xml"
    query: "/restaurant/info"

    XmlRole { name: "address"; query: "address/string()" }
    XmlRole { name: "city"; query: "city/string()" }
    XmlRole { name: "country"; query: "country/string()" }
    XmlRole { name: "latitude"; query: "coordinates/latitude/string()" }
    XmlRole { name: "longitude"; query: "coordinates/longitude/string()" }
    XmlRole { name: "telephone"; query: "telephone/string()" }
    XmlRole { name: "url"; query: "url/string()" }
    XmlRole { name: "description"; query: "description/string()" }
}
