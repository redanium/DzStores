import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1
import QtQuick.Window 2.0
import QtQuick.Particles 2.0
import QtGraphicalEffects 1.0



Item {
    objectName: "mainLogin"
    id: item1
    width: parent.width
    height: parent.height

    RowLayout{
        id: row1

        anchors.fill: parent


        StackView{
            clip: true
            Layout.alignment: Qt.AlignVCenter
            Layout.fillWidth: true
            height: 400
            id:stackviewpar
            objectName: "stackviewpar"
            delegate: StackViewDelegate {
                function transitionFinished(properties)
                {
                    properties.exitItem.opacity = 1
                }

                pushTransition: StackViewTransition {
                    PropertyAnimation {
                        target: enterItem
                        property: "opacity"
                        from: 0
                        to: 1
                    }
                    PropertyAnimation {
                        target: exitItem
                        property: "opacity"
                        from: 1
                        to: 0
                    }
                }
            }
            initialItem:
                Column{
                id: column2
                width: parent.width
                height: parent.height
                spacing: 20
                Image {
                    id: parXimg
                    source: "qrc:/images/close.png"
                    anchors.horizontalCenter: parent.horizontalCenter
                    sourceSize.height: 64
                    sourceSize.width: 64
                    height: 24
                    width: 24
                    visible: false
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {stackviewpro.pop();parXimg.visible=false;
                            imgPar.source="qrc:/images/person.png";}
                    }
                }

                Image {

                    id:parImg
                    width: 128
                    height: 128
                    anchors.horizontalCenter: parent.horizontalCenter
                    sourceSize.height: 64
                    sourceSize.width: 64
                    fillMode: Image.PreserveAspectFit

                    source: "qrc:/images/person.png"

                    MouseArea {
                        id: mouseArea2
                        anchors.fill: parent
                        onClicked: {mainView.focus=true;
if(stackviewpro.depth<2){
                                       stackviewpro.push({item:Qt.resolvedUrl("Account.qml"), properties:{accountType:true}});
                                       imgPar.source="qrc:/images/person_b.png";
                                       parXimg.visible=true;}
                        }
                    }
                }

                Label {
                    id: label2
                    text: qsTr("Particuliers")
                    font.bold: true
                    font.pointSize: 18
                    anchors.horizontalCenter: parent.horizontalCenter
                    horizontalAlignment: Text.AlignHCenter
                    ParticleSystem {
                        id: particleSystem
                    }

                    Emitter {
                        id: emitter
                        anchors.top:  parent.bottom
                        width: 160; height: 80
                        system: particleSystem
                        emitRate: 10
                        lifeSpan: 1000
                        lifeSpanVariation: 500
                        size: 16
                        endSize: 32

                    }

                    ImageParticle {
                        id:imgPar
                        source: "qrc:/images/person.png"
                        system: particleSystem
                    }

                }

            }
        }

        StackView{
            id:stackviewpro
            clip:true
            Layout.alignment: Qt.AlignVCenter
            Layout.fillWidth: true
            height: 400
            objectName: "stackviewpro"

            delegate: StackViewDelegate {
                function transitionFinished(properties)
                {
                    properties.exitItem.opacity = 1
                }

                pushTransition: StackViewTransition {
                    PropertyAnimation {
                        target: enterItem
                        property: "opacity"
                        from: 0
                        to: 1
                    }
                    PropertyAnimation {
                        target: exitItem
                        property: "opacity"
                        from: 1
                        to: 0
                    }
                }
            }
            initialItem:       Column {
                id: column1
                width: parent.width
                height: parent.height
                spacing: 20
                Image {
                    id: proXimg
                    source: "qrc:/images/close.png"
                    anchors.horizontalCenter: parent.horizontalCenter
                    sourceSize.height: 64
                    sourceSize.width: 64
                    height: 24
                    width: 24
                    visible: false
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {stackviewpar.pop();proXimg.visible=false;
                            imgPro.source="qrc:/images/pro_.png"
                        }
                    }
                }
                Image {
                    width: 128
                    id:proImg
                    height: 128
                    anchors.horizontalCenter: parent.horizontalCenter
                    fillMode: Image.PreserveAspectFit
                    sourceSize.height: 128
                    sourceSize.width: 128

                    source: "qrc:/images/pro_.png"

                    MouseArea {
                        id: mouseArea1
                        anchors.fill: parent
                        onClicked: if(stackviewpar.depth<2){
                                       stackviewpar.push({item:Qt.resolvedUrl("Account.qml"), properties:{accountType:false}});
                                       proXimg.visible=true;
                                       imgPro.source="qrc:/images/pro_b.png"
                                   }
                    }
                }

                Label {
                    id: label1
                    text: qsTr("Professionnels")
                    font.bold: true
                    font.pointSize: 18
                    anchors.horizontalCenter: parent.horizontalCenter
                    horizontalAlignment: Text.AlignHCenter
                    ParticleSystem {
                        id: particleSystem0
                    }

                    Emitter {

                        id: emitter0
                        anchors.top:  parent.bottom
                        width: 160; height: 80
                        anchors.horizontalCenter: parent.horizontalCenter
                        system: particleSystem0
                        emitRate: 10
                        lifeSpan: 1000
                        lifeSpanVariation: 500
                        size: 16
                        endSize: 32

                    }

                    ImageParticle {
                        id:imgPro
                        source: "qrc:/images/pro_.png"
                        system: particleSystem0
                    }

                }


            }

        }

    }


}
