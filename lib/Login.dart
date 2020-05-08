import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:management/Dashboard.dart';
import 'package:management/UI/forgotpassword.dart';
import 'package:management/network/model/user.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'network/api_service.dart';


class Login extends StatefulWidget{


  @override
  State<StatefulWidget> createState() {
    return LoginState();
    throw UnimplementedError();
  }
}

class LoginState extends State<Login>{
  ProgressDialog pr;
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordFieldController = new TextEditingController();
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final emailField = TextField(
      controller: emailController,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "User ID",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final passwordField = TextField(
      controller: passwordFieldController,
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "Password",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    void showLongToast(String message) {
      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.red,
          textColor: Colors.white);
    }

    void loginRes(String res){
      pr.hide().then((isHidden) {
        print(isHidden);
      });
      String s=res;
      print("RESPONSE"+s);
      if(res.contains("1")){

       // Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard()));
        Route route = MaterialPageRoute(builder: (context) => Dashboard());
        Navigator.pushReplacement(context, route);
      }else{
        showLongToast("Invalid Credentials");
      }
    }

    FutureBuilder _loginRes(BuildContext context) {
      print("RESPONSE");

    }


    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xffff6E40),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async{
          print("onTap Dashboard.");

          Route route = MaterialPageRoute(builder: (context) => Dashboard());
          Navigator.pushReplacement(context, route);


          var username=emailController.text.trim();
          var password=passwordFieldController.text.trim();
          print(username.length);
          print(password);
          if(username.isEmpty){
            showLongToast("Enter User Id");
          }else if(password.isEmpty){
            showLongToast("Enter Password");
          }else{
            pr = new ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);

            pr.style(
                message: 'Logging in..',
                borderRadius: 10.0,
                backgroundColor: Colors.white,
                progressWidget: CircularProgressIndicator(),
                elevation: 10.0,
                insetAnimCurve: Curves.easeInOut,
                progress: 0.0,
                maxProgress: 100.0,
                messageTextStyle: TextStyle(
                    color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.w600)
            );
            pr.show();
            final api = Provider.of<ApiService>(context, listen: false);
            api.getloginTask(username,password,0).then((it) {
           // Map<String, dynamic> user = jsonDecode(it);
            var userMap = json.decode(it);
            Userlist userList = Userlist.fromJson(userMap);
              var i= userList.userdata[0].Status;
              loginRes(it.toString());
            }).catchError((onError){
              print(onError.toString());
              pr.hide();
            });
          }

          /*it.forEach((f) {
            print(f.title);
          });*/

        },
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );





    return Scaffold(
      backgroundColor: Color(0xFFD6D6D6),
      body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(0, 50.0, 0, 0),


      child: Stack(
        children: <Widget>[
          Center(
            child: Container(

              //color: Colors.black12,
              child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 165.0,
                          child: Image.asset(
                            "assets/erlogo.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(height: 40.0),
                        emailField,
                        SizedBox(height: 15.0),
                        passwordField,
                        SizedBox(
                          height: 25.0,
                        ),
                        loginButon,
                        SizedBox(
                          height: 25.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            print("onTap called.");
                            Navigator.push(context, MaterialPageRoute(builder: (context) => forgotpassword()));

                          },
                          child: Text("Forgot Password?",style: new TextStyle(fontSize:18.0,color: Colors.black, decoration: TextDecoration.underline)),
                        ),


                        ]
                  )
              ),


            )
          ),
        ],



      ))

    );
    throw UnimplementedError();
  }
}
