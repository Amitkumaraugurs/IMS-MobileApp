import 'package:flutter/material.dart';

import 'AddGoods.dart';
import 'package:management/network/api_service.dart';
import 'package:management/network/model/goods_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


class AddGoodMain extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddGoodMainState();
    throw UnimplementedError();
  }

}

class AddGoodMainState  extends State<AddGoodMain>{
  @override
  void initState() {
    super.initState();
    this.loadPurchaseItemList();
  }


  Future<List> loadPurchaseItemList() async {
    final api = Provider.of<ApiService>(context, listen: false);
    await api.getItemPurchaseList(0, 0, 0, 0, 0, "", "", "", "", "","", 0, 0, 0, 0, 0, "", "", 0, 0, 0, "", "", 0, "", "", 0,
     "", "", "", 2).then((result) {
       print(result);

//      if(result.vendordata.isNotEmpty ){
//        this.vendorList = result.vendordata;
//        setState(() {
//          selectedVenderId = result.vendordata[0];
//          goodsForm.VendorId = result.vendordata[0].VendorId.toString();
//        });
//      }
    }).catchError((error) {
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 15.0,color: Colors.white);
    final emailField = TextField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "Search",
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
    );
    return Scaffold(

    appBar: AppBar(
      title: Text("Goods"),
    ),

    body: Container(
        child: Column(
            children: <Widget>[
              Container(
                height: 20.0,
                width: double.infinity,
                color: Colors.teal,

                child:Center(
                    child: Text("Main Store",style: style)
                ),
              ),

              Container(
                margin: const EdgeInsets.all(10.0),
                child: emailField,
              )
            ]
        ),

    ),



    floatingActionButton: FloatingActionButton(
      onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => AddGoods()));
      },
        child: Icon(Icons.add)
    ),
    );
    throw UnimplementedError();
  }
}