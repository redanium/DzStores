import QtQuick 2.0
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtQuick.XmlListModel 2.0
import QtQuick.Window 2.0
import "../ui/"


//SELECT `image` FROM `images` WHERE productID=1984
Item {
    property bool accountTYpe
    id: item1

    default property var data

    property bool editMode: false
    width: 600
    height: 1280

    Component.onCompleted: console.log(data.price)

    //Screen.onOrientationChanged: listView1.orientation= Screen.orientation === Qt.LandscapeOrientation ? ListView.Horizontal : ListView.Vertical
    ColumnLayout {
        id: columnLayout1
        //   activeFocusOnTab: false
        spacing: 0
        anchors.fill: parent

        Rectangle {
            id: titleView
            Layout.fillWidth: true
            height: 60
            color: "transparent"
            Text {
                id: title

                anchors.leftMargin: 5
                verticalAlignment: Text.AlignVCenter
                anchors.fill: parent
                font.bold: true
                text:item1.data.name
            }

            Text {
                id: priceTxt
                text: item1.data.price +" DZA"
                anchors.rightMargin: 5
                verticalAlignment: Text.AlignVCenter
                anchors.right: parent.right
                anchors.top:parent.top
                anchors.bottom: parent.bottom
                font.bold: true
                color: "red"
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
                    productID: {return parseInt(item1.data.productID);}

                }

                Grid{
                    width:  listView1.width
                    height: 280
                    columnSpacing: 0
                    rowSpacing: 0
                    columns: 2
                    rows: 4

                    Rectangle{
                        height: 60
                        width:  listView1.width/2
                        color: "#008a00"
                        border.color: "#707070"

                        radius: 4
                        Row{
                            spacing: 0
                            anchors.fill: parent
                            ToolButton{
                                width:  listView1.width/4
                                height: 60
                                Image {
                                    id: likeImg
                                    anchors.centerIn: parent
                                    source: "qrc:/images/like_black.png"
                                    fillMode:Image.PreserveAspectFit
                                    width:  listView1.width/4
                                    height: 50
                                    MouseArea{
                                        anchors.fill:parent
                                    }

                                }
                            }
                            ToolButton{
                                width:  listView1.width/4
                                height: 60
                                Image {
                                    id: shareImg
                                    source: "qrc:/images/share.png"
                                    fillMode:Image.PreserveAspectFit
                                    anchors.centerIn: parent
                                    width:  listView1.width/4
                                    height: 50
                                    MouseArea{
                                        anchors.fill:parent
                                    }

                                }
                            }



                        }

                    }
                    Rectangle{
                        height: 60
                        width: listView1.width/2
                        color: "#008a00"
                        border.color: "#707070"

                        radius: 4


                        MyRatingIndicator{
                            anchors.fill: parent
                            anchors.leftMargin: 5
                            rating: parseFloat(item1.data.rating===null? 0:item1.data.rating)
                            starSize: 30
                        }
                    }

                    Rectangle{
                        height: 60
                        width:  listView1.width/2
                        color: "lightgrey"
                        border.color: "#707070"

                        radius: 4
                        Text {
                            id: availableLabel
                            text: qsTr("Availability : ") + (item1.data.availability)
                            anchors.fill: parent
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment:  Text.AlignVCenter
                        }
                    }
                    Rectangle{
                        height: 60
                        width: listView1.width/2
                        color: "lightgrey"
                        border.color: "#707070"

                        radius: 4
                        Text {
                            id: ratingLabel
                            text: qsTr("Rating")
                            anchors.fill: parent
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
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
                            text: qsTr("Delivery : ") + item1.data.shipping
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
                            text: qsTr("Condition : ") +item1.data.condition
                            anchors.fill: parent
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment:  Text.AlignVCenter
                        }
                    }

                    Rectangle {
                        width: listView1.width/2
                        height: 100
                        color: "lightblue"
                        border.color: "#707070"

                        radius: 4
                        Image {
                            id: storeLogo
                            source: item1.data.logo
                            fillMode:Image.PreserveAspectFit
                            anchors.fill:parent
                        }


                    }
                    Rectangle {
                        width: listView1.width/2
                        height: 100
                        color:"lightblue"
                        border.color: "#707070"

                        radius: 4
                        Text {
                            id: storeLabel
                            text: item1.data.store_name
                            anchors.fill: parent
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment:  Text.AlignVCenter
                            font.bold: true
                            color: "black"
                            MouseArea{
                                anchors.fill: parent
                                onClicked:    item1.parent.push({item:Qt.resolvedUrl("StorePage.qml"), properties:{storeID:item1.data.storeID}});
                            }
                        }

                        Image {
                            id: gotoStore
                            source: "qrc:/images/navigation_next_item.png"
                            height: 50
                            width: 50
                            anchors.rightMargin: 5
                            anchors.right: parent.right
                            anchors.top:parent.top
                            anchors.bottom: parent.bottom
                            anchors.topMargin: 25
                            anchors.bottomMargin: 25

                        }
                    }

                }

                Rectangle {
                    id:wrapper
                    width:  listView1.width
                    height: 80
                    color: "lime"
                    border.color: "#707070"

                    radius: 4
                    Rectangle{
                        id:minDetails
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top

                        height: 80

                        Text {
                            id: descdetLabel
                            text: qsTr("Description / Details ")
                            anchors.fill: parent
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment:  Text.AlignVCenter
                            MouseArea {
                                anchors.fill: parent
                                onClicked:wrapper.state === "expanded" ?wrapper.state = "":wrapper.state = "expanded"
                            }
                        }
                        ToolButton{
                            anchors.left: parent.left
                            anchors.leftMargin: 10
                            anchors.top:parent.top
                            anchors.topMargin: 10
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 10
                            width: 60
                            text:""
                            Image {
                                id: youtubeImg
                                enabled: true
                                source: "qrc:/images/youtube.png"
                                anchors.fill: parent
                                fillMode: Image.PreserveAspectFit
                                MouseArea{
                                    anchors.fill: parent
                                    onClicked: {
                                        Qt.openUrlExternally(item1.data.youtube);
                                        console.log("yoytube");
                                    }
                                }

                            }
                        }


                    }
                    Item {
                        id: maxDetails

                        anchors.top: minDetails.bottom
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        opacity: 0

                        Rectangle {
                            anchors.fill: parent

                            color: "#cccccc"

                            TextArea {
                                id:detailstxt
                                anchors.fill: parent
                                anchors.margins: 5
                                textFormat: Text.RichText
                                clip: true
                                readOnly: true
                                font.pixelSize: 13

                                text: item1.data.details
                            }
                        }
                    }

                    states: [
                        State {
                            name: "expanded"

                            PropertyChanges { target: wrapper; height: /*detailstxt.contentHeight*/ ListView.view.width/2}
                            PropertyChanges { target: maxDetails; opacity: 1 }



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

                CategoryDelegate {
                    width:  listView1.width
                    //  height: 100
                    catName: "Store "+item1.data.storeID+ " products"
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
}

