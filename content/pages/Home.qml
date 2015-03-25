import QtQuick 2.0
import QtQuick.Window 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtQuick.XmlListModel 2.0
import QtGraphicalEffects 1.0
import QtWebView 1.0

import "../ui"

Rectangle {
    property bool keepMeLogedIn: settings.getValue("keepMeLogedIn")
    focus:true
    id: rectangle1
    property bool accountType:false
    property string categoryFilter: "All"


    width:parent.width
    height: parent.height
    color: "#eeeeee"





    Flickable{
        clip: true
        anchors.fill: parent
        anchors.rightMargin: 16
        anchors.leftMargin: 16
        contentHeight: 300*4
        contentWidth: parent.width
        ColumnLayout{
            anchors.fill: parent
            spacing: 50

            Loader{
                Layout.fillWidth: true
                height: 300
                Layout.minimumHeight: 300
//                sourceComponent: if(Qt.platform.os==="android" ) return webView;
//                source:if(Qt.platform.os!=="android" ) return "qrc:/content/ui/adWebKit.qml"
//
}
            CategoryDelegate{
                Layout.fillWidth: true
                catName: "Recently Added Products/Services"

            }
            CategoryDelegate{
                catName: "Top Products"
                Layout.fillWidth: true

            }
            CategoryDelegate{
                catName: "New Stores"
                Layout.fillWidth: true

            }

        }
    }










    Component {

        id: touchStyle

        TextFieldStyle {
            textColor: "black"
            placeholderTextColor: "dark grey"
            background: Item {
                implicitHeight: 50
                implicitWidth: 320
                BorderImage {
                    source: "qrc:/images/textinput_green.png"
                    border.left: 8
                    border.right: 8
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right
                }
            }
        }
    }
   Component{
       id:webView
       WebView{
height: 300
width: parent.width
           url: "http://192.168.2.100/banner.php"
       }
   }


}


