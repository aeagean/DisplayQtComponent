#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQmlEngine>

#include "MonitorAndControlFile.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qmlRegisterType<MonitorAndControlFile>("MonitorAndControlFile", 1, 0, "MonitorAndControlFile");

    MonitorAndControlFile::qmlEngine()->load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
