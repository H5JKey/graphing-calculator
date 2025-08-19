import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Shapes
import QtQuick.Dialogs

Window {
    width: 640
    height: 480
    visible: true
    title: "NeDesmos"
    ColorDialog {
        id: colorDialog
        onAccepted: {
            functionsModel.setColor(listView.selectedFunction, selectedColor)
        }
    }
    ListView {
        id: listView
        width: 200
        height: parent.height
        anchors.left: parent.left
        clip: true
        model: functionsModel
        property int selectedFunction
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
                            acceptedButtons: Qt.LeftButton | Qt.RightButton
                            onClicked: {
                                if (mouse.button === Qt.LeftButton) 
                                    functionsModel.setShow(index, !showGraphic)
                                else if (mouse.button === Qt.RightButton) {
                                    colorDialog.open()
                                    selectedFunction = index
                                    colorDialog.selectedColor = graphicColor
                                }
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
                Text {
                    font.pointSize: 12
                    font.bold: true
                    padding: 5
                    anchors.top: parent.top
                    anchors.right: parent.right
                    text: "x"
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            functionsModel.remove(index)
                        }
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