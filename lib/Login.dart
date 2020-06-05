
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:management/Dashboard.dart';
import 'package:management/UI/forgotpassword.dart';
import 'package:management/network/model/company.dart';
import 'package:management/network/model/user.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'network/api_service.dart';
import 'network/model/company.dart';
import 'network/model/company.dart';
import 'network/model/company.dart';
import 'network/model/company.dart';


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
  List<Company> complanyList = <Company>[];
  Company selectedCompanyId;
  String complanyid;

  List<Usertype> UsertypeList = <Usertype>[];
  Usertype usertype;
  String Usertypeid;

  List<UserName> UsertypenameList = <UserName>[];
  UserName usernametype;
  String Usertypenameid;

  Future<List> loadCompany() async {
    final api = Provider.of<ApiService>(context, listen: false);
    await api.getCompanyList(1).then((result) {
      if(result.companydata.isNotEmpty ){
        this.complanyList = result.companydata;
        setState(() {
          selectedCompanyId = result.companydata[0];
          complanyid = result.companydata[0].companyid.toString();
        });
      }
    }).catchError((error) {
      print(error);
    });
  }

  Future<List> loadUsertype() async {
    final api = Provider.of<ApiService>(context, listen: false);
    await api.getusertypeList(1).then((result) {
      if(result.usertypedata.isNotEmpty ){
        this.UsertypeList = result.usertypedata;
        setState(() {
          usertype = result.usertypedata[0];
          Usertypeid = result.usertypedata[0].UserScope.toString();
        });
      }
    }).catchError((error) {
      print(error);
    });
  }

  Future<List> loadUsertnameype() async {
    final api = Provider.of<ApiService>(context, listen: false);
    await api.getusernameList(Usertypeid).then((result) {
      if(result.usernamedata.isNotEmpty ){
        this.UsertypenameList = result.usernamedata;
        setState(() {
          usernametype = result.usernamedata[0];
          Usertypenameid = result.usernamedata[0].UserId.toString();
        });
      }
    }).catchError((error) {
      print(error);
    });
  }

  @override
  void initState() {
    super.initState();
    this.loadCompany();
    this.loadUsertype();
   // this.loadUsertnameype();
  }

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

         // Route route = MaterialPageRoute(builder: (context) => Dashboard());
         // Navigator.pushReplacement(context, route);


         // var username=emailController.text.trim();
          var password=passwordFieldController.text.trim();
          print(Usertypenameid.length);
          print(password);
          if(Usertypenameid.isEmpty){
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
            api.getloginTask(Usertypenameid,password,0).then((it) {
           // Map<String, dynamic> user = jsonDecode(it);
           // var userMap = json.decode(it);
           // Userlist userList = Userlist.fromJson(userMap);
             // var i= userList.userdata[0].Status;
              loginRes(it.toString());
            }).catchError((onError){
              print(onError.toString());
              pr.hide();
            });
          }


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
                          height: 150.0,
                          child: Image.asset(
                            "assets/erlogo.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        DropdownButtonFormField(
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Select Company",
                              labelText: 'Company',
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))
                          ),

                          value: selectedCompanyId,
                          // onSaved: (value) => goodsForm.VendorId = value.VendorId.toString(),
                          isDense: true,
                          items: this.complanyList.map((Company data) {
                            return DropdownMenuItem<Company>(
                              child:  Text(data.companyname),
                              value: data,
                            );
                          }).toList(),
                          onChanged: (Company value) {
                            setState(() {
                              complanyid = value.companyid.toString();
                            });
                          },
                        ),
                        SizedBox(height: 10.0),
                        DropdownButtonFormField(
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Select User",
                              labelText: 'User Type',
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))
                          ),

                          value: usertype,
                          // onSaved: (value) => goodsForm.VendorId = value.VendorId.toString(),
                          isDense: true,
                          items: this.UsertypeList.map((Usertype data) {
                            return DropdownMenuItem<Usertype>(
                              child:  Text(data.UserScope),
                              value: data,
                            );
                          }).toList(),
                          onChanged: (Usertype value) {
                            setState(() {
                              Usertypeid = value.UserScope.toString();
                              this.loadUsertnameype();
                            });
                          },
                        ),
                        SizedBox(height: 10.0),
                        DropdownButtonFormField(
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "User Name",
                              labelText: 'User Name',
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))
                          ),

                          value: usernametype,
                          // onSaved: (value) => goodsForm.VendorId = value.VendorId.toString(),
                          isDense: true,
                          items: this.UsertypenameList.map((UserName data) {
                            return DropdownMenuItem<UserName>(
                              child:  Text(data.UserId),
                              value: data,
                            );
                          }).toList(),
                          onChanged: (UserName value) {
                            setState(() {
                              Usertypenameid = value.UserId.toString();
                            });
                          },
                        ),
                        SizedBox(height: 10.0),
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
