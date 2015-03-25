import QtQuick 2.4
import QtQuick.Layouts 1.1

Item {
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
    anchors.verticalCenterOffset: -100
    anchors.horizontalCenterOffset: 0
    anchors.centerIn: marker
    width: 150
    height: 300



    Column {
        anchors.fill: parent
        anchors.margins: 5

        id: column1


        Image {
            id:img
            width: 120
            height: 123
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

}

