#include "MonitorAndControlFile.h"

#include <QFileInfo>
#include <QDebug>

void MonitorAndControlFile::clear()
{
    m_engine->clearComponentCache();
    m_engine->trimComponentCache();
    qDebug()<<"clear"<<m_engine;
}

MonitorAndControlFile::MonitorAndControlFile(QObject *parent) : QObject(parent)
{
    connect(&m_fileWatch, SIGNAL(fileChanged(QString)), this, SIGNAL(statusChanged()));
    m_engine = qmlEngine();
}

QString MonitorAndControlFile::url()
{
    return m_url;
}

void MonitorAndControlFile::setUrl(QString url)
{
    QString file = url;
    QFileInfo fileInfo(file.remove("file://"));
//    if (fileInfo.isFile()) {
        m_fileWatch.addPath(file);
        m_url = url;
        emit statusChanged();
//    }

}
