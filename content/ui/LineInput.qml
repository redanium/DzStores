import QtQuick 2.0

FocusScope {
    id: wrapper

    property alias text: input.text
    property alias textColor: input.color

    property alias hint: hint.text
    property alias hintColor: hint.color
    property alias color: rect.color
  //  property alias prefix: prefix.text

    signal accepted

    Rectangle {id:rect
        anchors.fill: parent
        anchors.margins: 6
        border.color: "#707070"
        color: "#B2DCB2"//"#c1c1c1"
        radius: 4

        Text {
            id: hint
            anchors { fill: parent; leftMargin: 14 }
            verticalAlignment: Text.AlignVCenter
            text: "Enter word"
            font.pixelSize: 18
            color: "#707070"
            opacity: input.length ? 0 : 1
        }

//        Text {
//            id: prefix
//            anchors { left: parent.left; leftMargin: 14; verticalCenter: parent.verticalCenter }
//            verticalAlignment: Text.AlignVCenter
//            font.pixelSize: 18
//            color: "#707070"
//            opacity: !hint.opacity
//        }

        TextInput {
            id: input
            focus: true
            anchors { left: hint.left; right: parent.right; top: parent.top; bottom: parent.bottom }
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 18
            color: "#707070"
            onAccepted: wrapper.accepted()
        }

        Image {
            source: "qrc:/images/delete.png"
            anchors.right: parent.right
            anchors.rightMargin: 12
           height: 28
           width: 28
           visible: input.text.length >0 ? true :false
            anchors.verticalCenter: parent.verticalCenter
            MouseArea {
                anchors { fill: parent; margins: -10 }
                onClicked: input.text=""
            }
        }
    }
}
