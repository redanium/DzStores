import QtQuick 2.4
import QtQuick.Layouts 1.0
import QtQuick.Controls 1.2
import QtGraphicalEffects 1.0
Item {
    id:root
    property string catName
    focus:true
    property int myWidth: width
    width: parent.width
    height: 300

    ColumnLayout {

        id: columnLayout1
        anchors.fill: parent
        spacing: 20

        Text {
            id: categoryName
            Layout.fillWidth: true
            color: "black"
            text: catName
            // horizontalAlignment: Text.AlignHCenter//#008a00"
            font.bold: true



        }


        ListView {
            id: listView1

            Layout.fillWidth: true

            Layout.fillHeight: true
            snapMode: ListView.SnapToItem
            clip:true
            spacing: 10
            orientation: ListView.Horizontal
            model: ListModel {
                ListElement {
                    name: "Grey"
                    colorCode: "qrc:/images/xbox1.jpg"
                    store:""
                    storeid:1984
                    category:"Multimedia"
                }

                ListElement {
                    name: "Red"
                    colorCode: "qrc:/images/pel.jpg"
                }

                ListElement {
                    name: "Blue"
                    colorCode: "qrc:/images/xbox.jpg"
                }

                ListElement {
                    name: "Green"
                    colorCode: "qrc:/images/hp.jpg"
                }
                ListElement {
                    name: "Green"
                    colorCode: "qrc:/images/nikon.jpg"
                }
                ListElement {
                    name: "Green"
                    colorCode: "qrc:/images/m8.jpg"
                }
            }
            delegate:   Rectangle{
                color: "#fafafa"
                border.color: "#707070"

                radius: 4
                width: 200
                height: 250

                Column {
                    anchors.fill: parent
                    anchors.margins: 5

                    id: column1


                    Image {
                        id:img
                        width: 120
                        height: 123
                        source:colorCode
                        fillMode:  Image.PreserveAspectFit
                        anchors.horizontalCenter: parent.horizontalCenter


                    }

                    GridLayout {
                        id: grid1
                        width: parent.width-10
                        height: 117
                        rowSpacing: 0
                        columnSpacing: 0

                        rows: 3
                        columns: 2

                        Text {
                            text: "#ProductName#"
                            wrapMode: Text.WrapAnywhere
                            Layout.fillWidth: true
                            Layout.columnSpan:  2
                            elide:Text.ElideRight

                            font.pixelSize:  17
                        }



                        Text {
                            text: "#StoreName#"
                            wrapMode: Text.WrapAnywhere
                            font.pixelSize:  13
                            Layout.columnSpan:  2
                            elide:Text.ElideRight

                            Layout.fillWidth: true
                        }

                        MyRatingIndicator {
                            id: myRatingIndicator1
                            width: 80
                            height: 20
                            Layout.maximumWidth: 100
                            Layout.maximumHeight:  20
                            rating: 3
                            activeFocusOnTab: false
                            starSize: 12
                        }

                        Text {
                            width: 60
                            height: 20
                            text: "20200 DZA"
                            elide:Text.ElideRight

                            horizontalAlignment: Text.AlignRight
                            font.pixelSize:  15
                            color: "red"
                        }
                    }


                    spacing: 5
                }
                Image {
                    id: image1

                    height: 20
                    width: 20
                    anchors.top: parent.top
                    anchors.right: parent.right
                    anchors.rightMargin: 5
                    anchors.topMargin: 5
                    fillMode: Image.PreserveAspectFit
                    source: "qrc:/images/like_black.png"
                }

            }
            HeaderRefresh{
                id: header
                x: -listView1.contentX- header.width
                listView: listView1
                hasRefreshAction: true
                busy: false
                onRefreshActionActivated: console.log("updating")
            }


           // Component.onCompleted: contentX=0;
            //onContentXChanged: if(contentX<0)contentX=0;
        }


    }






    Component {
        id: headerComponent
        Rectangle {
            id: rectangle1
            width: 75
            height: 250

            color: "#D6F5D6"

            Text {
                id: text1
                x: -12
                y: 118
                width: 100
                text: qsTr("Reload")
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                transformOrigin: Item.Center
                anchors.left: parent.bottom
                anchors.leftMargin: 45
                anchors.right: parent.top

                rotation: 270
                font.pixelSize: 12
            }

            BusyIndicator{
                x: 10
                y: 118
                width: 15
                height: 15

            }
        }
    }
}

