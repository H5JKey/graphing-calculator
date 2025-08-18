import QtQuick
import QtQuick.Window
import QtQuick.Controls
import Function

Window {
    width: 640
    height: 480
    visible: true
    title: "NeDesmos"

    ListView {
        id: listView
        width: 200
        height: parent.height
        anchors.left: parent.left
        clip: true
        model: functionsModel
        delegate: Component{
            TextField {
                required property Function function
                text: function.string
                placeholderText: "Enter your expression..."
                font.pixelSize: 14
                width: ListView.view.width
                padding: 8
                onAccepted: functionsModel.append(Function("", ""))
            }
        }
        
        highlight: Rectangle {
            color: "lightsteelblue"
            radius: 2
        }
        
        focus: true
    }

    Rectangle {
        border.width: 2
        color: "transparent"
        anchors.fill: listView
    }

}