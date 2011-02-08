import QtQuick 1.0

XmlListModel {
    source: "restaurant.xml"
    query: "/restaurant/menu/category"

    XmlRole { name: "title"; query: "@name/string()" }
    XmlRole { name: "itemId"; query: "@id/string()" }
}
