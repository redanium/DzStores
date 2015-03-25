import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.2
import "../ui/"

Item{
    id :listResults
    ColumnLayout{
        spacing: 10
        anchors.fill:parent
        anchors.margins: 10
        Rectangle{
            Layout.fillWidth: true
            height: 70
            color: "lightgrey"
            radius:4
            border.color: "grey"
            RowLayout{
                anchors.fill: parent
                anchors.margins: 10
                //  spacing:parent.width-300
                Text {
                    id: name
                    text: qsTr("Search results for : ")+keyword
                    height: 40
                    Layout.fillWidth: true

                    Layout.alignment: Qt.AlignVCenter

                }

                ToolButton {
                    id: gridListBtn
                    Layout.alignment: Qt.AlignVCenter
                    Layout.maximumWidth:  40
                    Layout.maximumHeight: 35
                    // text: qsTr("Button")
                    Image {
                        id: listTogridimg
                        fillMode: Image.PreserveAspectFit
                        anchors.fill: parent
                        source: "qrc:/images/menu.png"
                    }
                    onClicked: {
                        if(gridlistLoader.sourceComponent==resultsGrid) gridlistLoader.sourceComponent=resultsList;
                        else gridlistLoader.sourceComponent=resultsGrid;


                    }
                }


                ToolButton {
                    id: mapBtn
                    Layout.alignment: Qt.AlignVCenter
                    Layout.maximumWidth:  40
                    Layout.maximumHeight: 35
                    // text: qsTr("Button")
                    Image {
                        id: listTomapimg
                        fillMode: Image.PreserveAspectFit
                        anchors.fill: parent
                        source: "qrc:/images/map.png"
                    }
                    onClicked: {
                        loaderList.sourceComponent=mapToListLoading;
                        loaderMap.source="qrc:/content/pages/SearchMapResultsPage.qml";
                        flipable.flipped = !flipable.flipped;
                        // loaderList.sourceComponent=undefined;

                    }
                }

            }
        }
        Loader{
            id:gridlistLoader
            Layout.fillWidth: true
            Layout.fillHeight:  true

            Component.onCompleted: sourceComponent=resultsGrid;

        }

    }
    Component{
        id:resultsList
        ScrollView {


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
                    text:  name
                    source: thumbnail ? thumbnail :logo
                    storeText: store_name
                    product_price: price
                    onClicked: {


                        root.parent.push({item:Qt.resolvedUrl("ProductDetailsPage.qml"), properties:{data:dataLoader.item.get(index)}});


                    }


                }
            }
        }
    }
    Component{
        id:resultsGrid
        ScrollView {


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
                            source:thumbnail ? thumbnail :logo
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
                                text: name
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
                                text: price+" DZA"
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
                    MouseArea{
                        anchors.fill: parent
                        onClicked:   root.parent.push({item:Qt.resolvedUrl("ProductDetailsPage.qml"), properties:{data:dataLoader.item.get(index)}});

                    }
                }

                onWidthChanged: cellWidth = width < height ? width/3 : width/4



            }
        }
    }


}

