import QtQuick 2.0
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.0
import QtQuick.Controls 1.2
import "../core"

Rectangle{
    color:"transparent"
    clip:true


    property string selectedImageURL
    property int page: 0
    property int pages: jsModelmore.model.count
    width: 600
    height: 400

    JSONListModel{
        id:jsModel
        query: "$.responseData.results[']"
        //    source: "http://ajax.googleapis.com/ajax/services/search/images?v=1.0&q="+lineInput1.text
    }

    JSONListModel{
        id:jsModelmore
        query: "$.responseData.cursor.pages"
        source: jsModel.source
    }

    Rectangle {
        id: rectangle1
        color: "black"//"#bbbbbb"
        anchors.fill: parent
        Image {
            id: goImg
            source: "qrc:/images/poweredgoogle.png"
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.rightMargin: 2
            anchors.bottomMargin: 2
            fillMode: Image.PreserveAspectFit
            visible: jsModel.model.count>0
        }
        ColumnLayout {
            id: rowLayout1

            anchors.rightMargin: 0
            anchors.leftMargin: 0
            anchors.bottomMargin: 0
            anchors.topMargin: 0
            spacing: 6.3
            anchors.fill: parent
            Rectangle {
                id: rectangle2

                Layout.maximumHeight: 60
                height: 60
                color: "#ae5f23"
                Layout.fillWidth: true

                RowLayout {
                    id: columnLayout1
                    anchors.fill: parent

                    Layout.alignment: Qt.AlignVCenter

                    LineInput {
                        id: lineInput1
                        //Layout.minimumHeight: 50
                        //Layout.maximumHeight: 55
                        //                        height: 52
                        hint:qsTr("Search for images")
                        Layout.fillWidth: true
                        Layout.fillHeight: true

                        Layout.alignment: Qt.AlignVCenter

                        onAccepted:{ jsModel.source="http://ajax.googleapis.com/ajax/services/search/images?v=1.0&rsz=8&start="+page+"&q="+lineInput1.text;
                            page=0;
                        }
                        onTextChanged: if(text==="") {page=0;page=0;jsModel.source="";}
                    }


                    RowLayout {
                        id: rowLayout2
                        Layout.maximumHeight: 28
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignVCenter
                        ToolButton {
                            id: toolButton1
                            Layout.maximumWidth: 28
                            Layout.fillHeight: true
                            Layout.alignment: Qt.AlignVCenter



                            Image {
                                anchors.fill: parent
                                source: "qrc:/images/icon-search.png"
                                fillMode: Image.PreserveAspectFit
                            }
                            onClicked: jsModel.source="http://ajax.googleapis.com/ajax/services/search/images?v=1.0&rsz=8&start="+page+"&q="+lineInput1.text
                        }

                        ToolButton {
                            id: toolButton2
                            Layout.maximumWidth: 28
                            Layout.fillHeight: true
                            Layout.alignment: Qt.AlignVCenter

                            Image {
                                anchors.fill: parent
                                source: "qrc:/images/backward.png"
                                fillMode: Image.PreserveAspectFit
                            }
                            onClicked: if(page>=8){
                                           page-=8;
                                           jsModel.source="http://ajax.googleapis.com/ajax/services/search/images?v=1.0&rsz=8&start="+page+"&q="+lineInput1.text;
                                       }
                        }

                        ToolButton {
                            id: toolButton3
                            Layout.maximumWidth: 28
                            Layout.fillHeight: true
                            Layout.alignment: Qt.AlignVCenter

                            Image {
                                anchors.fill: parent
                                source: "qrc:/images/forward.png"
                                fillMode: Image.PreserveAspectFit
                            }
                            onClicked:
                                if(page/8+1<jsModelmore.model.count)  {
                                    page+=8;
                                    jsModel.source="http://ajax.googleapis.com/ajax/services/search/images?v=1.0&rsz=8&start="+page+"&q="+lineInput1.text;
                                }


                        }
                    }
                }
            }

            Image {
                id: dzStrLogo
                source: "qrc:/images/poweredgoogle.png"
                fillMode: Image.PreserveAspectFit
//                height: 80
//                width: 80
                visible: jsModel.model.count===0
                anchors.centerIn:myFlow
            }
               Flow {
                   id:myFlow

                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    spacing: 10
                    clip:true
                    Repeater{
                        id:myRep
                        model: jsModel.model
                        delegate: Image {
                            id:searchImg
                            BusyIndicator{
                                anchors.centerIn: parent
                                height: 40
                                width: 40
                                visible: searchImg.status===Image.Loading
                                running: searchImg.status===Image.Loading
                            }

                            height:myFlow.height/2-20
                            width: myFlow.width/4-20
                            fillMode: Image.PreserveAspectFit
                            source: model.tbUrl
                            onStatusChanged:if(searchImg.status===Image.Error) searchImg.source="qrc:/images/product.png"

                            MouseArea{
                                anchors.fill: parent
                                onClicked: selectedImageURL=parent.source
                            }            }


                    }

                }




        }

        Text {
            id: nbrpage
            text: (page/8+1) + "/" +pages
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.leftMargin: 2
            anchors.bottomMargin: 2
            visible: pages!==0
            color: "white"
        }
    }



    Behavior on height {
        NumberAnimation { duration: 800 }
    }


}

