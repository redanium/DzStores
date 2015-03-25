import QtQuick 2.4
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.2
import "../ui"
import "../ui/camera"

Item{
    width: parent.width
    height: parent.height

    ScrollView {
        anchors.fill: parent

        ListView {
            id: listView2
            anchors.fill: parent
            spacing:0
            model: VisualItemModel{
                FormInputDelegate{
                    width: ListView.view.width
                    placeHolderText: "Enter the product/service <b><font size=\"3\" color=\"red\">name</font></b>."
                }
                FormInputDelegateBtn{
                    width: ListView.view.width
                    placeHolderText: "Enter the product/service <b><font size=\"3\" color=\"red\">reference</font></b>."
                }

                ImageChooser{
                    id:imgChooser
                    width: ListView.view.width
                    height: 350
                }
                Loader{
                    id:myLoader
                    width: ListView.view.width
                    height: sourceComponent===null ? 0 :400

                }
                WorkingHourse{
                width: ListView.view.width

                }

                ListView{
                    clip:true
                    model:ListModel{

                        ListElement{
                            hint:"Enter the product/service <b>name</b>."
                        }

                        ListElement{
                            hint:"Enter the product/service <b>reference</b>."
                        }

                        ListElement{
                            hint:"Enter the product/service <b>price</b>."
                        }

                    }
                    height: model.count*80
                    width: ListView.view.width
                    delegate: FormInputDelegate{
                        width: ListView.view.width

                        //fieldName:  model.name
                        placeHolderText: model.hint

                    }


                }

            }


        }



    }
    FileDialog {
        id: fileDialog
        title: "Please choose a file"
        nameFilters: [ "Image files (*.jpg *.png)", "All files (*)" ]
        onAccepted: {
            var str=fileDialog.fileUrl.toString();
            imgChooser.model.append({"imageFile":str /*str.slice(8, str.length)*/})
            console.log("You chose: " + fileDialog.fileUrls)


        }
        onRejected: {
            console.log("Canceled")

        }
    }
    Component{
        id:googleImages
        GoogleImagesDialog{
            id:goImgDlg
            height: 0
            onSelectedImageURLChanged: if(imgChooser.model.count<10) imgChooser.model.append({"imageFile":selectedImageURL})
        }
    }
    Component{
        id:cam
        CameraPage{
            id:cameraDlg
            height:0
            onPhotoTaken:  if(imgChooser.model.count<10) imgChooser.model.append({"imageFile":preview})

        }
    }

}
