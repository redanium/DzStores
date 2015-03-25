import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.0
import QtQuick.Controls.Styles 1.2

Rectangle{

    color: "#bbbbbb"
    property ListModel model: imgModel
    property bool deleteBtns: false
    ColumnLayout {
        id: colLayout1
        anchors.topMargin: 10
        anchors.bottomMargin: 10
        anchors.leftMargin: 10
        anchors.rightMargin:10
        anchors.fill: parent
        spacing :5

        Rectangle{
            color: "#bbbbbb"
            height:  40
            Layout.fillWidth: true

            RowLayout {
                id: rowLayout
                anchors.fill: parent
                spacing:3

                ToolButton {
                    id: addImgUrl
                    Layout.alignment: Qt.AlignHCenter

                    enabled: imgModel.count<4
                    Image{
                        fillMode: Image.PreserveAspectFit
                        sourceSize.height: 128
                        sourceSize.width: 128
                        anchors.fill: parent
                        source: "qrc:/images/addFile.png"
                    }
                    Layout.maximumHeight: 30
                    Layout.maximumWidth: 30

                    onClicked: fileDialog.visible=true
                }

                ToolButton {
                    id: addImgFile
                    Layout.alignment: Qt.AlignHCenter

                    enabled: imgModel.count<4
                    Image{
                        fillMode: Image.PreserveAspectFit
                        sourceSize.height: 128
                        sourceSize.width: 128
                        anchors.fill: parent

                        source: "qrc:/images/addLink.png"
                    }
                    Layout.maximumHeight: 30
                    Layout.maximumWidth: 30
                    onClicked: urLInput.visible=true;

                }

                ToolButton {
                    id: addImgCam
                    Layout.alignment: Qt.AlignHCenter

                    //enabled: imgModel.count<4
                    Image{
                        fillMode: Image.PreserveAspectFit
                        sourceSize.height: 128
                        sourceSize.width: 128
                        anchors.fill: parent
                        source: "qrc:/images/camera.png"
                    }
                    Layout.maximumHeight: 30
                    Layout.maximumWidth: 30
                    onClicked:{
                        myLoader.sourceComponent===cam     ?myLoader.sourceComponent=null:myLoader.sourceComponent=cam;
                        // myLoader.item.height===0 ?myLoader.item.height=400 : myLoader.item.height=0;

                    }

                }
                ToolButton {
                    id: addImgGoogle
                    Layout.alignment: Qt.AlignHCenter

                    Image{
                        fillMode: Image.PreserveAspectFit
                        sourceSize.height: 128
                        sourceSize.width: 128
                        anchors.fill: parent
                        source: "qrc:/images/google.png"
                    }
                    Layout.maximumHeight: 30
                    Layout.maximumWidth: 30
                    onClicked:{
                        myLoader.sourceComponent===googleImages     ?myLoader.sourceComponent=null:myLoader.sourceComponent=googleImages;
                        // myLoader.item.height===0 ?myLoader.item.height=400 : myLoader.item.height=0;
                    }

                }

                ToolButton {
                    id: deleteAllBtn
                    Layout.alignment: Qt.AlignHCenter
                    Image{
                        fillMode: Image.PreserveAspectFit
                        sourceSize.height: 128
                        sourceSize.width: 128
                        anchors.fill: parent
                        source: "qrc:/images/close.png"
                    }
                    Layout.maximumHeight: 30
                    Layout.maximumWidth: 30
                    onClicked:{ deleteBtns=!deleteBtns}
                }
            }
        }

        Rectangle{
            Layout.fillWidth: true
            height: 2
            color: "darkgrey"
        }
        Rectangle{
            height: 250
            radius:6
            Layout.fillWidth: true
            ColumnLayout{
                anchors.centerIn:parent
                visible: imgModel.count===0

                Image {
                    id: dzStrLogo
                    source: "qrc:/images/photos_gallery.png"
                    fillMode: Image.PreserveAspectFit
                    height: 80
                    width: 80
                    Layout.alignment: Qt.AlignHCenter
                }
                Text {
                    id: imgGalleryTxt
                    text: qsTr("Add Images to product.")
                    Layout.alignment: Qt.AlignHCenter
                }
            }
            ListView {
                id: listView1
                anchors.fill: parent

                spacing: 10
                Rectangle{
                    id:urLInput
                    radius: 5

                    anchors.centerIn: parent
                    width: parent.width-5
                    height: 65
                    color: "#52c2ee"
                    visible: false
                    RowLayout{
                        anchors.fill: parent
                        anchors.margins: 10

                        TextField{
                            id:urlText
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            placeholderText: qsTr("Please paste your image ilnk here.")
                            onAccepted: {
                                urLInput.visible=false;
                                imgModel.append({"imageFile":text});
                                text="";
                            }

                        }
                        ToolButton{


                            Layout.maximumHeight: 35
                            Layout.maximumWidth: 35
                            Image{
                                anchors.fill:parent
                                source: "qrc:/images/cancel.png"
                            }
                            onClicked: {
                                if(urlText.text!=="")
                                {
                                    urLInput.visible=false                    ;
                                    imgModel.append({"imageFile":urlText.text});
                                    urlText.text="";
                                }
                                else urLInput.visible=false;


                            }
                        }
                    }

                }

                clip: true
                contentHeight: listView1.height

                orientation: ListView.Horizontal
                flickableDirection: Flickable.HorizontalFlick
                model: imgModel
                remove: Transition {
                    ParallelAnimation {
                        NumberAnimation { property: "opacity"; to: 0; duration: 1000 }
                        NumberAnimation { properties: "x,y"; to: 100; duration: 1000 }
                    }
                }
                delegate: Rectangle {

                    width: 200
                    height: ListView.view.height
                    color: index===0 ? "#689f38" : "transparent"
                    radius:index===0 ? 6 : 0
                    ColumnLayout{
                        anchors.fill: parent
                        anchors.bottomMargin: 10
                        spacing :5
                        Image {
                            id:img
                            Layout.fillHeight: true
                            Layout.fillWidth: true

                            anchors.margins: 3
                            source: imageFile
                            fillMode: Image.PreserveAspectFit
                            Component.onCompleted: console.log(Qt.resolvedUrl(imageFile))
                            MouseArea{
                                anchors.fill: parent
                                //   preventStealing: true
                                property int startX;
                                property int startY;
                                onPressed: {
                                    startX = mouse.x;
                                    startY = mouse.y;
                                }
                                onReleased: {
                                    var deltax = mouse.x - startX;
                                    var deltay = mouse.y - startY;

                                    if (Math.abs(deltax) > 40 || Math.abs(deltay) > 40) {
                                        if (deltax > 30 && Math.abs(deltay) < 30) {
                                            // swipe right
                                        } else if (deltax < -30 && Math.abs(deltay) < 30) {
                                            // swipe left

                                            console.log("swipeLeft");
                                        } else if (Math.abs(deltax) < 30 && deltay > 30) {
                                            // swipe down
                                            imgModel.remove(index)

                                        } else if (Math.abs(deltax) < 30 && deltay < 30) {
                                            // swipe up
                                            imgModel.remove(index)

                                        }
                                    }
                                }
                            }

                        }
                        ToolButton {
                            id: deleteBtn
                            visible: deleteBtns
                            Layout.alignment: Qt.AlignHCenter
                            Image{
                                fillMode: Image.PreserveAspectFit
                                sourceSize.height: 128
                                sourceSize.width: 128
                                anchors.fill: parent
                                source: "qrc:/images/close.png"
                            }
                            Layout.maximumHeight: 20
                            Layout.maximumWidth: 20
                            onClicked: imgModel.remove(index);
                        }
                    }
                }
                ListModel {
                    id:imgModel
                }
            }
        }
    }

}

