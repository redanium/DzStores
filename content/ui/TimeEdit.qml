//created by Redanium
import QtQuick 2.4
import QtQuick.Layouts 1.1

Item {
    id: root
    property alias color: rectangle1.color
    property string time : (listView1.currentIndex<10 ?"0"+parseInt(listView1.currentIndex):listView1.currentIndex )+ dotstext.text + (listView2.currentIndex<10 ?"0"+parseInt(listView2.currentIndex):listView2.currentIndex)

    Rectangle {
        id: rectangle1
        anchors.fill: parent
        anchors.margins: 5
        radius: 5
        border.color: "black"
        color: "black"



        RowLayout{
            id: row1
            anchors.fill: parent
            ListView {
                id: listView1 //hours
                snapMode: ListView.SnapToItem
                highlightRangeMode: ListView.StrictlyEnforceRange
                Layout.fillHeight: true
                Layout.fillWidth: true
                clip: true
                delegate:
                    Item {

                    width: ListView.view.width
                    height: ListView.view.height
                    Text {
                        anchors.centerIn: parent
                        text: if(modelData<10) return " 0 " + parseInt(modelData);
                              else return modelData;
                    }
                }
                model: 24
            }

            Text {
                id:dotstext

                Layout.fillHeight: true
                text: ":"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }


            ListView {
                id: listView2 //minutes
                snapMode: ListView.SnapToItem
                height: 160
                highlightRangeMode: ListView.StrictlyEnforceRange
                Layout.fillHeight: true
                Layout.fillWidth: true
                clip: true
                delegate:
                    Item {

                    width: ListView.view.width
                    height: ListView.view.height
                    Text {
                        anchors.centerIn: parent
                        text: if(modelData<10) return "0"+parseInt(modelData);else return modelData;
                    }

                }
                model: 60
            }

        }
    }

}
