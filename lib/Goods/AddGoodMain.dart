import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:management/network/api_service.dart';
import 'package:management/network/model/goods_model.dart';
import 'package:provider/provider.dart';
import 'AddGoods.dart';
import 'dart:async';
// import 'dart:convert';

class AddGoodMain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddGoodMainState();
    throw UnimplementedError();
  }
}

class AddGoodMainState extends State<AddGoodMain> {
  List<PurchaseListData> purchaselist = <PurchaseListData>[];
  bool isLoader = false;

  @override
  void initState() {
    super.initState();
    this.loadPurchaseItemList();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
//    myFocusNode.dispose();
    super.dispose();
  }

  Future<List> loadPurchaseItemList() async {
    isLoader = true;
    final api = Provider.of<ApiService>(context, listen: false);
    await api.getItemPurchaseList(0, 0, 0, 0, 0, "", "", "", "", "", "", 0, 0, 0, 0,
            0, "", "", 0, 0, 0, "", "", 0, "", "", 0, "", "", "", 2).then((result) {
      // print("here");
      isLoader = false;
      // print(result);
      // var res =   jsonDecode(result);
      if (result.purchasedata.isNotEmpty) {
        setState(() {
          purchaselist = result.purchasedata;
        });
      }
    }).catchError((error) {
      isLoader = false;
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    TextStyle style = TextStyle(
        fontFamily: 'Montserrat', fontSize: 15.0, color: Colors.white);
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
//        automaticallyImplyLeading: false,
        title: Text("Purchase Order"),
      ),

      body: Container(
        child: Column(children: <Widget>[
          Container(
            height: 40.0,
            width: double.infinity,
            color: Colors.teal,
            child: Center(child: Text("Main Store", style: style)),
          ), //Sub Title
          /*Container(
            // Search bar
            margin: const EdgeInsets.all(10.0),
            child: emailField,
          ),*/
          purchaselist.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                    itemCount: purchaselist.length,
                    itemBuilder: _buildRow,
                  ),
                )
              : isLoader == true
                  ? Container(
                      margin: const EdgeInsets.all(180.0),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ))
                  : Container(
                      margin: const EdgeInsets.all(180.0),
                      child: Center(
                        child: Text("No Data"),
                      )),
        ]),
      ),
//    )

      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddGoods()));
          },
          child: Icon(Icons.add)),
    );
    throw UnimplementedError();
  }

  Widget _buildRow(BuildContext context, int index) {
    return Card(
      child: Row(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(7.0),
//            FontWeight : const  bold = w700,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text('BarCode : ',
                        style: TextStyle(fontWeight: FontWeight.bold)),
//                    decoration: ,
                  ),
                  Container(
                      child: Text('Quantity : ',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  Container(
                      child: Text("Stock Bal : ",
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  Container(
                      child: Text("Date Stock : ",
                          style: TextStyle(fontWeight: FontWeight.bold))),
                ]),
          ),
          Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text(purchaselist[index].BarCode),
                  ),
                  Container(
                    child: Text(purchaselist[index].Qty.toString()),
                  ),
                  Container(
                    child: Text(purchaselist[index].StockBal.toString()),
                  ),
                  Container(
                    child: Text(purchaselist[index].DateStock),
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}
