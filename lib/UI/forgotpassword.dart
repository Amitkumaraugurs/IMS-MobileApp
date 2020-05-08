import 'package:flutter/material.dart';

class forgotpassword extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

    return ForgotState();
    throw UnimplementedError();
  }

}

class ForgotState extends State<forgotpassword>{
  @override
  Widget build(BuildContext context) {

    TextEditingController emailController = new TextEditingController();
    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
    Size size = MediaQuery.of(context).size;
    final emailField = TextField(
      controller: emailController,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "Enter Email",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xffff6E40),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: (){

        },
        child: Text("Submit",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
        backgroundColor: Color(0xFFD6D6D6),
        appBar: AppBar(
          title: Text("Forgot Password"),
        ),

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
                               /* SizedBox(
                                  height: 165.0,
                                  child: Image.asset(
                                    "assets/erlogo.png",
                                    fit: BoxFit.contain,
                                  ),
                                ),*/
                                SizedBox(height: 20.0),
                                emailField,
                                SizedBox(
                                  height: 25.0,
                                ),
                                loginButon,
                                SizedBox(
                                  height: 25.0,
                                ),

                              ]
                          )
                      ),


                    )
                ),
              ],



            ))

    );
  }


}