Diner v1.5
==========

The Diner example application demonstrates how QML can be used to build a
simple, impressive catalog-type application based on local XML data. It is
straightforward to convert the application to use internet resources instead of
local XML resources. The application is designed in such a way that it is easy
to replace the content and visual style for different restaurants. The
application utilises the Qt Quick Components throughout, for example in the
navigation (PageStack, ToolBar), Dialogs, Buttons, and so on.

This application features tab-based navigation, using TabGroup and ToolBar
components. The UI of the updated version is implemented using mostly Qt Quick
Components, but it also has some custom graphics and UI elements, designed to
be reusable in other applications as well. The booking view also introduces the
experimental com.nokia.extras components, namely DatePicker and TimePicker.

This example application is hosted in GitHub:
https://github.com/nokia-developer/diner-qt

For more information on the implementation, visit the wiki page:
https://github.com/nokia-developer/diner-qt/wiki


IMPORTANT CLASSES AND QML ELEMENTS
-------------------------------------------------------------------------------

Qt:
- QmlApplicationViewer, QDeclarativeView, QTimer

Standard QML elements used:
- Component
- Item
- Rectangle
- Text
- TextField
- Image
- XmlListModel
- ListModel
- ListView
- Flickable
- FocusScope
- GridView
- Column
- Row
- Flow
- FocusScope
- MouseArea

QML elements from Qt Quick Components used:
- Window
- Page
- PageStack
- ScrollDecorator
- StatusBar
- ToolBar
- ToolBarLayout
- ToolButton / ToolIcon
- TabGroup
- ButtonRow
- Button


FILES
-------------------------------------------------------------------------------

design/*

- UI design files

RestaurantAppComponents/*

- The Diner application itself. Contains a PRO file that can be opened in
  Qt SDK 1.1.4

screenhots/*

- Screenshots for the wiki page

  
INSTALLATION INSTRUCTIONS
-------------------------------------------------------------------------------

Symbian^3 phone
~~~~~~~~~~~~~~~

There are two ways to install the application on the device.

1. a) Drag the Diner_1.5.0_installer.sis file to the Nokia Suite while
      your phone is connected with a USB cable.
   
   OR
   
   b) Send the application directly to the Messaging Inbox (for example,
      over a Bluetooth connection).

2. After the installation is complete, return to the application menu and
   open the Applications folder.
   
3. Locate the Diner icon and select it to launch the application.


Nokia N9
~~~~~~~~

1. Copy the diner_1.5.0_armel.deb file into a specific folder on the
   phone (for example, 'MyDocs').

2. Start XTerm. Type 'sudo gainroot' to get root access.

3. 'cd' to the directory to which you copied the package
   (for example, 'cd MyDocs').

4. As root, install the package:
   dpkg -i diner_1.5.0_armel.deb

5. Launch the Applications menu.

6. Locate the Diner icon and select it to launch the application.


COMPATIBILITY
-------------------------------------------------------------------------------

- Symbian^3 with Qt version 4.7.4 or higher

- Nokia N9 or N950 with Qt 4.7.4

Tested on:

- Nokia E6
- Nokia E7-00
- Nokia N9

Developed with:

- Qt SDK 1.1.4


VERSION HISTORY
-------------------------------------------------------------------------------
v1.5	Added support for Nokia E6 and splash screens. UI fine tuning and some refactoring.
v1.4	Changed correct ToolBar buttons, layout and font color tweaking etc.
v1.3	Version published on the Nokia Developer website.
v1.2.1	Replaced the custom 'Back' button with the platform one. Landscape 
        fixes.
v1.2	Utilised QtQuick components and updated the application look and feel.
v0.1.7	Initial version published in Forum Nokia Projects.
