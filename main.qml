//import QtQuick 6.4
//import QtQuick.Controls 6.4

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Window{
    id: window
    width: 1280
    height: 900
    color: "#ffffff"
    visible: true
    title: "HelloApp"
    property int margin: 11
    Component.onCompleted: {
        width = mainLayout.implicitWidth + 2 * margin
        height = mainLayout.implicitHeight + 2 * margin
    }
    minimumWidth: mainLayout.Layout.minimumWidth + 2 * margin
    minimumHeight: mainLayout.Layout.minimumHeight + 2 * margin

    signal test_pass_sig(string s)

//    Connections()
    Connections {
        target: speaker

        function onText_print_sig(send_str) {
            console.log(send_str)
        }
    }


    ColumnLayout {
        id: mainLayout

        anchors.fill: parent
        anchors.margins: window.margin

        GroupBox {
            id: groupBox0
            title: "Group Box"
            Layout.fillWidth: true
            Layout.minimumWidth: rowLayout.Layout.minimumWidth + 30

            RowLayout {
                id: rowLayout
                anchors.fill: parent
                TextField {
                    placeholderText: "This wants to grow horizontally"
                    Layout.fillWidth: true
                }
                Button {
                    text: "Button"
                }
            }
        }

        GroupBox {
            id: gridBox
            title: "Grid layout"
            Layout.fillWidth: true
            Layout.minimumWidth: gridLayout.Layout.minimumWidth + 30

            GridLayout {
                id: gridLayout
                rows: 3
                flow: GridLayout.TopToBottom
                anchors.fill: parent

                Label { text: "Line 1" }
                Label { text: "Line 2" }
                Label { text: "Line 3" }

                TextField { }
                TextField { }
                TextField { }

                TextArea {
                    text: "This widget spans over three rows in the GridLayout.\n"
                          + "All items in the GridLayout are implicitly positioned from top to bottom."
                    wrapMode: TextArea.WordWrap
                    Layout.rowSpan: 3
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.minimumHeight: implicitHeight
                    Layout.minimumWidth: 100     // guesstimate, should be size of largest word
                }
            }
        }
        TextArea {
            id: t3
            text: "This fills the whole cell"
            Layout.minimumHeight: 30
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
        GroupBox {
            id: stackBox
            title: "Stack layout"
            implicitWidth: 200
            implicitHeight: 60
            Layout.minimumHeight: 60
            Layout.fillWidth: true
            Layout.fillHeight: true
            StackLayout {
                id: stackLayout
                anchors.fill: parent

                function advance() { currentIndex = (currentIndex + 1) % count }

                Repeater {
                    id: stackRepeater
                    model: 5
                    Rectangle {
                        required property int index
                        color: Qt.hsla((0.5 + index) / stackRepeater.count, 0.3, 0.7, 1)
                        Button {
                            anchors.centerIn: parent
                            text: "Page " + (parent.index + 1)
                            onClicked: {
                                console.log("onClicked")
                                stackLayout.advance()
                                speaker.say("test")
                                test_pass_sig("test signal")
                            }
                        }
                    }
                }
            }
        }
    }
}

