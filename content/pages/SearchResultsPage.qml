import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2

import QtQuick.XmlListModel 2.0
import QtQuick.Layouts 1.1
import "../ui/"


Item {
    id:root
    property bool accountType:false
    property string keyword
    width: parent.width
    height: parent.height

    Flipable{
        id: flipable

        anchors.fill: parent
        property bool flipped: false

        front:
            Loader{
            id:loaderList
            anchors.fill: parent
        }


        back: Loader{
            id:loaderMap
            anchors.fill: parent
        }
        transform: Rotation {
            id: rotation
            origin.x: flipable.width/2
            origin.y: flipable.height/2
            axis.x: 0; axis.y: 1; axis.z: 0     // set axis.y to 1 to rotate around y-axis
            angle: 0    // the default angle
        }

        states: State {
            name: "back"
            PropertyChanges { target: rotation; angle: 180 }
            when: flipable.flipped
        }

        transitions: Transition {
            NumberAnimation { target: rotation; property: "angle"; duration: 2000 }
        }
    }
    Loader{
        id:dataLoader
        sourceComponent: XmlListModel {
            id: modelresults
            source: "http://192.168.2.100/search.php?keyword="+keyword
            query: "/dzstores/item"

            XmlRole { name: "productID"; query: "productID/string()" }
            XmlRole { name: "name"; query: "name/string()" }
            XmlRole { name: "price"; query: "price/string()" }
            XmlRole { name: "details"; query: "details/string()" }
            XmlRole { name: "storeID"; query: "storeID/string()" }
            XmlRole { name: "category"; query: "category/string()" }
            XmlRole { name: "visitors"; query: "visitors/string()" }
            XmlRole { name: "date_added"; query: "date_added/string()" }
            XmlRole { name: "youtube"; query: "youtube/string()" }
            XmlRole { name: "likes"; query: "likes/string()" }
            XmlRole { name: "rating"; query: "rating/string()" }
            XmlRole { name: "availability"; query: "availability/string()" }
            XmlRole { name: "condition"; query: "condition/string()" }
            XmlRole { name: "shipping"; query: "shipping/string()" }
            XmlRole { name: "thumbnail"; query: "thumbnail/string()" }

            XmlRole { name: "store_name"; query: "store_name/string()" }
            XmlRole { name: "logo"; query: "logo/string()" }
            XmlRole { name: "imageS"; query: "imageS/string()" }
            XmlRole { name: "gps_coordinates"; query: "gps_coordinates/string()" }





        }
        active: false
    }
  Component{
        id:mapToListLoading
        Item {
            anchors.centerIn: parent
            id: myiitem
            Column{
                anchors.centerIn: parent
                spacing: 30
                Image {
                    id: storeImg
                    source: "qrc:/images/dzstores_logo.png"
                    height: 128
                    width: 128
                    fillMode: Image.PreserveAspectFit
                    anchors.horizontalCenter: parent.horizontalCenter

                }
                BusyIndicator{
                    running: true
                    height: 64
                    width: 64
                    anchors.horizontalCenter: parent.horizontalCenter

                }
            }
        }
    }

    Component.onCompleted:{
        console.log(keyword);
        dataLoader.active=true;

        loaderList.source="qrc:/content/pages/SearchListGridResultsPage.qml";}
}

