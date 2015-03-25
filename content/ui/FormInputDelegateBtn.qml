import QtQuick 2.0
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.0


Rectangle {
    id: rectangle2
    width: 500
    height: 51
    color: "#bbbbbb"
    property alias placeHolderText: lineInput1.hint
    property alias text: lineInput1.text

    RowLayout {
        id: rowLayout1
        anchors.leftMargin: 3
       // anchors.rightMargin: 3
        anchors.fill: parent
        ToolButton{
            id:codeScanner
            Layout.maximumHeight: 30
            Layout.maximumWidth: 30
            Layout.minimumHeight: 30
            Layout.minimumWidth: 30
            Layout.alignment: Qt.AlignVCenter
            Image {

                id: codeImg
                source: "qrc:/images/qr_code.png"
                anchors.fill: parent
                fillMode: Image.PreserveAspectFit
            }

        }



        LineInput {
            id: lineInput1
            hintColor: "white"
            textColor: "black"
            color: "#689f38"
            Layout.fillHeight: true
            Layout.fillWidth: true
        }

    }

        Rectangle {
            id: rectangle1
            height: 2
            color: "#689f38"
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
        }

}
