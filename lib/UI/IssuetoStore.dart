import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:management/network/api_service.dart';
import 'package:management/network/model/goods_model.dart';
import 'package:management/network/model/store.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

class IssuetoStore extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return IssuetoStoreState();
  }

}

class IssuetoStoreState extends State<IssuetoStore>{

  ProgressDialog pr;
  List<Store> vendorList = <Store>[];
  Store selectedVenderId;
  String storeid,docketnumber,transport,article,barcode,qyt;

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  TextEditingController doketController = new TextEditingController();
  TextEditingController transpostController = new TextEditingController();
  TextEditingController articleController = new TextEditingController();
  TextEditingController barcodeController = new TextEditingController();
  TextEditingController qytController = new TextEditingController();

  Future<List> loadStore() async {
    final api = Provider.of<ApiService>(context, listen: false);
    await api.getStoreList(7).then((result) {
      if(result.storedata.isNotEmpty ){
        this.vendorList = result.storedata;
        setState(() {
          selectedVenderId = result.storedata[0];
          storeid = result.storedata[0].storeId.toString();
        });
      }
//      this.vendorList = data.vendordata;
    }).catchError((error) {
      print(error);
    });
  }

  void showLongToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.red,
        textColor: Colors.white);
  }
  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Success"),
          content: new Text("Inventory issue Successfully"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Done"),
              onPressed: () {
                Navigator.of(context).pop();

              },
            ),
          ],
        );
      },
    );
  }
  @override
  void initState() {
    super.initState();
    this.loadStore();
  }
  @override
  Widget build(BuildContext context) {

    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xffff6E40),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async{

          var username=storeid;
          print(storeid);
          var docketnumber=doketController.text;
          var transpost=transpostController.text;
          var articel=articleController.text;
          var barcode=barcodeController.text;
          var quty=qytController.text;

          if(docketnumber.isEmpty){
            showLongToast("Enter Docket No.");
          }else if(transpost.isEmpty){
            showLongToast("Enter Transport");
          }else if(articel.isEmpty){
            showLongToast("Enter articel");
          }else if(barcode.isEmpty){
            showLongToast("Enter BarCode");
          }else if(quty.isEmpty){
            showLongToast("Enter Quantity");
          }else{
            pr = new ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);

            pr.style(
                message: 'Please wait',
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
            api.SaveDistribution(0,storeid,0,qytController.text,0,0,0,0,barcodeController.text,"","",0,transpostController.text,doketController.text,"",19).then((it) {
              //Map<String, dynamic> user = jsonDecode(it);
              print(it);
              pr.hide();
              if(it=="true"){
                _showDialog();
              }
              

            }).catchError((onError){
              print(onError.toString());
              pr.hide();
            });
          }
        },
        child: Text("Submit",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );



    return Scaffold(

      appBar: AppBar(
        title: Text("Inventory Issue to Store"),
      ),
    body: SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(20.0),
    child: Column(
    children: <Widget>[

        DropdownButtonFormField(
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              filled: true,
              fillColor: Colors.white,
              hintText: "Select Store",
              labelText: 'Store',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))
          ),
          value: selectedVenderId,
          // onSaved: (value) => goodsForm.VendorId = value.VendorId.toString(),
          isDense: true,
          items: this.vendorList.map((Store data) {
            return DropdownMenuItem<Store>(
              child:  Text(data.storeName),
              value: data,
            );
          }).toList(),
          onChanged: (Store value) {
            setState(() {
              //goodsForm.VendorId = value.VendorId.toString();
              storeid = value.storeId.toString();
            });
          },
          /*validator: (Vendor value) {
            if (selectedVenderId.VendorId == null) {
              return "Please select vendor";
            }else {
              return null;
            }
          },*/
        ),
      SizedBox(
        height: 15.0,
      ),

        new TextFormField(
          controller: doketController,
          decoration: InputDecoration(
              contentPadding:
              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              filled: true,
              fillColor: Colors.white,
              labelText: 'Docket No.',
              hintText: "Enter Docket No.",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0))),
        //  onSaved: (val) => docketnumber = val,
          validator: (dynamic value) {
            if (value.isEmpty) {
              return "Please enter item description";
            }
            return null;
          },
//                          autofocus: true,
          // decoration: InputDecoration(
          //     contentPadding: EdgeInsets.all(10))
        ),
      SizedBox(
        height: 15.0,
      ),

      new TextFormField(
        controller: transpostController,
        decoration: InputDecoration(
            contentPadding:
            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            filled: true,
            fillColor: Colors.white,
            labelText: 'Transport',
            hintText: "Transport",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0))),
        // onSaved: (val) => transport = val,
        validator: (dynamic value) {
          if (value.isEmpty) {
            return "Please enter item description";
          }
          return null;
        },
//                          autofocus: true,
        // decoration: InputDecoration(
        //     contentPadding: EdgeInsets.all(10))
      ),
      SizedBox(
        height: 15.0,
      ),

      new TextFormField(
        controller: articleController,
        decoration: InputDecoration(
            contentPadding:
            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            filled: true,
            fillColor: Colors.white,
            labelText: 'Article',
            hintText: "Enter Article",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0))),
        // onSaved: (val) => article = val,
        validator: (dynamic value) {
          if (value.isEmpty) {
            return "Please enter item description";
          }
          return null;
        },
//                          autofocus: true,
        // decoration: InputDecoration(
        //     contentPadding: EdgeInsets.all(10))
      ),
      SizedBox(
        height: 15.0,
      ),

      new TextFormField(
        controller: barcodeController,
        decoration: InputDecoration(
            contentPadding:
            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            filled: true,
            fillColor: Colors.white,
            labelText: 'Barcode',
            hintText: "Enter Barcode",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0))),
        // onSaved: (val) => barcode = val,
        validator: (dynamic value) {
          if (value.isEmpty) {
            return "Please enter item description";
          }
          return null;
        },
//                          autofocus: true,
        // decoration: InputDecoration(
        //     contentPadding: EdgeInsets.all(10))
      ),
      SizedBox(
        height: 15.0,
      ),

      new TextFormField(
        controller: qytController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            contentPadding:
            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            filled: true,
            fillColor: Colors.white,
            labelText: 'Issue Qty.',
            hintText: "Enter Issue Qty",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0))),
         //onSaved: (val) => qyt = val,
        validator: (dynamic value) {
          if (value.isEmpty) {
            return "Please enter item description";
          }
          return null;
        },
//                          autofocus: true,
        // decoration: InputDecoration(
        //     contentPadding: EdgeInsets.all(10))
      ),
      SizedBox(
        height: 15.0,
      ),

      loginButon,

    ])
      )
     )
    );
  }
}