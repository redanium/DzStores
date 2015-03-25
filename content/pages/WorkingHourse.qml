/****************************************************************************
**
** Copyright (C) 2013 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the Qt Quick Controls module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of Digia Plc and its Subsidiary(-ies) nor the names
**     of its contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/





import QtQuick 2.1
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1
import QtQuick.Layouts 1.1
import "../ui/"

Rectangle {
    id:root
    property bool accountType
    state: rectangle1.state

    //    width: parent.width
    //    height: parent.height
    height:50//rectangle1.state==="expanded" ?  400 : 50

    ColumnLayout{
        id: column1
        anchors.fill: parent

        RowLayout {
            id: row1
            Layout.fillWidth: true
           Layout.maximumHeight: 50
         //  Layout.alignment: rectangle1.state!=="expanded" ? Qt.AlignVCenter :0
           height: 50
           Text {
               id: openingHoursText
               text: qsTr("Add opening hours.")
               Layout.alignment: Qt.AlignVCenter

           }

            ToolButton {
                id: listToGridButton
                Layout.alignment: Qt.AlignVCenter
                Image {
                    id: listToGridImg
                    anchors.fill: parent
                    source: "qrc:/images/add.png"

                    fillMode: Image.PreserveAspectFit

                }
                onClicked: {
                    rectangle1.state==="expanded" ? rectangle1.state= "" :rectangle1.state="expanded";


                    openingListModel.append({
                                                "dayFrom" : "",
                                                "dayTo" :"",
                                                "timeFrom":"",
                                                "timeTo":""

                                            })
                }

            }

            ToolButton {
                id: toolButton2
                Layout.alignment: Qt.AlignVCenter

                onClicked: rectangle1.state==="expanded" ? rectangle1.state= "" :rectangle1.state="expanded"
            }
        }

        Rectangle {
            id: rectangle1
            Layout.fillWidth: true
         height: 300
         opacity:0
          Layout.maximumHeight:300
            color: "#76c7fb"

            ListView{
                highlightRangeMode: ListView.StrictlyEnforceRange
                anchors.fill: parent
                delegate: openingHoursDelegate

                clip:true
                model:ListModel{
                    id:openingListModel
                }
            }


            states: [
                State {
                    name: "expanded"
                    PropertyChanges { target: rectangle1; height: 300}

                    PropertyChanges { target: rectangle1; opacity: 1 }



                    //  PropertyChanges { target: closeButton; opacity: 1 }
                    //   PropertyChanges { target: wrapper.ListView.view; contentY: wrapper.y; interactive: false }
                }
            ]

            transitions: [
                Transition {
                    NumberAnimation {
                        duration: 200;
                        properties: "height,opacity"
                    }
                }
            ]


        }
    }
    Component{
        id:openingHoursDelegate
        Rectangle{
            width: ListView.view.width
            height: 100
            color: "grey"
            ToolButton {
                id: listToGridButton
                height: 25
                width: 25
                anchors.left: parent.left
                anchors.top: parent.top
                Image {
                    id: listToGridImg
                    anchors.fill: parent
                    source: "qrc:/images/close.png"

                    fillMode: Image.PreserveAspectFit

                }
                onClicked: {
                    openingListModel.remove(index)
                }

            }
            RowLayout {
                id: rowLayout3
                anchors.fill: parent
                anchors.margins: 10

                spacing: 70

                RowLayout {
                    id: rowLayout1
                    width: 100
                    height: 100
                    Layout.fillWidth: true

                    ComboBox {
                        id: comboBox3

                        height: 40
                        Layout.fillWidth: true

                        Layout.minimumWidth: 80

                        model: ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday","    "]
                        onCurrentTextChanged:{
                            openingListModel.get(index).dayFrom=currentText;
                            console.log("dayFrom"+openingListModel.get(index).dayFrom)
                        }
                    }

                    Rectangle {
                        id: rectangle2
                        width: 15
                        Layout.maximumWidth: 20
                        Layout.minimumWidth: 20
                        height: 5

                        color: "#ffffff"
                    }

                    ComboBox {
                        id: comboBox2
                        Layout.fillWidth: true
                        Layout.minimumWidth: 80
                        height: 40

                        model: ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]

                        onCurrentTextChanged:{
                            openingListModel.get(index).dayTo=currentText;
                            console.log("dayTo"+openingListModel.get(index).dayTo)
                        }
                    }


                }
                ColumnLayout{

                    RowLayout {
                        id: rowLayout2
                        width: 100
                        height: 100
                        Layout.fillWidth: true

                        TimeEdit {
                            Layout.maximumWidth: 100
                            Layout.minimumWidth: 100

                            height:40
                            color: "white"
                            onTimeChanged: {openingListModel.get(index).timeFrom=time;
                                console.log("timeFrom"+openingListModel.get(index).timeFrom)}

                        }

                        Rectangle {
                            id: rectangle3
                            Layout.maximumWidth: 20
                            Layout.minimumWidth: 20
                            height: 5
                            color: "#ffffff"
                        }

                        TimeEdit {
                            Layout.maximumWidth: 100
                            Layout.minimumWidth: 100

                            height: 40
                            color: "white"
                            onTimeChanged:      {
                                onTimeChanged: openingListModel.get(index).timeTo=time;

                                console.log("timeTo"+openingListModel.get(index).timeTo)
                            }



                        }


                    }

                    RowLayout {
                        id: rowLayout4
                        width: 100
                        height: 100
                        Layout.fillWidth: true

                        TimeEdit {
                            Layout.maximumWidth: 100
                            Layout.minimumWidth: 100

                            height:40
                            color: "white"
                            onTimeChanged: {openingListModel.get(index).timeFrom=time;
                                console.log("timeFrom"+openingListModel.get(index).timeFrom)}

                        }

                        Rectangle {
                            id: rectangle4
                            Layout.maximumWidth: 20
                            Layout.minimumWidth: 20
                            height: 5
                            color: "#ffffff"
                        }

                        TimeEdit {
                            Layout.maximumWidth: 100
                            Layout.minimumWidth: 100

                            height: 40
                            color: "white"
                            onTimeChanged:      {
                                onTimeChanged: openingListModel.get(index).timeTo=time;

                                console.log("timeTo"+openingListModel.get(index).timeTo)
                            }



                        }


                    }
                }
            }

            Rectangle{
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.left: parent.left
                height: 3

            }
        }

    }

    states: [
        State {
            name: "expanded"
            PropertyChanges { target: root; height: 350}




            //  PropertyChanges { target: closeButton; opacity: 1 }
            //   PropertyChanges { target: wrapper.ListView.view; contentY: wrapper.y; interactive: false }
        }
    ]

    transitions: [
        Transition {
            NumberAnimation {
                duration: 200;
                properties: "height"
            }
        }
    ]

}
