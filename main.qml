/****************************************************************************
**
** Copyright (C) 2013 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the Qt Quick Controls module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of Digia Plc and its Subsidiary(-ies) nor the names
**     of its contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtQuick.Window 2.2
import QtQuick.Layouts 1.1
import QtQuick.XmlListModel 2.0
import "content/ui"
import "content/pages"



ApplicationWindow {
    property bool keepMeLogedIn: settings.getValue("keepMeLogedIn")
    property bool accountType: false
    property alias appTitle: toolbarnium.appTitle
    property variant titleArray: ["DzStores","My stores","BookMarks / WishList","INBOX","Profile"]
    visible: true
    width: 800
    height: 1280
    //visibility: Window.FullScreen
    title: "DzStores"

    Rectangle {
        color: "#eeeeee"
        clip: true
        anchors.fill: parent
    }

    toolBar:ToolBarnium{
        id:toolbarnium
    }
    FocusScope{
        id: mainView
        anchors.fill: parent

        focus: true
        Keys.onReleased: {
            if (event.key === Qt.Key_Back) {
                if (stackView.depth > 1) {
                    stackView.pop();
                    event.accepted = true;
                } else { Qt.quit(); }
            }
        }

        StackView {
            id: stackView
            clip: true
            activeFocusOnTab: true
            objectName: "mainStackView"
            anchors.fill: parent
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
            initialItem:{ return Qt.createComponent(Qt.resolvedUrl("qrc:/content/pages/Home.qml"));}
        }

        Rectangle {
            id: shade
            anchors.fill: parent
            color: "black"
            opacity: 0
        }
    }


    ContextMenu {
        id: contextMenu;
        x: -265;
        width: 260;
        height: parent.height

        ColumnLayout {
            spacing: 10
            anchors.fill: parent
            anchors.topMargin: 70


            ListView {
                Layout.fillWidth: true
                Layout.fillHeight: true
                spacing: 3
                model: [qsTr("Home"), qsTr("My Stores"), qsTr("Bookmarks"), qsTr("Inbox"), qsTr("Profile"), qsTr("SignIn")]

                delegate: Rectangle {

                    width: parent.width-50
                    height: 30
                    color:menuMouse.pressed ? "white" :"lightBlue"
                    radius: 3
                    anchors.horizontalCenter: parent.horizontalCenter

                    MouseArea{
                        id:menuMouse
                        anchors.fill: parent
                        onClicked: {
                            switch(modelData){

                            case "My Stores" : stackView.push(Qt.createComponent(Qt.resolvedUrl("qrc:/content/pages/StoresDashboardPage.qml")));break;
                            case "Bookmarks" : stackView.push(Qt.createComponent(Qt.resolvedUrl("qrc:/content/pages/BookmarkPage.qml")));break;
                            case "Inbox"     : stackView.push(Qt.createComponent(Qt.resolvedUrl("qrc:/content/pages/InboxPage.qml")));break;
                            case "Profile"   : stackView.push(Qt.createComponent(Qt.resolvedUrl("qrc:/content/pages/ProfilePage.qml")));break;
                            case "SignIn"    : stackView.push(Qt.createComponent(Qt.resolvedUrl("qrc:/content/pages/MainForm.qml")));break;
                            case "Home"      : while(stackView.depth>1) stackView.pop();break;



                            }
                            contextMenu.open=false;
                        }
                    }
                    Text {
                        anchors.centerIn: parent
                        text: modelData

                    }
                }
            }





        }


        states: State {
            name: "contextMenuOpen"
            when: contextMenu.open
            PropertyChanges { target: contextMenu; x: 0;  }
            PropertyChanges { target: shade; opacity: 0.25 }
        }

        transitions: Transition {
            NumberAnimation { properties: "x,opacity"; duration: 600; easing.type: Easing.OutQuint }
        }
    }
    Toast{
        id:_Toast
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 50

    }

}
