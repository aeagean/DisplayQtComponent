#include "MonitorAndControlFile.h"

#include <QFileInfo>
#include <QDebug>

void MonitorAndControlFile::clear()
{
    m_engine->clearComponentCache();
}

MonitorAndControlFile::MonitorAndControlFile(QObject *parent) : QObject(parent)
{
    connect(&m_fileWatch, SIGNAL(fileChanged(QString)), this, SLOT(onFileChanged(QString)));
    m_engine = qmlEngine();
}

MonitorAndControlFile::~MonitorAndControlFile()
{
    qDebug()<<"quit";
}

QString MonitorAndControlFile::url()
{
    return m_url;
}

void MonitorAndControlFile::setUrl(QString url)
{
    QString file = url;
    QFileInfo fileInfo(file.remove("file://"));
    if (fileInfo.isFile()) {
        m_fileWatch.addPath(file);
        if (!m_monitorFiles.contains(file))
            m_monitorFiles.append(file);

        m_url = url;
        emit statusChanged();
    }
}

void MonitorAndControlFile::onFileChanged(QString file)
{
    foreach(QString file, m_monitorFiles) {
        m_fileWatch.addPath(file);
    }
    emit statusChanged();
}
