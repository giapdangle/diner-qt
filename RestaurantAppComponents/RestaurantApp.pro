# Files common to all platforms
common_qml.source = qml/common/RestaurantApp
common_qml.target = qml

VERSION = 1.0.2

# Platform specific files and configuration
symbian {
    TARGET.UID3 = 0xE5A4B771
    platform_qml.source = qml/symbian/RestaurantApp
    platform_qml.target = qml
    QML_IMPORT_PATH = qml/symbian/RestaurantApp
} else:maemo5 {
    QT += opengl
    platform_qml.source = qml/maemo/RestaurantApp
    platform_qml.target = qml
    QML_IMPORT_PATH = qml/maemo/RestaurantApp
    # Add library search path to find experimental Qt builds too
    QMAKE_LFLAGS += -Wl,-rpath,/opt/qt4-maemo5/lib
} else:simulator {
    platform_qml.source = qml/symbian/RestaurantApp
    platform_qml.target = qml
    QML_IMPORT_PATH = qml/symbian/RestaurantApp
} else:win32{
    # Windows
    platform_qml.source = qml/desktop/RestaurantApp
    platform_qml.target = qml
    QML_IMPORT_PATH = qml/desktop/RestaurantApp
} else:unix {
    # OS X, Linux, Unix
    platform_qml.source = qml/desktop/RestaurantApp
    platform_qml.target = qml
    QML_IMPORT_PATH = qml/desktop/RestaurantApp
}

DEPLOYMENTFOLDERS = common_qml platform_qml

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

# Avoid auto screen rotation
#DEFINES += ORIENTATIONLOCK

# Needs to be defined for Symbian
DEFINES += NETWORKACCESS

# Define QMLJSDEBUGGER to allow debugging of QML in debug builds
# (This might significantly increase build time)
# DEFINES += QMLJSDEBUGGER

# If your application uses the Qt Mobility libraries, uncomment
# the following lines and add the respective components to the 
# MOBILITY variable. 
#CONFIG += mobility
#MOBILITY += sensors

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp

# Put generated temp-files under tmp
MOC_DIR = tmp
OBJECTS_DIR = tmp
RCC_DIR = tmp
UI_DIR = tmp


# Please do not modify the following two lines. Required for deployment.
include(qmlapplicationviewer/qmlapplicationviewer.pri)
qtcAddDeployment()

OTHER_FILES += \
    qtc_packaging/debian_harmattan/rules \
    qtc_packaging/debian_harmattan/README \
    qtc_packaging/debian_harmattan/copyright \
    qtc_packaging/debian_harmattan/control \
    qtc_packaging/debian_harmattan/compat \
    qtc_packaging/debian_harmattan/changelog
