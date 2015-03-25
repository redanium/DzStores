import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.0
import QtQuick.Controls.Styles 1.2



Item {
    property bool accountType
    property string buffer
    property bool keepMeLogedIn: settings.getValue("keepMeLogedIn")

    id: root
    width: parent.width
    height: parent.height

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
    Component {
        id:btnStyle
        ButtonStyle {
            background: Rectangle{
                color: "#008a00"
                radius: 4

            }

        }

    }
    StackView{
        id:loginStackView
        anchors.fill: parent
        anchors.margins:20
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


        initialItem: ColumnLayout{
            id: columnLayout1
            spacing: 10
            Image {
                id: image1
                width: 64
                height: 64
                Layout.alignment:   Qt.AlignHCenter
                fillMode: Image.PreserveAspectFit
                sourceSize.height: 64
                sourceSize.width: 64
                Layout.minimumHeight: 64
                Layout.minimumWidth: 64


            }



            Button {
                id: button3
                text: qsTr("Login")
                style: btnStyle
                Layout.alignment:   Qt.AlignHCenter
                onClicked:{
                    console.log("Btn login clicked!")



                    loginStackView.push(loginAccount);
                }
            }




            Button {
                id: button4
                style: btnStyle
                text: qsTr("Create an account")
                Layout.alignment:   Qt.AlignHCenter
                //  Layout.fillWidth:  true
                onClicked:{
                    loginStackView.push(newAccount);

                    console.log("Btn create_login clicked!");
                }
            }

        }

    }

    Component.onCompleted: if(parent.objectName==="stackviewpar")  image1.source="qrc:/images/pro_.png";
                           else image1.source="qrc:/images/person.png"

    Component {
        id: busyIndic
        BusyIndicator {running: true ; width: 10; height: 10;}
    }

    Component{
        id:newAccount
        ColumnLayout{


            Image {
                Layout.alignment:   Qt.AlignHCenter


                fillMode: Image.PreserveAspectFit
                sourceSize.height: 64
                sourceSize.width: 64
                height: 24
                width: 24
                Layout.maximumWidth:24
                Layout.maximumHeight:24
                id: closeImg2

                source: "qrc:/images/close.png"
                MouseArea{
                    anchors.fill: parent
                    onClicked: loginStackView.pop();
                }
            }
            RowLayout {
                id: row4

                visible: true
                Layout.alignment:   Qt.AlignHCenter
                Layout.fillWidth:  true
                Label {
                    id: label3
                    color:emailTextInput.acceptableInput ? "#000000":"red"
                    text: "Email"
                    font.pointSize: 10
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    Layout.minimumWidth: 100


                }

                TextField{
                    id: emailTextInput
                    //    width: emailTextInput.text.length*6
                    height: 20
                    validator: RegExpValidator { regExp:/\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/ }
                    text: ""
                    placeholderText: qsTr("Enter your email address .")
                    //    inputMask: ""
                    font.pointSize: 10
                    style:touchStyle
                    inputMethodHints: Qt.ImhEmailCharactersOnly
                    Layout.fillWidth: true
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
                spacing: 20
            }

            RowLayout {
                id: row2

                Layout.alignment:   Qt.AlignHCenter
                Layout.fillWidth:  true
                Label {
                    id: loginUsernamelabel
                    color: "#000000"
                    text: qsTr("ScreenName")
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pointSize: 10
                    Layout.minimumWidth: 100



                }

                TextField {
                    id:loginUsername
                    //     width: loginUsername.text.length*6
                    height: 20
                    text: ""
                    font.pointSize: 10
                    Layout.fillWidth: true
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    placeholderText: qsTr("Choose a username .")

                    style: touchStyle
                }
                spacing: 20

            }
            RowLayout {
                id: row1
                Layout.alignment:   Qt.AlignHCenter
                Layout.fillWidth:  true
                Label {
                    id: loginPasslabel
                    color: "#000000"
                    text: qsTr("password")
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pointSize: 10
                    Layout.minimumWidth: 100


                }

                TextField {
                    id: loginPass
                    //    width: loginPass.text.length*6
                    height: 20
                    text: ""
                    echoMode: TextInput.Password
                    placeholderText: qsTr("Choose a password >=8 .")
                    //   Component.onCompleted: loginPass.width=placeholderText.length*6
                    Layout.fillWidth: true
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pointSize: 10
                    style: touchStyle
                }
                spacing: 20
            }
            RowLayout {
                id: row66
                Layout.alignment:   Qt.AlignHCenter
                Layout.fillWidth:  true
                Label {
                    id: label55
                    color: "#000000"
                    text: qsTr("password")
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pointSize: 10
                    Layout.minimumWidth: 100


                }

                TextField {
                    id: confirm_password
                    height: 20
                    text: ""
                    echoMode: TextInput.Password
                    // Component.onCompleted: confirm_password.width=placeholderText.length*6
                    // width: confirm_password.text.length*6
                    font.pointSize: 10
                    placeholderText: qsTr("Re-enter your password .")
                    Layout.fillWidth: true
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter

                    style: touchStyle
                }
                spacing: 20
            }

            RowLayout {
                id: row7
                Layout.alignment:   Qt.AlignHCenter
                Layout.fillWidth:  true
                Button {
                    id: button2
                    enabled: emailTextInput.acceptableInput && emailTextInput.text.length>0 && loginUsername.text.length>0 && loginPass.text.length>0 && confirm_password.text.length>0
                    height: 50
                    Layout.fillWidth: true

                    text: qsTr("create account")
                    onClicked: {
                        loader.sourceComponent=busyIndic;

                        button2.enabled=false;
                        var http = new XMLHttpRequest();
                        var url = "http://192.168.2.100/newuser.php?username="+loginUsername.text+"&pass="+loginPass.text+"&email="+emailTextInput.text+"&type="+accountType+"&confirm_password="+confirm_password.text;
                        console.log(url);
                        http.open("POST", url);
                        http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                        http.onreadystatechange = function() {//Call a function when the state changes.
                            if(http.readyState ===XMLHttpRequest.DONE) {
                                if(http.responseText.search("Registration Succesfull")!==-1) {
                                    _Toast.show(http.responseText);

                                    loader.sourceComponent=null;
                                    root.parent.parent.parent.parent.push({item:Qt.resolvedUrl("Home.qml"), properties:{accountType:accountType}});
                                }
                                else {
                                    _Toast.show(http.responseText);

                                    button2.enabled=true;
                                    loader.sourceComponent=null;
                                    console.log(http.responseText);
                                }
                            }
                        }

                        http.send();

                    }
                }


            }
            Loader{
                id:loader
                Layout.minimumWidth: 50
                Layout.minimumHeight:  50
                Layout.maximumHeight: 50
                Layout.maximumWidth: 50
                Layout.alignment:   Qt.AlignHCenter

            }

        }
    }




    Component{
        id:loginAccount
        ColumnLayout {



            Image {
                id: parXimg
                source: "qrc:/images/close.png"
                anchors.horizontalCenter: parent.horizontalCenter
                sourceSize.height: 64
                sourceSize.width: 64
                height: 24
                width: 24
                Layout.maximumWidth:24
                Layout.maximumHeight:24
                fillMode: Image.PreserveAspectFit
                // visible: false
                MouseArea{
                    anchors.fill: parent
                    onClicked: loginStackView.pop();
                }
            }
            //spacing: 5
            RowLayout {
                id: row5
                Layout.alignment:   Qt.AlignHCenter
                Layout.fillWidth:  true
                spacing: 5
                Label {
                    id: usernameLabel
                    color: "#000000"
                    text: qsTr("Email")
                    //   Layout.fillWidth: true
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pointSize: 10
                    Layout.minimumWidth: 100
                }

                TextField {
                    id: emailLogin
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    validator: RegExpValidator { regExp:/\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/ }

                    Layout.fillWidth: true
                    height: 20
                    text: "redanium@gmail.com"
                    placeholderText: qsTr("Enter your username .")
                    //   Component.onCompleted: emailLogin.width=placeholderText.length*6

                    font.pointSize: 10
                    style: touchStyle

                }

            }
            RowLayout {
                id: row6
                Layout.alignment:   Qt.AlignHCenter
                Layout.fillWidth:  true
                Label
                {
                    id: passLoginLabel
                    color: "#000000"
                    text: qsTr("password")
                    font.pointSize: 10
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    Layout.minimumWidth: 100
                }

                TextField {
                    id: passLogin
                    height: 20
                    text: "reda00"
                    echoMode: TextInput.Password
                    Layout.fillWidth: true
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pointSize: 10
                    placeholderText: qsTr("Enter your password .")

                    style: touchStyle
                }
                spacing: 10
            }
            RowLayout {
                id: row3
                Layout.alignment:   Qt.AlignHCenter
                Layout.fillWidth:  true
                spacing: 10
                Label {
                    id: keepMe
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    text: qsTr("keep me loged in")
                    Layout.alignment:   Qt.AlignHCenter
                    Layout.fillWidth: true

                }
                Switch {
                    id: checkBox1
                    // width: 190
                    Layout.alignment:   Qt.AlignHCenter


                    onCheckedChanged:  settings.setValue("keepMeLogedIn",checkBox1.checked)
                }

            }

            Button {
                id: loginButton
                Layout.fillWidth: true
                height: 50
                text: qsTr("Log in")
                enabled:emailLogin.acceptableInput && passLogin.text.length>0
                onClicked: {
                    loginButton.enabled=false;
                    loader1.sourceComponent=busyIndic
                    ///.push(Qt.resolvedUrl("User.qml"))}
                    var http = new XMLHttpRequest();
                    var url = "http://192.168.2.100/login.php?email="+emailLogin.text+"&password="+passLogin.text;
                    http.open("POST", url);

                    //Send the proper header information along with the request
                    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                    //           http.setRequestHeader("Content-length", params.length);
                    //                        http.setRequestHeader("Connection", "close");
                    http.onreadystatechange = function() {//Call a function when the state changes.
                        if(http.readyState ===XMLHttpRequest.DONE) {
                            if(http.responseText.search("Login Successful")!==-1) {
                                settings.setValue("email",emailLogin.text);
                                settings.setValue("password",passLogin.text)
                                var lines = http.responseText.split('\n');
                                for(var i = 0;i < lines.length;i++){
                                    console.log(lines[i]);
                                }
                                settings.setValue("loggedIn",true)
                                _Toast.show(http.responseText.split(',')[1]);
                                settings.setValue("userID",http.responseText.split(',')[0])
                                root.parent.parent.parent.parent.pop();

                            }
                            else {


                                loader1.sourceComponent=null;
                                loginButton.enabled=true;
                                console.log(http.responseText);
                                _Toast.show(http.responseText);

                            }
                        }
                    }

                    http.send();













                }

            }

            Loader{
                id:loader1

                Layout.minimumWidth: 50
                Layout.minimumHeight:  50
                Layout.maximumHeight: 50
                Layout.maximumWidth: 50
                Layout.alignment:   Qt.AlignHCenter


            }
        }
    }






}
