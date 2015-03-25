import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import "../ui/camera"
import QZXing 1.3


Item {
    width: parent.width
    height: parent.height
    QZXing
    {
        id: decoder




        onDecodingStarted: console.log("Decoding of image started...")

        onTagFound: console.log("Barcode data: " + tag)

        onDecodingFinished: console.log("Decoding finished " + (succeeded==true ? "successfully" :    "unsuccessfully") )
    }
    TabView {
        anchors.fill: parent
        style: tabStyle
        Tab {
            title: "Store"
            CameraPage{

                onPhotoTaken: decoder.decodeImage(pic);

            }

        }
        Tab {
            title: "Products"
            ProductsPage {}
        }

    }

    Component {
        id: tabStyle
        TabViewStyle {
            tabsAlignment: Qt.AlignVCenter
            tabOverlap: 0
            frame: Item { }
            tab: Item {
                implicitWidth: control.width/control.count
                implicitHeight: 50
                BorderImage {
                    anchors.fill: parent
                    border.bottom: 8
                    border.top: 8
                    source: styleData.selected ? "qrc:/images/tab_selected.png":"qrc:/images/tabs_standard.png"
                    Text {
                        anchors.centerIn: parent
                        color: "white"
                        text: styleData.title.toUpperCase()
                        font.pixelSize: 16
                    }
                    Rectangle {
                        visible: index > 0
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.margins: 10
                        width:1
                        color: "#689f38"
                    }
                }
            }
        }
    }
}

