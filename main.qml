import QtQuick 2.6
import MonitorAndControlFile 1.0
import QtQuick.Window 2.0

Window {
    id: root

    property variant qmlObjects: []

    visible: true
    width: 320*1.5
    height: 240*1.5
    title: qsTr("QML组件动态显示器v0.3")

    Column {
        Item {
            width: root.width; height: root.height - background.height
            Column {
                anchors.centerIn: parent
                spacing: 10

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: 24
                    color: "gray"
                    text: "将QML文件拖到这里显示"
                }

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: 24
                    color: "gray"
                    text: "修改QML文件实时动态刷新"
                }
            }
        }

        Image {
            id: background
            anchors.horizontalCenter: parent.horizontalCenter
            width: root.width*0.8; height: width*800/2800
            source: "qrc:/Other/xiaoxuesheng.jpg"
        }
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
//            obj.visible = false
//            console.log(obj)
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
