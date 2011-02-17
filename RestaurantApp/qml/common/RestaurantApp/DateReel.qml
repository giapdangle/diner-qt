import QtQuick 1.0

Item {
    id: container
    width: 240
    height:  60
    property bool pastDates: true    
    property int yearWidth: (width-2*margins)*0.4
    property int yearHeight: height
    property int monthWidth: (width-2*margins)*0.3
    property int monthHeight: height
    property int dayWidth: (width-2*margins)*0.3
    property int dayHeight: height
    property string fontName: 'Helvetica'
    property int fontSize: 22
    property color fontColor: "#666666"
    property int margins: 8
    property Component itemBackground: Component {
        BorderImage {
            border { top: 8; bottom: 8; left: 8; right: 8 }
            source: "gfx/button.png"
        }
    }
    property Component itemBackgroundPressed: Component {
        BorderImage {
            border { top: 8; bottom: 8; left: 8; right: 8 }
            source: "gfx/button_pressed.png"
        }
    }

    Component {
        id: yearDelegate
        Button {
            width: container.yearWidth
            height: container.yearHeight
            text: number
            fontColor: container.fontColor
            fontName: container.fontName
            fontSize: container.fontSize
            bg: itemBackground
            bgPressed: itemBackgroundPressed
            onClicked: { year.index = index; year.toggle() }
        }
    }

    Component {
        id: monthDelegate
        Button {
            width: container.monthWidth
            height: container.monthHeight
            text: number
            fontColor: container.fontColor
            fontName: container.fontName
            fontSize: container.fontSize
            bg: itemBackground
            bgPressed: itemBackgroundPressed
            onClicked: { month.index = index; month.toggle() }
        }
    }

    Component {
        id: dayDelegate
        Button {
            width: container.dayWidth
            height: container.dayHeight
            text: number
            fontColor: container.fontColor
            fontName: container.fontName
            fontSize: container.fontSize
            bg: itemBackground
            bgPressed: itemBackgroundPressed
            onClicked: { day.index = index; day.toggle() }
            opacity: (index+1 < days.start || index+1 > days.end) ? 0.5 : 1.0
        }
    }
    Row {
        id: reels
        spacing: container.margins

        Reel {
            id: year
            width: container.yearWidth
            height: container.yearHeight
            model: years
            delegate: yearDelegate
            autoClose: false            
        }

        Reel {
            id: month
            width: container.monthWidth
            height: container.monthHeight
            model: months
            delegate: monthDelegate
            onIndexChanged: days.update()
            autoClose: false            
        }

        Reel {
            id: day
            width: container.dayWidth
            height: container.dayHeight
            // TODO: replace this by more general solution to Reel component or fix the following line
            //(if e.g. disabled 31 is selected, it now scrolls the first enabled day , although it should choose the last enabled day)
            onIndexChanged: if (index+1 < days.start || index+1 > days.end) index = (((days.count - days.end + index + 1) >  days.start - (index + 1)) ? days.start : days.end) - 1
            model: days
            delegate:  dayDelegate
            autoClose: false            
        }
    }


    ListModel{
        id: years        
        ListElement { number: "2011" }
        ListElement { number: "2012" }
        ListElement { number: "2013" }
        ListElement { number: "2014" }
        ListElement { number: "2015" }
        ListElement { number: "2016" }
    }

    ListModel{
        id: months
        ListElement { number: "1"; name: "January" }
        ListElement { number: "2"; name: "February" }
        ListElement { number: "3"; name: "March" }
        ListElement { number: "4"; name: "April" }
        ListElement { number: "5"; name: "May" }
        ListElement { number: "6"; name: "June" }
        ListElement { number: "7"; name: "July" }
        ListElement { number: "8"; name: "August" }
        ListElement { number: "9"; name: "September" }
        ListElement { number: "10"; name: "October" }
        ListElement { number: "11"; name: "November" }
        ListElement { number: "12"; name: "December" }
    }

    ListModel {
        id: days
        property int start: 1
        property int end: 31
        Component.onCompleted: days.init()

        function init() {
            update();
            var date = new Date();
            month.index = date.getMonth();
            day.index = date.getDate()-1;
        }

        function update() {            
            var date = new Date();
            var year = date.getFullYear();
            days.start = 1;
            if (month.index < date.getMonth()) year++;
            else if (month.index === date.getMonth()) days.start = date.getDate();

            days.end = 32 - new Date(year, month.index, 32).getDate();

            if(day.index < days.start) day.index = days.start-1;
            else if (day.index > end ) day.index = days.end-1;
        }

        ListElement { number: "1"}
        ListElement { number: "2"}
        ListElement { number: "3"}
        ListElement { number: "4"}
        ListElement { number: "5"}
        ListElement { number: "6"}
        ListElement { number: "7"}
        ListElement { number: "8"}
        ListElement { number: "9"}
        ListElement { number: "10"}
        ListElement { number: "11"}
        ListElement { number: "12"}
        ListElement { number: "13"}
        ListElement { number: "14"}
        ListElement { number: "15"}
        ListElement { number: "16"}
        ListElement { number: "17"}
        ListElement { number: "18"}
        ListElement { number: "19"}
        ListElement { number: "20"}
        ListElement { number: "21"}
        ListElement { number: "22"}
        ListElement { number: "23"}
        ListElement { number: "24"}
        ListElement { number: "25"}
        ListElement { number: "26"}
        ListElement { number: "27"}
        ListElement { number: "28"}
        ListElement { number: "29"}
        ListElement { number: "30"}
        ListElement { number: "31"}
    }

    function getDate() {
        return "" + months.get(month.index).name + " " + days.get(day.index).number

    }
}
