import QtQuick 1.1

XmlListModel {
    source: "content/restaurant.xml"
    query: "/restaurant/menu/category"

    XmlRole { name: "title"; query: "@name/string()" }
    XmlRole { name: "itemId"; query: "@id/string()" }
    XmlRole { name: "iconSource"; query: "@icon/string()" }
}
