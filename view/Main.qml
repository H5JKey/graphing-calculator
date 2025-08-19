import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Shapes

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
        delegate: Rectangle{
            border.width: 0.5
            width: ListView.view.width
            height: 40
            color: "transparent"
            required property string functionString
            required property string graphicColor
            required property bool showGraphic
            required property int index
            RowLayout {
                anchors.fill: parent
                spacing: 5
                Rectangle {
                    Rectangle {
                        border.width: 1
                        height: 20
                        width: 20
                        color: (showGraphic) ? graphicColor : "transparent"
                        anchors.centerIn: parent
                        radius: 15
                        MouseArea {
                            anchors.fill: parent
                            onClicked: { 
                                functionsModel.setShow(index, !showGraphic)
                            }
                        }
                    }
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    width: 30
                    border.width: 0.5
                }
                TextField {
                    Layout.fillWidth: true
                    text: functionString
                    placeholderText: "f(x) = "
                    font.pixelSize: 14

                    padding: 8
                    onTextChanged: functionsModel.setString(index, text)
                    onAccepted: {
                        functionsModel.insert(index+1);
                    }
                }
            }
        }
        
        focus: true
    }

    Rectangle {
        border.width: 2
        color: "transparent"
        anchors.fill: listView
    }

}