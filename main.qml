import QtQuick 2.0
import MonitorAndControlFile 1.0
import QtQuick.Window 2.0

Window {
    id: root

    property variant qmlObject

    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    MonitorAndControlFile {
        id: monitorAndControlFile
        onStatusChanged: load(url)
    }

    DropArea {
        anchors.fill: parent
        onDropped: monitorAndControlFile.url = (drop.text.replace(/[\r\n]/g,""))
    }

    function load(url) {
        if (qmlObject != undefined) {
            monitorAndControlFile.clear()
            qmlObject.destroy()
        }

        console.log("Load: ", url)

        try {
            var component = Qt.createComponent(url);
        } catch(err) {
            console.log('Error on line ' + err.qmlErrors[0].lineNumber + '\n' + err.qmlErrors[0].message);
        }

        if (component.status == Component.Error) {
            console.log("Error loading component:", component.errorString());
            return null;
        }

        if (component.status == Component.Ready) {
            qmlObject = component.createObject(root);
            qmlObject.visible = true
        }
    }
}
