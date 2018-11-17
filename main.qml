import QtQuick 2.0
import MonitorAndControlFile 1.0
import QtQuick.Window 2.0

Window {
    id: root

    property variant qmlObjects: []

    visible: true
    width: 320
    height: 240
    title: qsTr("QML组件显示器v0.3")

    Text {
        anchors.centerIn: parent
        font.pixelSize: 16
        color: "gray"
        text: "将QML文件拖到这里显示"
    }

    MonitorAndControlFile {
        id: monitorAndControlFile
        onStatusChanged: load(url)
    }

    DropArea {
        anchors.fill: parent
        onDropped: monitorAndControlFile.url = (drop.text.replace(/[\r\n]/g,""))
    }

    function load(url) {
        monitorAndControlFile.clear()

        for (var i = 0; i < qmlObjects.length; i++) {
            var obj = qmlObjects[i]
            obj.visible = false
            console.log(obj)
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
            var object = component.createObject(root);
            object.visible = true
            qmlObjects.push(object)
        }
    }
}
