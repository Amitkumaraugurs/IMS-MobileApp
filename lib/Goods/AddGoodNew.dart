
import 'dart:io';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'package:image_picker/image_picker.dart';


class AddGoodNew extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddGoodNewState();
    throw UnimplementedError();
  }

}

class AddGoodNewState  extends State<AddGoodNew>{

  File _cameraImage;
  String barcode="";
  String result = "Hey there !";
  TextEditingController texteditController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  _pickImageFromCamera() async {
    File image = await  ImagePicker.pickImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _cameraImage = image;

    });
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 15.0,color: Colors.white);
    final nameField = TextField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "Name",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
    );
    final barcodeField = TextField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "barcode",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
    );
    final descField = TextField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "description",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
    );
    final quantityField = TextField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "0",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
    );
    final submitButon = Material(
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

    appBar: AppBar(
      title: Text("Add item"),
    ),

    body: SingleChildScrollView(

    child: Container(

        child: Column(
            children: <Widget>[
              Container(
                height: 20.0,
                width: double.infinity,
                color: Colors.teal,

                child:Center(
                    child: Text("Store",style: style)
                ),
              ),

              Container(
                margin: const EdgeInsets.all(10.0),
                child: nameField,
              ),
             Container(
               margin: const EdgeInsets.all(10.0),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: <Widget>[
                   Expanded(
                     child: SizedBox(
                         width: 280.0,
                         child: TextField(
                             controller: texteditController,
                              enabled: false,
                             obscureText: false,
                             decoration: InputDecoration(
                                 contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                 filled: true,
                                 fillColor: Colors.white,
                                 hintText: "barcode",border:OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)))
                         )
                     ),
                   ),


                 SizedBox(
                       width: 60.0,
                       height: 50.0,
                   child: new RaisedButton(
                       onPressed: barcodeScanning,
                       child: Image.asset("assets/scan.png")),


                   /*child: GestureDetector(
                     onTap: () {
                       scan;
                       //scanBarcodeNormal();

                     },// otherwise the logo will be tiny
                       child: Image.asset("assets/scan.png"),
                     ),*/
                 )
                 ],

               ),
             ),




              Container(
                margin: const EdgeInsets.all(10.0),
                child: descField,
              ),
              Center(
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                 child: Text("Quantity"),
                  alignment: Alignment(-1.0, -1.0),
                )
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
                child: quantityField,
              ),
              SizedBox(
                width: 100.0,
                height: 100.0,
                child: GestureDetector(
                  onTap: () {
                   // getImage();
                    print("onTap imageview.");
                  },
                  child: Image.asset("assets/photo.png"),
                ),// otherwise the logo will be tiny

              ),
              new RaisedButton(

                onPressed: () {
                  _pickImageFromCamera();
                },
                child: Text("Click Image"),
              ),
              Container(
                margin: const EdgeInsets.all(20.0),
                  child: submitButon
              ),

            ]
        ),

    )),


    );
    throw UnimplementedError();
  }

  Future barcodeScanning() async {
//imageSelectorGallery();

    try {
      print("barcodeScanning");
      String barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode);
      texteditController.text=barcode;
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'No camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this.barcode =
      'Nothing captured.');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }




}

