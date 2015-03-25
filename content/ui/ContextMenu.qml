import QtQuick 2.1
import QtQuick.Layouts 1.1

FocusScope {
    id: container
clip: true
    property bool open: false

    Item {
        anchors.fill: parent

        Rectangle {
            anchors.fill: parent
            color: "#D1DBBD"
            focus: true
            Keys.onRightPressed: mainView.focus = true

            RowLayout{
                anchors {
                    top: parent.top;
                    left:parent.left
                    right:parent.right

                    //horizontalCenter: parent.horizontalCenter;
                    margins: 10

                }
                Image {
                    id: userAvatar
                    Layout.maximumHeight: 38
                    Layout.maximumWidth: 38
                    Layout.alignment: Qt.AlignVCenter
                    fillMode: Image.PreserveAspectFit

                    source: settings.getValue("loggedIn") ? settings.getValue("username") : "qrc:/images/person_b.png"
                }
                Text {
                    color: "black"
                    font.pixelSize: 14
                    text: settings.getValue("loggedIn") ? settings.getValue("username") : qsTr("Guest")
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignVCenter
                    MouseArea{
                        anchors.fill: parent
                        onClicked: mainView.focus = true
                    }
                }
                ListView {
                    Layout.alignment: Qt.AlignVCenter
                    id:langListView
                    height: 38
                    boundsBehavior: Flickable.DragAndOvershootBounds
                    flickableDirection: Flickable.AutoFlickDirection
                    snapMode: ListView.NoSnap
                    orientation: ListView.Horizontal
                    highlightRangeMode: ListView.StrictlyEnforceRange
                    contentHeight: 38
                    contentWidth: 38
                    width: 38

                    spacing:5
                    delegate:Image {
                        id: langImg
                        height: 38
                        width: 38
                        smooth: true
                        //                anchors.verticalCenter: parent.verticalCenter
                        //                anchors.right:comboBox1.left
                        //                anchors.rightMargin:10
                        fillMode: Image.PreserveAspectFit

                        source: image
                    }

                    model:ListModel{
                        id:langModel
                        ListElement{
                            text:qsTr("Arabic")
                            image:"qrc:/images/flags/dz.ico"
                        }
                        ListElement{
                            text:qsTr("Spanish")
                            image:"qrc:/images/flags/es.ico"
                        }
                        ListElement{
                            text:qsTr("French")
                            image:"qrc:/images/flags/fr.ico"
                        }
                        ListElement{
                            text:qsTr("English")
                            image:"qrc:/images/flags/en.ico"
                        }
                        ListElement{
                            text:qsTr("Turkish")
                            image:"qrc:/images/flags/trky.ico"
                        }
                        ListElement{
                            text:qsTr("Chinese")
                            image:"qrc:/images/flags/ch.ico"
                        }
                    }



                }

            }

        }
    }
}
