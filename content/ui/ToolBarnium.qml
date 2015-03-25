import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.1
import QtQuick.XmlListModel 2.0

FlipBar{
    id:flipBar
    width: parent.width
    height:60
    animDuration: 250
    property string label: ""
    property string placeHolder: "Search Products, Services and Stores."
    property alias searchText: lineInput.text
    property alias appTitle: appTitle.text
    property bool opened: false
    signal ok
    signal hasOpened

    function open() {
        flipBar.flipUp()
        flipBar.opened = true
        lineInput.forceActiveFocus()
        flipBar.hasOpened()
    }

    function close() {
        if (opened) {
            flipBar.flipDown()
            flipBar.opened = false
        }
    }


    front:
        Rectangle {
        id: toolbarFront

        anchors.fill: parent
        color:"#689f38"

        Rectangle {
            id: backButton

            width: opacity ? 38 : 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            opacity: stackView.depth > 1 ? 1 : 0
            anchors.verticalCenter: parent.verticalCenter
            antialiasing: true
            height: 50
            radius: 4
            color: backmouse.pressed ? "#222" : "transparent"

            Behavior on opacity { NumberAnimation{} }

            Image {
                anchors.verticalCenter: parent.verticalCenter
                source: "qrc:/images/navigation_previous_item.png"
            }

            MouseArea {
                id: backmouse
                anchors.fill: parent
                anchors.margins: -10
                onClicked: stackView.pop()
            }
        }

        Image {
            id: appLogo

            x: backButton.x + backButton.width +5
            width: 42
            height: 42
            smooth: true
            fillMode: Image.PreserveAspectFit
            source: "qrc:/images/dzstores_logo.png"
            Behavior on x { NumberAnimation{ easing.type: Easing.OutCubic} }
            anchors.verticalCenter: parent.verticalCenter

            MouseArea{
                anchors.fill: parent
                onClicked: contextMenu.open=!contextMenu.open;
            }

        }

        Text {
            id:appTitle

            font.pixelSize: 25
            Behavior on x { NumberAnimation{ easing.type: Easing.OutCubic} }
            x: appLogo.x + appLogo.width + 20
            anchors.verticalCenter: parent.verticalCenter
            color: "white"
            text: "DzStores"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            //  Keys.onReturnPressed: stackView
        }


        ToolButton {
            id: searchButton

            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            height: 50
            width: 50
            // enabled: searchField.text.length>0 ? true:false

            Image {
                id: searchImg

                fillMode: Image.PreserveAspectFit
                source: "qrc:/images/search.png"
                anchors.centerIn: parent
                height: 38
                width: 38
                sourceSize.height: 128
                sourceSize.width: 128
            }
            onClicked:{

                if (!flipBar.opened)
                    flipBar.open()
                else if (!lineInput.activeFocus)
                    lineInput.forceActiveFocus()
                else
                    flipBar.close()
                toolbarBack.state="expanded"
            }

        }


    }
    back:
        Rectangle   {

        anchors.fill: parent
        color: "#689f38"

        RowLayout{
            id:searchRow

            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.rightMargin: 2
            anchors.leftMargin: 4
            height: 50
            spacing:1

            ToolButton{
                id: backButton3

                Layout.alignment: Qt.AlignVCenter
                Layout.maximumWidth:  30
                Layout.maximumHeight:  50
                onClicked:{
                    if (flipBar.opened)
                        flipBar.close()

                    lineInput.focus=false
                    mainView.forceActiveFocus()
                    toolbarBack.state=""

                }

                Image {
                    anchors.centerIn:  parent
                    source: "qrc:/images/cancel.png"
                    height: 28
                    width: 28
                    sourceSize.height: 128
                    sourceSize.width: 128
                    fillMode: Image.PreserveAspectFit
                }

            }

            LineInput{
                id: lineInput

                hint: flipBar.placeHolder
                focus: flipBar.opened
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true
                onAccepted: {
                    if (Qt.inputMethod.visible)
                        Qt.inputMethod.hide()
                    flipBar.ok()
                    mainView.focus=true

                }

            }
            ToolButton{
                id: backButton2

                Layout.alignment: Qt.AlignVCenter
                Layout.maximumWidth:  30
                Layout.maximumHeight:  50
                onClicked:{
                    if (Qt.inputMethod.visible)
                        Qt.inputMethod.hide()
                    flipBar.ok()
                    mainView.focus=true

                }

                Image {
                    anchors.centerIn:  parent
                    source: "qrc:/images/icon-search.png"
                    height: 28
                    width: 28
                    sourceSize.height: 128
                    sourceSize.width: 128
                    fillMode: Image.PreserveAspectFit
                }

            }

        }

        Rectangle{
            id: toolbarBack

            color: "transparent"
            anchors.top: searchRow.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.topMargin:  20
            anchors.rightMargin: 5
            anchors.leftMargin: 5
            anchors.bottomMargin:  5
            opacity: 0

            Rectangle {

                anchors.fill: parent
                radius: 5
                border.color: "lightgrey"
                color: "#8fb379"

                Row{
                    anchors.fill: parent
                    anchors.margins: 20
                    spacing: 20

                    ListView {
                        id: listView2

                        width: parent.width/2-10
                        height: parent.height
                        clip:true;
                        flickableDirection: Flickable.VerticalFlick
                        boundsBehavior: Flickable.DragOverBounds
                        contentHeight: 250
                        snapMode: GridView.SnapToRow
                        contentWidth: 250
                        section.property: "category_name"
                        section.criteria: ViewSection.FullString
                        section.labelPositioning :ViewSection.CurrentLabelAtStart
                        section.delegate:
                            Component {
                            id: sectionHeading

                            Rectangle {
                                width: ListView.view.width
                                height: 60
                                radius: 5
                                color:
                                    switch(section){
                                    case "VEHICULES" : return "yellow";
                                    case "MAISON" : return "lightsteelblue";
                                    case "IMMOBILIER" : return "red";
                                    case "MULTIMEDIA" : return "orange";
                                    case "LOISIRS" : return "blue";
                                    case "MATERIEL PROFESSIONNEL" : return "lime";
                                    case "Autres" : return "lightgrey";
                                    default: return "purple";
                                    }

                                Text {
                                    anchors.fill: parent
                                    text: section
                                    font.family: "Rockwell"
                                    font.bold: true
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    font.pixelSize: 15
                                    wrapMode: Text.WrapAnywhere
                                }
                            }
                        }

                        model: XmlListModel{
                            id: xmlModel

                            source: "qrc:/content/cat.xml"
                            query: "/categories/sub_category"

                            XmlRole { name: "sub_category"; query: "string()" }
                            XmlRole { name: "category_name"; query: "@category_name/string()" }
                        }

                        delegate: Item {
                            id: root
                            width: ListView.view.width
                            height: 60

                            MouseArea{

                                anchors.fill: parent
                                onClicked:  {
                                    if(Qt.colorEqual("white",rect.color) )
                                        rect.color="#57d9e4" ;
                                    else rect.color= "white";
                                }
                            }

                            Rectangle {
                                id:rect

                                radius: 5
                                border.color: "#b5c2ae"
                                anchors.fill: parent
                                anchors.margins: 5

                                Text {
                                    id: textitem
                                    color: "black"
                                    font.pointSize: 10
                                    anchors.leftMargin: 5

                                    text: sub_category
                                    anchors.fill: parent
                                    wrapMode: Text.WrapAnywhere
                                }


                            }




                        }

                    }

                    Rectangle {
                        width: listView2.width
                        height: 60
                        radius: 5
                        color:"yellow"


                        Text {

                            anchors.fill: parent
                            anchors.margins: 10
                            text: "Filters"
                            font.family: "Rockwell"
                            font.bold: true
                            verticalAlignment: Text.AlignVCenter
                            font.pixelSize: 19

                        }
                        Image {
                            id: addFilterImg

                            source: "qrc:/images/add.png"
                            height: 32
                            width: 32
                            opacity: filterMouse.pressed ? 0.5 : 1
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: parent.right
                            anchors.rightMargin: 5
                            MouseArea{
                                id:filterMouse
                                anchors.fill: parent

                            }
                        }
                    }

                }

            }
            states: [
                State {
                    name: "expanded"
                    PropertyChanges { target: shade; opacity: 0.85 }
                    PropertyChanges { target: flipBar; height: 350}
                    PropertyChanges { target: toolbarBack; opacity: 1 }
                }
            ]

            transitions: [
                Transition {
                    NumberAnimation {
                        duration: 200;
                        properties: "height,opacity"
                    }
                }
            ]

        }

    }
    onOk: {
        stackView.push({item:Qt.resolvedUrl("qrc:/content/pages/SearchResultsPage.qml"), properties:{keyword:flipBar.searchText}});
        flipBar.close();
        toolbarBack.state=""

    }
}
