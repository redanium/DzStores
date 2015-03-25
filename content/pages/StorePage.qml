import QtQuick 2.0
import QtQuick.Layouts 1.0
import QtQuick.Window 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtQuick.XmlListModel 2.0
import "../ui"

//SELECT `image` FROM `images` WHERE productID=1984
Item {
    id: root
    property bool accountTYpe
    property int storeID
    property bool editMode: false
    width: parent.width
    height: parent.height

    Loader{
        id:xmlLoader
        active:false
        sourceComponent:  XmlListModel{
            id:mymodel
            source: "http://192.168.2.100/store.php?storeID="+storeID
            query: "/dzstores/store"

            XmlRole { name: "logo"; query: "logo/string()" }
            XmlRole { name: "store_name"; query: "store_name/string()" }
            XmlRole { name: "opening_hours"; query: "opening_hours/string()" }
            XmlRole { name: "phone"; query: "phone/string()" }
            XmlRole { name: "coordinates"; query: "gps_coordinates/string()" }



            onStatusChanged: status===XmlListModel.Ready ? console.log("ready :"+count) : console.log("not ready")

        }

    }
    ColumnLayout {
        id: columnLayout1
        //   activeFocusOnTab: false
        // spacing: 0
        anchors.fill: parent

        Rectangle {
            id: titleView
            Layout.fillWidth: true
            height: 60
            Layout.maximumHeight: 60
            color: "#ffffff"
            RowLayout{
                anchors.fill: parent
                anchors.leftMargin: 10

                Image {
                    id: storeLogo
                    source: xmlLoader.item.status===XmlListModel.Ready?xmlLoader.item.get(0).logo:""
                    height: 50
                    width: 50
                    Layout.maximumHeight:50
                    Layout.maximumWidth: 50

                    fillMode: Image.PreserveAspectFit
                    Layout.alignment: Qt.AlignVCenter
                    //                anchors.leftMargin: 5
                    //                anchors.left: parent.right
                    //                anchors.top:parent.top
                    //                anchors.bottom: parent.bottom

                }
                Text {
                    id: title
                    text:xmlLoader.item.status===XmlListModel.Ready? xmlLoader.item.get(0).store_name:""
                    //                    anchors.leftMargin: 5
                    //                    anchors.left: storeLogo
                    //                    anchors.top:parent.top
                    //                    anchors.bottom: parent.bottom
                    font.bold: true
                    Layout.fillWidth: true
                    verticalAlignment: Text.AlignVCenter
                    Layout.alignment: Qt.AlignVCenter
                }
                MyRatingIndicator {
                    id: storeRating
                    width: 200
                    height: 50
                    //                    anchors.rightMargin: 5
                    //                    anchors.right: parent.right
                    //                    anchors.top:parent.top
                    //                    anchors.bottom: parent.bottom
                    rating: 4
                    enabled: false
                    anchors.top : title.bottom
                    anchors.left: title.left
                    //  anchors.topMargin: 2
                    starSize: 16
                }
            }
        }

        BorderImage {
            id: titleBorderImg
            Layout.fillWidth: true
            height: 10
            clip: false
            source: "qrc:/images/bluebar.png"
        }

        ListView {
            id: listView1
            orientation: ListView.Vertical
            spacing: 0
            contentWidth: columnLayout1.width
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip:true

            model:VisualItemModel {

                ImageGallery {
                    width:   listView1.width
                    height:410

                }

                Grid{
                    width:  listView1.width
                    height: 180
                    columnSpacing: 0
                    rowSpacing: 0
                    columns: 2
                    rows:3

                    Rectangle{
                        height: 60
                        width:  listView1.width/2
                        color: "#3399FF"
                        border.color: "#707070"

                        radius: 4
                        Row{
                            spacing: 0
                            anchors.fill: parent
                            Image {
                                id: likeImg
                                source: "qrc:/images/like_black.png"
                                fillMode:Image.PreserveAspectFit
                                width:  listView1.width/4
                                height: 60
                                MouseArea{
                                    anchors.fill:parent
                                }

                            }

                            Image {
                                id: shareImg
                                source: "qrc:/images/share.png"
                                fillMode:Image.PreserveAspectFit
                                width:  listView1.width/4
                                height: 60
                                MouseArea{
                                    anchors.fill:parent
                                }

                            }
                        }


                    }
                    Rectangle{
                        height: 60
                        width: listView1.width/2
                        color: "#3399FF"
                        border.color: "#707070"

                        radius: 4

                        MyRatingIndicator{
                            anchors.fill: parent
                            anchors.leftMargin: 5
                            starSize:30


                        }
                    }
                    FlipBar{
                        id:flipBar
                        property bool opened: false
                        signal ok
                        signal hasOpened
                        function open() {
                            flipBar.flipUp()
                            flipBar.opened = true
                           // lineInput.forceActiveFocus()
                            flipBar.hasOpened()
                        }

                        function close() {
                            if (opened) {
                                flipBar.flipDown()
                                flipBar.opened = false
                            }
                        }


                        height: 60
                        width:  listView1.width/2
                        front:    Rectangle{
                            height: 60
                            width:  listView1.width/2
                            color: "lightgrey"
                            border.color: "#707070"
                            MouseArea{
                                anchors.fill: parent
                                onClicked: if (!flipBar.opened)
                                              { flipBar.open();}
                            }

                            radius: 4


                                Image {
                                    id: openingHours
                                    anchors.fill: parent
                                    anchors.leftMargin: 10
                                    fillMode: Image.PreserveAspectFit
                                   // Layout.alignment: Qt.AlignHCenter
                                    source: "qrc:/images/clock.png"
                                }


                        }
                       back:    Rectangle{
                           height: 60
                           width:  listView1.width/2
                           color: "lightgrey"
                           border.color: "#707070"
                           MouseArea{
                               anchors.fill: parent
                               onClicked: if (flipBar.opened)
                                              flipBar.close();
                           }
                           radius: 4
                           RowLayout{
                               anchors.fill: parent
                               anchors.leftMargin: 10

                               Text {
                                   id: availableLabel
                                   text: xmlLoader.item.status===XmlListModel.Ready?xmlLoader.item.get(0).opening_hours:""
                                   Layout.fillHeight: true
                                   Layout.fillWidth: true
                                   horizontalAlignment: Text.AlignHCenter
                                   verticalAlignment:  Text.AlignVCenter
                               }
                           }
                       }

                    }
                 Rectangle{
                        height: 60
                        width: listView1.width/2
                        color: "lightgrey"
                        border.color: "#707070"

                        radius: 4
                        RowLayout{
                            anchors.fill: parent
                            anchors.leftMargin: 10
                            Image {
                                id: phhoneImg
                                Layout.maximumHeight:50
                                Layout.maximumWidth: 50

                                fillMode: Image.PreserveAspectFit
                                Layout.alignment: Qt.AlignVCenter
                                source: "qrc:/images/phone2.png"
                            }
                            Text {
                                id: ratingLabel
                                text: xmlLoader.item.status===XmlListModel.Ready?xmlLoader.item.get(0).phone:""
                                anchors.fill: parent
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }

                        }
                    }
                    Rectangle{
                        height: 60
                        width: listView1.width/2
                        color: "lightgrey"
                        border.color: "#707070"

                        radius: 4
                        Text {
                            id: deliveryleLabel
                            text: qsTr("Delivery")
                            anchors.fill: parent
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment:  Text.AlignVCenter
                        }
                    }
                    Rectangle{
                        height: 60
                        width:  listView1.width/2
                        color: "lightgrey"
                        border.color: "#707070"

                        radius: 4
                        Text {
                            id: productStateLabel
                            text: qsTr("Address")
                            anchors.fill: parent
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment:  Text.AlignVCenter
                        }
                    }



                }
                Rectangle {
                    width:  listView1.width
                    height: 80
                    color: "lightgrey"
                    border.color: "#707070"

                    radius: 4
                    Image {
                        id: youtubeImg
                        enabled: false
                        source: "qrc:/images/youtube.png"
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        anchors.top:parent.top
                        anchors.topMargin: 10
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 10
                        width: 60
                        fillMode: Image.PreserveAspectFit

                    }
                    Text {
                        id: descdetLabel
                        text: qsTr("Description / Details ")
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment:  Text.AlignVCenter
                    }

                }

                CategoryDelegate {
                    width:  listView1.width
                    //  height: 100
                    catName: "Store "+storeID+ " products"

                    //  orientation: Screen.orientation !== Qt.LandscapeOrientation ? ListView.Vertical:ListView.Horizontal

                }
            }
        }

    }
    Button {
        id: button1
        x: 764
        text: qsTr("save")
        anchors.top: parent.top
        anchors.topMargin: 14
        anchors.horizontalCenter: parent.horizontalCenter
        visible: !accountTYpe & editMode ? true : false
    }
    Component {
        id: touchStyle

        TextFieldStyle {
            textColor: "black"

            //font.pixelSize: 28
            background: Item {
                implicitHeight: 50
                implicitWidth: 200
                BorderImage {
                    source: "qrc:/images/textinput_green.png"
                    border.left: 8
                    border.right: 8
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right
                }
            }
        }
    }

    Component.onCompleted: {xmlLoader.active=true;console.log("storeID "+storeID)}
}

