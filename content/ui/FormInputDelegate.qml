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
        anchors.fill: parent
       // Layout.fillWidth: true


        LineInput {
            id: lineInput1
hintColor: "black"
textColor: "black"
            color: "lightsteelblue"
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
