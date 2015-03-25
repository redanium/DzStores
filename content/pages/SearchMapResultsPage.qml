import QtQuick 2.0
import QtLocation 5.3
import QtPositioning 5.2
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1
import "../ui/"

Item {
    id :mapResults
    Map {

        id: map
        anchors.fill: parent
        Plugin {
            id:nokiaPlugin
            name: "nokia"
            PluginParameter { name: "app_id";      value: "hgKzbTdG07uBcTxcd5Ex"
            }
            PluginParameter {
                name: "mapping.cache.disk.size"
                value: 52428800
            }
            PluginParameter { name: "token"; value: "-F2-YnPPmvjNyXdJOyQWdg" }
            PluginParameter { name: "proxy"; value: "system" }

        }
        center {
            latitude: 35.704593
            longitude: -0.616882
        }
        Row {
            id: row1
            width: 240
            height: 28
            spacing: 15
            anchors.right: parent.right
            anchors.rightMargin: 15
            anchors.top: parent.top
            anchors.topMargin: 15

            ToolButton{
                id: button1
                width: 24
                //  text: qsTr("Button")
                Image {
                    id: zoomoutimg
                    fillMode: Image.PreserveAspectFit
                    anchors.fill: parent
                    source: "qrc:/images/zoom_out.png"
                }
                onClicked:if(map.zoomLevel>map.minimumZoomLevel) map.zoomLevel--;
            }
            ToolButton {
                id: button0
                width: 50
                // text: qsTr("Button")
                Image {
                    id: mapToListImg
                    fillMode: Image.PreserveAspectFit
                    anchors.fill: parent
                    source: "qrc:/images/menu.png"
                }
                onClicked: {

                    //loaderList.sourceComponent=mapToListLoading;
                    flipable.flipped = !flipable.flipped;
                    loaderMap.sourceComponent=undefined;
                    loaderList.source="qrc:/content/pages/SearchListGridResultsPage.qml";
                }
            }
            ToolButton {
                id: button10
                width: 50
                // text: qsTr("Button")
                Image {
                    id: satMapImg
                    fillMode: Image.PreserveAspectFit
                    anchors.fill: parent
                    source: "qrc:/images/map.png"
                }
                onClicked: {

                    map.activeMapType= (map.activeMapType.name=== map.supportedMapTypes[0].name) ? map.supportedMapTypes[1]:map.supportedMapTypes[0];

                }
            }

            ToolButton {
                id: button2
                width: 24
                // text: qsTr("Button")
                Image {
                    id: zoomin
                    fillMode: Image.PreserveAspectFit
                    anchors.fill: parent
                    source: "qrc:/images/zoom_in.png"
                }
                onClicked:if(map.zoomLevel<map.maximumZoomLevel) map.zoomLevel++;

            }
        }
          zoomLevel: (map.maximumZoomLevel-map.minimumZoomLevel)/2
        plugin: nokiaPlugin
        gesture.enabled: true
        // gesture.pinchEnabled: true
        MapItemView {
            model: dataLoader.item
            delegate: productDelegate
            autoFitViewport: true
        }
        Component {
            id: productDelegate

            MapQuickItem {

                coordinate:  QtPositioning.coordinate(parseFloat(gps_coordinates.split(',')[0]),parseFloat(gps_coordinates.split(',')[1]))
                Component.onCompleted: console.log(parseFloat(gps_coordinates.split(',')[1]))
                sourceItem:
                    Image {
                    id: marker
                    width:370
                    height: 570
                    fillMode: Image.PreserveAspectFit
                    source: "qrc:/images/marker.png"
                    Rectangle{
                    id:mapRectItem
                    color:"transparent"
                    radius: 5
                    anchors.centerIn: marker
                     anchors.verticalCenterOffset: -100
                    width: 150
                    height: 340



                    Column {
                        anchors.fill: parent
                        anchors.margins: 5

                        id: column1


                        Image {
                            id:img
                            width: 120
                            height: 163
                            source:thumbnail
                            fillMode:  Image.PreserveAspectFit
                            anchors.horizontalCenter: parent.horizontalCenter
                            MouseArea{
                                anchors.fill: parent
                                onClicked:   root.parent.push({item:Qt.resolvedUrl("ProductDetailsPage.qml"), properties:{data:dataLoader.item.get(index)}});

                            }


                        }

                        GridLayout {
                            id: grid1
                            width: 140
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
                                font.pixelSize: 17
                                elide:Text.ElideRight
                                color: "white"
                            }



                            Text {
                                text: store_name
                                wrapMode: Text.WrapAnywhere
                                font.pixelSize:  14
                                elide:Text.ElideRight

                                Layout.columnSpan:  2
                                Layout.fillWidth: true
                                color: "white"

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
                                width: 60
                                height: 20
                                text: price
                                elide:Text.ElideRight

                                horizontalAlignment: Text.AlignLeft
                                font.pixelSize:  13
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

                }
                     //zoomLevel: map.zoomLevel
                anchorPoint.x: marker.width/2
                anchorPoint.y: marker.height

            }

        }
    }
}
