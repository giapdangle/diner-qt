import QtQuick 1.0

XmlListModel {
    source: "menu.xml"

    query: "/restaurant/menu/category"

    XmlRole { name: "title"; query: "@name/string()" }
}
