#ifndef MONITORANDCONTROLFILE_H
#define MONITORANDCONTROLFILE_H

#include <QObject>
#include <QString>
#include <QFileSystemWatcher>
#include <QQmlApplicationEngine>

static QQmlApplicationEngine *qmlEngine()
{
    static QQmlApplicationEngine _engine;
    return &_engine;
}

class MonitorAndControlFile : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString url READ url WRITE setUrl NOTIFY statusChanged)


public:
    explicit MonitorAndControlFile(QObject *parent = nullptr);

    Q_INVOKABLE void clear();

    QString url();
    void setUrl(QString url);

signals:
    void statusChanged();

public slots:

private:
    QString m_url;
    QFileSystemWatcher m_fileWatch;
    QQmlApplicationEngine *m_engine;
};

#endif // MONITORANDCONTROLFILE_H
