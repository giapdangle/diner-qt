#include <QtGui/QApplication>
#include "qmlapplicationviewer.h"

#ifdef Q_WS_MAEMO_5
#include <QtOpenGL/QGLWidget>
#endif

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QmlApplicationViewer viewer;
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationLockPortrait);
    viewer.setMainQmlFile(QLatin1String("qml/RestaurantAppPano/main.qml"));

    // For N900 set OpenGL rendering
#ifdef Q_WS_MAEMO_5
    QGLFormat fmt = QGLFormat::defaultFormat();
    fmt.setDoubleBuffer(true);

    QGLWidget *glWidget = new QGLWidget(fmt);
    viewer.setViewport(glWidget);
#endif

#if defined(Q_WS_MAEMO_5) || defined(Q_OS_SYMBIAN) || defined(QT_SIMULATOR)
    viewer.showFullScreen();
#else
    viewer.show();
#endif

    return app.exec();
}
