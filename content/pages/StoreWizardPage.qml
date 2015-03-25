import QtQuick 2.4
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1
import QtQuick.Dialogs 1.2
import "../ui/"

Item {
    property variant stepsArray: ["Fill Store Details","Choose store's images","",""]
    width: 600
    height: 800
    ColumnLayout{
        spacing: 0
        anchors.fill: parent
        Rectangle{
            id:stepsRect
            height: 54
            color: "#7ec5fd"
            Layout.minimumWidth: 54
            Layout.fillWidth: true
            Text {
                id: stepTxt
                text: qsTr("Step ") + wizardStack.depth + " : "+stepsArray[wizardStack.depth]
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.fill: parent
            }
        }
        StackView{
            id:wizardStack
            Layout.fillHeight: true
            Layout.fillWidth: true
            initialItem: Item{
                height: parent.height
                width: parent.width
                ImageChooser{
                 anchors.fill: parent
                }

            }


        }

        Rectangle {
            id: stepsRect1
            height: 54
            color: "#7ec5fd"
            Layout.fillWidth: true
            Layout.minimumWidth: 54

            RowLayout {
                id: rowLayout1
                anchors.centerIn: parent
                spacing: 100

                Button {
                    id: toolButton1
                    Layout.minimumWidth:  63
                    enabled:wizardStack.depth!=0

                    text: "Previous"
                    Layout.fillWidth: false
                }

                Button {
                    id: toolButton2
                    Layout.minimumWidth:  63
                    text: "Next"
                    Layout.fillWidth: false
                }
            }
        }
    }

    Dialog{
        modality: Qt.WindowModal
        visible:false
        contentItem: Loader{

        }
    }

}

