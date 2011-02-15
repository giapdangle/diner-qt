#include <QtGui/QApplication>
#include <QtGui/QDesktopWidget>
#include <QtDeclarative/QDeclarativeContext>
#include "qmlapplicationviewer.h"

#ifdef Q_WS_MAEMO_5
#include <QtOpenGL/QGLWidget>
#endif

int main(int argc, char *argv[])
{
    // Create application
    QApplication app(argc, argv);

    // Create the viewer helper
    QmlApplicationViewer viewer;

    // Set the screen size to QML context
    QDeclarativeContext* context = viewer.rootContext();

    // set viewer parameters
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);

    viewer.setMainQmlFile(QLatin1String("qml/RestaurantApp/main.qml"));
    // For N900 set OpenGL rendering
#ifdef Q_WS_MAEMO_5
    QGLFormat fmt = QGLFormat::defaultFormat();
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
