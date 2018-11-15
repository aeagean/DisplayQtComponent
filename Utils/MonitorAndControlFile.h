#ifndef MONITORANDCONTROLFILE_H
#define MONITORANDCONTROLFILE_H

#include <QObject>
#include <QString>
#include <QFileSystemWatcher>
#include <QQmlApplicationEngine>



class MonitorAndControlFile : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString url READ url WRITE setUrl NOTIFY statusChanged)

public:
    explicit MonitorAndControlFile(QObject *parent = nullptr);
    virtual ~MonitorAndControlFile();
    Q_INVOKABLE void clear();

    static QQmlApplicationEngine *qmlEngine()
    {
        static QQmlApplicationEngine _engine;
        return &_engine;
    }

    QString url();
    void setUrl(QString url);

signals:
    void statusChanged();

public slots:
    void onFileChanged(QString file);

private:
    QString m_url;
    QFileSystemWatcher m_fileWatch;
    QStringList m_monitorFiles;
    QQmlApplicationEngine *m_engine;
};

#endif // MONITORANDCONTROLFILE_H
