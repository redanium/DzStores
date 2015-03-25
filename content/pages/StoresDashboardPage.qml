import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.0
import QtQuick.Controls.Styles 1.1
import QtQuick.XmlListModel 2.0
import "../ui"


Item {
    id: root
    width: parent.width
    height: parent.height
    property int nbrStores: dataLoader.item.count
    property int userID : settings.getValue("userID")


    ColumnLayout {
        id: columnLayout1
        anchors.fill: parent
anchors.rightMargin: 16
anchors.leftMargin: 16
        RowLayout {
            id: rowLayout1
            Layout.fillWidth: true

            ToolButton {
                id: listToGridButton
                Layout.alignment: Qt.AlignVCenter
                Image {
                    id: listToGridImg
                    anchors.fill: parent
                    source: "qrc:/images/menu.png"

                    fillMode: Image.PreserveAspectFit

                }
                onClicked: {
                    if(listGridView.sourceComponent==resultsGrid) listGridView.sourceComponent=resultsList;
                    else listGridView.sourceComponent=resultsGrid;


                }
            }

            ToolButton {
                id: addStoreButton
                Layout.alignment: Qt.AlignVCenter
                Image {
                    id: addStoreImg
                    anchors.fill: parent
                    source: "qrc:/images/add.png"
                    fillMode: Image.PreserveAspectFit

                }
            onClicked: {
root.parent.push(Qt.resolvedUrl("qrc:/content/pages/newStorePage.qml"));
            appTitle="Nouveau Produit";
}
            }

            ToolButton {
                id: removeSoreButton
                Layout.alignment: Qt.AlignVCenter
                Image {
                    id: removeStoreImg
                    anchors.fill: parent
                    source: "qrc:/images/add.png"
                    rotation: 45
                    fillMode: Image.PreserveAspectFit

                }

            }


            Text {
                id: storeCount
                Layout.alignment: Qt.AlignVCenter

                text: " Stores : "+root.nbrStores
            }
        }
        Loader{
            id:listGridView
            asynchronous: false
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
    }

    Loader{
        id:dataLoader
        sourceComponent: XmlListModel {
            id: modelresults
            source: "http://192.168.2.100/myStores.php?userID="+userID
            query: "/dzstores/store"

            XmlRole { name: "storeID"; query: "storeID/string()" }
            XmlRole { name: "opening_hours"; query: "opening_hours/string()" }
            XmlRole { name: "details"; query: "details/string()" }
            XmlRole { name: "date_added"; query: "date_added/string()" }
            XmlRole { name: "social_networks"; query: "social_networks/string()" }
            XmlRole { name: "visitors"; query: "visitors/string()" }
            XmlRole { name: "rating"; query: "rating/string()" }
            XmlRole { name: "shipping"; query: "shipping/string()" }
            XmlRole { name: "store_name"; query: "store_name/string()" }
            XmlRole { name: "logo"; query: "logo/string()" }
            XmlRole { name: "gps_coordinates"; query: "gps_coordinates/string()" }
            XmlRole { name: "phone"; query: "phone/string()" }





        }
        active: false
    }

    Component{
        id:resultsList
        ScrollView {
anchors.fill: parent
            flickableItem.interactive: true


            style: ScrollViewStyle {
                transientScrollBars: true
                handle: Item {
                    implicitWidth: 14
                    implicitHeight: 26
                    Rectangle {
                        color: "#424246"
                        anchors.fill: parent
                        anchors.topMargin: 6
                        anchors.leftMargin: 4
                        anchors.rightMargin: 4
                        anchors.bottomMargin: 6
                    }
                }
                scrollBarBackground: Item {
                    implicitWidth: 14
                    implicitHeight: 26
                }
            }

            ListView {
                anchors.fill: parent
                spacing: 5
                model: dataLoader.item
                delegate: AndroidDelegate {
                    text:  store_name
                    source: logo ? logo :"qrc:/images/dzstores_logo.png"
                   // storeText: store_name
                  //  product_price: price
                    onClicked: {


                        root.parent.push({item:Qt.resolvedUrl("StorePageAdmin.qml")/*, properties:{data:dataLoader.item.get(index)}*/});


                    }


                }
            }
        }
    }
    Component{
        id:resultsGrid
        ScrollView {
            anchors.fill: parent

            flickableItem.interactive: true


            style: ScrollViewStyle {
                transientScrollBars: true
                handle: Item {
                    implicitWidth: 14
                    implicitHeight: 26
                    Rectangle {
                        color: "#424246"
                        anchors.fill: parent
                        anchors.topMargin: 6
                        anchors.leftMargin: 4
                        anchors.rightMargin: 4
                        anchors.bottomMargin: 6
                    }
                }
                scrollBarBackground: Item {
                    implicitWidth: 14
                    implicitHeight: 26
                }
            }

            GridView {
                anchors.fill: parent
                cellHeight: 250
                flow:  GridView.FlowLeftToRight
                model: dataLoader.item
                delegate:Rectangle{
                    id:productRect
                    color: "#fafafa"
                    border.color: "#707070"

                    radius: 4
                    width: GridView.view.cellWidth
                    height: 250

                    Column {
                        anchors.fill: parent
                        anchors.margins: 5

                        id: column1


                        Image {
                            id:img
                            width: productRect.width-30
                            height: 123
                            source:logo ? logo : "qrc:/images/dzstores_logo.png"
                            anchors.horizontalCenter: parent.horizontalCenter


                        }

                        GridLayout {
                            id: grid1
                            width: productRect.width-30
                            height: 117
                            rowSpacing: 0
                            columnSpacing: 0

                            rows: 3
                            columns: 2

                            Text {
                                text: store_name
                                wrapMode: Text.WrapAnywhere
                                Layout.fillWidth: true
                                Layout.columnSpan:  2
                                font.pixelSize:  17
                            }



                            Text {
                                text: store_name
                                wrapMode: Text.WrapAnywhere
                                font.pixelSize:  13
                                Layout.columnSpan:  2
                                Layout.fillWidth: true
                            }

                            MyRatingIndicator {
                                id: myRatingIndicator1
                                width: 80
                                height: 20
                                Layout.maximumWidth: 100
                                Layout.maximumHeight:  20
                                rating: parseInt(rating)
                                activeFocusOnTab: false
                                starSize: 10
                            }

                            Text {
                                Layout.fillWidth: true
                                height: 20
                                //text: price+" DZA"
                                horizontalAlignment: Text.AlignRight
                                font.pixelSize:  15
                                color: "red"
                            }
                        }


                        spacing: 5
                    }

                    MouseArea{
                        anchors.fill: parent
                        onClicked:   root.parent.push({item:Qt.resolvedUrl("StorePage.qml"), properties:{data:dataLoader.item.get(index)}});

                    }
                }

                onWidthChanged: cellWidth = width < height ? width/3 : width/4



            }
        }
    }
    Component.onCompleted:{
        //console.log(keyword);
        dataLoader.active=true;

        listGridView.sourceComponent=resultsList;}
}

