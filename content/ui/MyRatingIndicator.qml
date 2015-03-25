import QtQuick 2.2
import QtQuick.Layouts 1.1
Item {
    id: itemRatingIndicator
    property int rating:0
    property int starSize




    RowLayout{
        anchors.fill: parent



        Image {
            id: imageStar1
            source: "qrc:/images/star.png"
            fillMode: Image.PreserveAspectFit
            Layout.alignment: Qt.AlignVCenter
            opacity: 0.4
            Layout.maximumHeight: starSize
                Layout.maximumWidth:starSize
                Layout.minimumWidth: starSize
                Layout.minimumHeight: starSize

            MouseArea {
                anchors.fill: parent
                height: parent.height+20
                width: parent.width+20

                onClicked: {
                    if(itemRatingIndicator.rating===1) itemRatingIndicator.rating = 0;
                    else  itemRatingIndicator.rating = 1;
                }
            }
            states: [
                State {
                    name: "star"
                    when: itemRatingIndicator.rating >= 1
                    PropertyChanges {
                        target: imageStar1
                        opacity: 1


                    }
                }
            ]
            transitions: [
                Transition {

                    NumberAnimation { properties: "opacity,scale"; easing.type: Easing.OutBounce; duration: 1000 }
                }
            ]
        }

        Image {
            id: imageStar2
            source: "qrc:/images/star.png"
            fillMode: Image.PreserveAspectFit
            Layout.maximumHeight: starSize
                Layout.maximumWidth:starSize
                Layout.minimumWidth: starSize
                Layout.minimumHeight: starSize
            Layout.alignment: Qt.AlignVCenter
            opacity: 0.4

            MouseArea {
                anchors.fill: parent
                height: parent.height+20
                width: parent.width+20

                onClicked: {
                    itemRatingIndicator.rating = 2
                }
            }
            states: [
                State {
                    name: "star"
                    when: itemRatingIndicator.rating >= 2
                    PropertyChanges {
                        target: imageStar2
                        opacity: 1


                    }
                }
            ]
            transitions: [
                Transition {

                    NumberAnimation { properties: "opacity,scale"; easing.type: Easing.OutBounce; duration: 1000 }
                }
            ]
        }

        Image {
            id: imageStar3
            source: "qrc:/images/star.png"
            fillMode: Image.PreserveAspectFit
            Layout.alignment: Qt.AlignVCenter
            opacity: 0.4
            Layout.maximumHeight: starSize
                Layout.maximumWidth:starSize
                Layout.minimumWidth: starSize
                Layout.minimumHeight: starSize
            MouseArea {
                anchors.fill: parent
                height: parent.height+20
                width: parent.width+20

                onClicked: {
                    itemRatingIndicator.rating = 3
                }
            }
            states: [
                State {
                    name: "star"
                    when: itemRatingIndicator.rating >= 3
                    PropertyChanges {
                        target: imageStar3
                        opacity: 1


                    }
                }
            ]
            transitions: [
                Transition {

                    NumberAnimation { properties: "opacity,scale"; easing.type: Easing.OutBounce; duration: 1000 }
                }
            ]
        }
        Image {
            id: imageStar4
            source: "qrc:/images/star.png"
            fillMode: Image.PreserveAspectFit
            Layout.alignment: Qt.AlignVCenter
            opacity: 0.4
            Layout.maximumHeight: starSize
                Layout.maximumWidth:starSize
                Layout.minimumWidth: starSize
                Layout.minimumHeight: starSize
            MouseArea {
                anchors.fill: parent
                height: parent.height+20
                width: parent.width+20

                onClicked: {
                    itemRatingIndicator.rating = 4
                }
            }
            states: [
                State {
                    name: "star"
                    when: itemRatingIndicator.rating >= 4
                    PropertyChanges {
                        target: imageStar4
                        opacity: 1


                    }
                }
            ]
            transitions: [
                Transition {

                    NumberAnimation { properties: "opacity,scale"; easing.type: Easing.OutBounce; duration: 1000 }
                }
            ]
        }
        Image {
            id: imageStar5
            source: "qrc:/images/star.png"
            // fillMode: Image.PreserveAspectFit
            fillMode: Image.PreserveAspectFit
            Layout.alignment: Qt.AlignVCenter
            opacity: 0.4
            Layout.maximumHeight: starSize
                Layout.maximumWidth:starSize
                Layout.minimumWidth: starSize
                Layout.minimumHeight: starSize

            MouseArea {
                anchors.fill: parent
                height: parent.height+20
                width: parent.width+20

                onClicked: {
                    itemRatingIndicator.rating = 5
                }
            }
            states: [
                State {
                    name: "star"
                    when: itemRatingIndicator.rating >= 5
                    PropertyChanges {
                        target: imageStar5
                        opacity: 1


                    }
                }
            ]
            transitions: [
                Transition {

                    NumberAnimation { properties: "opacity,scale"; easing.type: Easing.OutBounce; duration: 1000 }
                }
            ]
        }


    }




}
