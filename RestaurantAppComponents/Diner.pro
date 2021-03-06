#
# Basic Qt configuration
#
QT += declarative
CONFIG += qt qt-components

# Version number & version string definition (for using it inside the app)
VERSION = 1.5.0
VERSTR = '\\"$${VERSION}\\"'
DEFINES += VER=\"$${VERSTR}\"

#Speed up launching on MeeGo/Harmattan when using applauncherd daemon
#CONFIG += qdeclarative-boostable

# Add more folders to ship with the application, here
common_qml.source = qml/common/RestaurantAppComponents
common_qml.target = qml
DEPLOYMENTFOLDERS = common_qml

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

# The .cpp, .h  & packaging files
HEADERS += loadhelper.h
SOURCES += main.cpp \
    loadhelper.cpp

OTHER_FILES += \
    qtc_packaging/debian_harmattan/rules \
    qtc_packaging/debian_harmattan/README \
    qtc_packaging/debian_harmattan/copyright \
    qtc_packaging/debian_harmattan/control \
    qtc_packaging/debian_harmattan/compat \
    qtc_packaging/debian_harmattan/changelog \
    qtc_packaging/debian_fremantle/rules \
    qtc_packaging/debian_fremantle/README \
    qtc_packaging/debian_fremantle/copyright \
    qtc_packaging/debian_fremantle/control \
    qtc_packaging/debian_fremantle/compat \
    qtc_packaging/debian_fremantle/changelog

# Platform specific files and configuration
symbian {
    TARGET.UID3 = 0xE4E7F3E9
    # Allow network access on Symbian
    TARGET.CAPABILITY += NetworkServices
    platform_qml.source = qml/symbian/RestaurantAppComponents
    platform_qml.target = qml
    QML_IMPORT_PATH = qml/symbian/RestaurantAppComponents
} else:maemo5 {
    QT += opengl
    platform_qml.source = qml/maemo/RestaurantAppComponents
    platform_qml.target = qml
    QML_IMPORT_PATH = qml/maemo/RestaurantAppComponents
} else:simulator {
    platform_qml.source = qml/symbian/RestaurantAppComponents
    platform_qml.target = qml
    QML_IMPORT_PATH = qml/symbian/RestaurantAppComponents
} else:win32{
    # Windows
    platform_qml.source = qml/desktop/RestaurantAppComponents
    platform_qml.target = qml
    QML_IMPORT_PATH = qml/desktop/RestaurantAppComponents
}
contains(MEEGO_EDITION,harmattan) {
    #QT += opengl
    DEFINES += Q_WS_HARMATTAN
    platform_qml.source = qml/harmattan/RestaurantAppComponents
    platform_qml.target = qml
    QML_IMPORT_PATH = qml/harmattan/RestaurantAppComponents

    # Desktop & icon -files
    desktop.files = diner.desktop
    desktop.path = /usr/share/applications
    icon_file.files = Diner.svg
    icon_file.path = /usr/share/icons/hicolor/scalable/apps
    INSTALLS += desktop icon_file
}

# Take the platform specific QML-folder files.
DEPLOYMENTFOLDERS += platform_qml

# Please do not modify the following two lines. Required for deployment.
include(qmlapplicationviewer/qmlapplicationviewer.pri)
qtcAddDeployment()
