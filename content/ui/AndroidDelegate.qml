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





import QtQuick 2.1

Item {
    id: root
    width: parent.width
    height: 110

    property alias text: textitem.text
    property alias source: imageItem.source
    property alias storeText: storeTxt.text
    property alias product_price: textitem1.text
    signal clicked

    Rectangle {
        anchors.fill: parent
        color: "#11ffffff"
        visible: mouse.pressed
    }
    Rectangle {
        anchors.fill: parent
        border.color: "#707070"

        radius: 4
//        anchors.left: parent.left
//        anchors.right: parent.right
//        anchors.margins: 15
//        height: 1
         color: "#fafafa"
    }

    Text {
        id: textitem
        color: "black"
        font.pixelSize: 32
        text: modelData
        anchors.top: parent.top
        anchors.topMargin: 22
        anchors.left: imageItem.right
        anchors.leftMargin: 20
    }
    Text {
        id: storeTxt
        color: "black"
        font.pixelSize: 16
        text: modelData
        anchors.left: imageItem.right
        anchors.leftMargin: 20
        anchors.top: textitem.bottom
        anchors.topMargin: 8
    }






    MouseArea {
        id: mouse
        anchors.fill: parent
        onClicked: {root.clicked()

        }

    }

    Image {
          id:imageItem
        width: 80
        height: 80
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.verticalCenter: parent.verticalCenter
        source:  "qrc:/images/store.png"
    }

    MyRatingIndicator {
        id: myRatingIndicator1
        width: 100
        height: 20
        anchors.left: imageItem.right
        anchors.leftMargin: 20
        anchors.top: storeTxt.bottom
        anchors.topMargin: 0
        starSize: 13
    }

    Text {
        id: textitem1
        x: 368
        y: 69
        color: "#b20000"
        text: modelData
        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignVCenter
        anchors.right: parent.right
        anchors.rightMargin: 5
        font.pixelSize: 32
    }

    Image {
        id: image1
        x: 537
        y: 29
        width: 32
        height: 32
        anchors.right: parent.right
        anchors.rightMargin: 5
        source: "qrc:/images/like_black.png"
    }
}
