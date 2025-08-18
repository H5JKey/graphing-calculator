import QtQuick
import QtQuick.Window

Window {
    width: 640
    height: 480
    visible: true
    title: "NeDesmos"

    Component {
        id: functionDelegate
        Text {
            required property string string
            text: string
            font.pixelSize: 14
            width: ListView.view.width
            padding: 8
        }
    }

    ListView {
        id: listView
        width: 200
        height: parent.height
        anchors.left: parent.left
        clip: true
        model: functionsModel
        delegate: functionDelegate
        
        highlight: Rectangle {
            color: "lightsteelblue"
            radius: 2
        }
        
        focus: true
        
    }
}