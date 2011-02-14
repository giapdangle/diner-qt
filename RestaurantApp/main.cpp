#include <QtGui/QApplication>
#include <QtGui/QDesktopWidget>
#include <QtDeclarative/QDeclarativeContext>
#include "qmlapplicationviewer.h"

#ifdef Q_WS_MAEMO_5
#include <QtOpenGL/QGLWidget>
#endif

#if defined(Q_WS_MAEMO_5) || defined(Q_OS_SYMBIAN)
#include <QOrientationSensor>
#include "orientationfilter.h"
QTM_USE_NAMESPACE
#endif


int main(int argc, char *argv[])
{
    // Create application
    QApplication app(argc, argv);

    // Create the viewer helper
    QmlApplicationViewer viewer;

    // Set the screen size to QML context
    QDeclarativeContext* context = viewer.rootContext();

#if defined(Q_WS_MAEMO_5) || defined(Q_OS_SYMBIAN)
    // Create an orientation sensor and add it to QML context
    QOrientationSensor sensor;
    // We use our own filter to be able to signal with QVariant the orientation because Sensors QML-plugin is not yet a part of 1.1
    OrientationFilter filter;
    sensor.addFilter(&filter);
    sensor.start();
    context->setContextProperty("filter", &filter);
#endif

    // set viewer parameters
#ifdef Q_WS_MAEMO_5
   viewer.setOrientation(QmlApplicationViewer::ScreenOrientationLockLandscape);
   context->setContextProperty("globalInLandscape", true);
#endif
#ifdef Q_OS_SYMBIAN
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationLockPortrait);
    context->setContextProperty("globalInLandscape", false);
#endif
//    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);

    viewer.setMainQmlFile(QLatin1String("qml/RestaurantApp/main.qml"));
    // For N900 set OpenGL rendering
#ifdef Q_WS_MAEMO_5
    QGLFormat fmt = QGLFormat::defaultFormat();
//    fmt.setDirectRendering(true);
    fmt.setDoubleBuffer(true);

    QGLWidget *glWidget = new QGLWidget(fmt);
    viewer.setViewport(glWidget);
#endif


#if defined(Q_WS_MAEMO_5) || defined(Q_OS_SYMBIAN)
    viewer.showFullScreen();
#else
    viewer.show();
#endif
    // Start application loop
    return app.exec();
}
