import QtQuick 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.1



Rectangle {
    id: header
    width: 70
    color: "#D6F5D6"
    radius: 5
    height: 250
    //    property alias text: label.text
    property bool hasRefreshAction: false
    property ListView listView: null
    property bool busy: false
    property alias anchorPoint: refreshAction.left
    //    property alias textWidth: label.width
    signal refreshActionActivated()
    Component {
        id: pullToRefreshComponent
        Text {
            id: pullToRefresh

            height: header.width
            width: header.height

            text:  listView.contentX < -75 &&  listView.contentX > -125 ? qsTr("Refresh") : "Pull to refresh"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter


            rotation: 270
            opacity: listView.contentX < -75 ? 1 : 0;
            Behavior on opacity { NumberAnimation { duration: 100 } }

            font.pointSize: 12
            states: [
                State {
                    name: 'refresh'
                    when: listView.contentX < -150
                    PropertyChanges { target: timer; running: true }
                }
            ]
            Timer {
                id: timer
                running: false
                interval: 500
                repeat: false
                onTriggered:{ header.refreshActionActivated();

                    busy=true;
                }
            }
        }
    }
    Loader {
        sourceComponent: (hasRefreshAction && !busy && listView != null ? pullToRefreshComponent : null)
        anchors.fill: parent
    }
    //    Text{
    //        id: label
    //        color: "black"
    //        font.weight: Font.Bold
    //        font.pointSize: 10
    //        anchors.verticalCenter: parent.verticalCenter
    //        anchors.left: parent.left
    //        anchors.leftMargin: 16
    //       // font.family: "Nokia Pure Text Light"
    //        wrapMode: Text.WordWrap
    //        width: parent.width - refreshIcon.width - 10
    //    }
    Item {
        id: refreshAction
        anchors.fill: parent
        visible: hasRefreshAction || busy
        Image {
            id: refreshIcon
            anchors.fill: parent
            anchors.margins: 20

            source: "qrc:/images/refresh.png"
            visible: !busy && hasRefreshAction && listView.contentX>=-75
            fillMode: Image.PreserveAspectFit
            MouseArea {
                anchors.fill: parent
                enabled: !busy && hasRefreshAction
                onClicked: { header.refreshActionActivated()

                    busy=true
                }
            }
        }
        BusyIndicator {
            id: busyIndicator
           anchors.centerIn: parent
           height: 60
           width: 60
            visible: busy
            running: busy

        }
    }
}
