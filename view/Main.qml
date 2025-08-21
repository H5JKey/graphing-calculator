import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Shapes
import QtQuick.Dialogs
import QtGraphs

Window {
    width: 640
    height: 480
    visible: true
    title: "NeDesmos"
    ColorDialog {
        id: colorDialog
        property int selected
        onAccepted: {
            functionsModel.setColor(selected, selectedColor)
        }
    }
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
                    Layout.alignment: Qt.AlignLeft
                    Rectangle {
                        anchors.centerIn: parent
                        border.width: 1
                        height: 20
                        width: 20
                        color: (showGraphic) ? graphicColor : "transparent"
                        radius: 15
                        MouseArea {
                            anchors.fill: parent
                            acceptedButtons: Qt.LeftButton | Qt.RightButton
                            onClicked: {
                                if (mouse.button === Qt.LeftButton) 
                                    functionsModel.setShow(index, !showGraphic)
                                else if (mouse.button === Qt.RightButton) {
                                    colorDialog.open()
                                    colorDialog.selected = index
                                    colorDialog.selected = graphicColor
                                }
                            }
                        }
                    }
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
                    background: Rectangle {
                        color: transparent
                        anchors.fill: parent
                    }
                }
                Text {
                    Layout.alignment: Qt.AlignRight | Qt.AlignTop
                    font.pointSize: 12
                    font.bold: true
                    padding: 5
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
    GraphsView {
        id: graphsView
        anchors.left: listView.right
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.rightMargin: 0
        antialiasing: true
        zoomAreaEnabled: false
        axisX: ValueAxis {
            min: -10
            max: 10
            gridVisible: false
            subGridVisible: true
        }
        axisY: ValueAxis {
            min: -10
            max: 10
            gridVisible: false
            subGridVisible: true
        }
        Component.onCompleted: {
           updateGraphics();
        }  
    }
    Rectangle {
        border.width: 2
        color: "transparent"
        anchors.fill: listView
    }

    Column {
    anchors.right: parent.right
    anchors.top: parent.top
    anchors.margins: 5
    spacing: 2
    
    Button {
        font.bold: true
        width: 30
        height: 30
        text: "+"
        onClicked: {
            graphsView.axisX.min = graphsView.axisX.min * 0.9;
            graphsView.axisX.max = graphsView.axisX.max * 0.9;
            graphsView.axisY.min = graphsView.axisY.min * 0.9;
            graphsView.axisY.max = graphsView.axisY.max * 0.9;
            updateGraphics();
        }
    }
    
    Button {
        font.bold: true
        width: 30
        height: 30
        text: "-"
        onClicked: {
            graphsView.axisX.min = graphsView.axisX.min * 1.1;
            graphsView.axisX.max = graphsView.axisX.max * 1.1;
            graphsView.axisY.min = graphsView.axisY.min * 1.1;
            graphsView.axisY.max = graphsView.axisY.max * 1.1;
            updateGraphics();
        }
    }
    
    Button {
        width: 30
        height: 30
        text: ""
        onClicked: {
            graphsView.axisX.min = -10;
            graphsView.axisX.max = 10;
            graphsView.axisY.min = -10;
            graphsView.axisY.max = 10;
            updateGraphics();
        }
    }
}


    Connections {
        target: functionsModel
        onDataChanged: updateGraphics()
        onRowsRemoved: updateGraphics()
        onRowsInserted: updateGraphics()
    }
    function updateGraphics() {
        while (graphsView.seriesList.length > 0) {
            graphsView.removeSeries(graphsView.seriesList[0]);
        }
        const axisX = Qt.createQmlObject(`
                import QtQuick
                import QtGraphs
                LineSeries {
                    color: "black"
                    width: 1
                    XYPoint{x: graphsView.axisX.min; y: 0}
                    XYPoint{x: graphsView.axisX.max; y: 0}
                }
                `,
                graphsView
        );
        graphsView.addSeries(axisX);

        const axisY = Qt.createQmlObject(`
                import QtQuick
                import QtGraphs
                LineSeries {
                    color: "black"
                    width: 1
                    XYPoint{x: 0; y: graphsView.axisX.min}
                    XYPoint{x: 0; y: graphsView.axisX.max}
                }
                `,
                graphsView
        );
        graphsView.addSeries(axisY);

        


        for (var i = 0; i < functionsModel.rowCount(); i++) {
            var show = functionsModel.getShow(i);
            if (!show) continue;
            var functionColor = functionsModel.getColor(i);
            const graphic = Qt.createQmlObject(`
                import QtQuick
                import QtGraphs
                LineSeries {
                    color: "${functionColor}"
                    width: 2
                }
                `,
                graphsView
            );
            const points = functionsModel.calculatePoints(i,graphsView.axisX.min, graphsView.axisX.max);
            for (var j = 0; j<points.length; j++) {
                graphic.append(points[j].x, points[j].y);
            }
            graphsView.addSeries(graphic);
            
        }
    }
}









