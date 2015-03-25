import QtQuick 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtQuick.XmlListModel 2.0

Item {
    property int productID

    id: root

    ListView {
        MouseArea{
            anchors.fill: parent
            onDoubleClicked: {

                item1.parent.push({item:Qt.resolvedUrl("ProfilePage.qml"),properties:{imgModel:mymodel}});
            }
        }

        BusyIndicator{
            id:imageLoadingIndicator
            height: 100
            width: 100
            running:false
            anchors.centerIn: parent
        }

       anchors.fill: parent
        id: productImgList

        //    anchors.horizontalCenter: parent.horizontalCenter
        clip: true
        //                width: 300
        //                height: 300
        anchors.centerIn: parent
        spacing: 50
        boundsBehavior: Flickable.DragOverBounds
        contentHeight: root.height
        contentWidth: root.width
        keyNavigationWraps: true
        highlightRangeMode: ListView.StrictlyEnforceRange
        snapMode: ListView.SnapOneItem
        orientation: ListView.Horizontal
        model:mymodel
        cacheBuffer:1000

        delegate: Item{
            width: ListView.view.width
            height: ListView.view.height
            Image {
                id: productImg
                anchors.fill:parent
                source: imageS
                sourceSize.height:1000
               fillMode:(sourceSize.width/sourceSize.height<1.5)? Image.PreserveAspectFit :Image.Stretch
                sourceSize.width:1000
                //cache: false
                asynchronous: true
            }
        }
        Image {
            anchors.top: parent.top
            anchors.right: parent.right
            source: "qrc:/images/add.png"
            visible: !accountTYpe & editMode ? true : false
            sourceSize.height: 128
            fillMode: Image.PreserveAspectFit
            sourceSize.width: 128
            width: 22
            height: 22
        }
 //   Component.onCompleted: model=fallBackModel
    }

    Component.onCompleted: {
      //  if (mymodel.status==XmlListModel.Null) productImgList.model=fallBackModel;
        console.log(productID+" img gallery")
        request();
        imageLoadingIndicator.running=true;

    }
    function request() {
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
                print('HEADERS_RECEIVED')
            } else if(xhr.readyState === XMLHttpRequest.DONE) {
                print('DONE')
               // var lines = xhr.responseText.split('\n');
                console.log(xhr.responseText);
                mymodel.xml=xhr.responseText;//lines[0];
                imageLoadingIndicator.running=false;

                productImgList.model=mymodel;
            }
        }
        xhr.open("POST", "http://192.168.2.100/productImgs.php?productID="+productID);
        xhr.send();
    }


    ListModel{
        id:fallBackModel
      ListElement{
          image:"qrc:/images/product.png"
      }
    }

    XmlListModel {
        id:mymodel

        query: "/dzstores/imageS"

        XmlRole { name: "imageS"; query: "string()" }
    }

   }
