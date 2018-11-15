import QtQuick 2.7
import QtQuick.Window 2.2

Window {
    id: root
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    DropArea {
        anchors.fill: parent
        onDropped: {
//            console.log("drop.text: ", drop.text)

//            loader.source = ""
////            loader.source = drop.text
//            loader.setSource(drop.text)
            loadButton(drop.text)
        }
    }

    Timer {
        interval: 1000; running: true; repeat: true
        onTriggered: loadButton("C:/Users/Strong/Downloads/WheelView.qml")
    }

    function loadButton(url) {
        var component = Qt.createComponent(url);
        if (component.status == Component.Ready) {
            var button = component.createObject(root);
            button.visible = true
        }
//        button.destroy(1000);
//        Qt.createQmlObject(drop.text, root, 'CustomObject');
    }
}
