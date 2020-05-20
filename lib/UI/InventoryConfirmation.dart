import 'package:flutter/material.dart';
import 'package:management/network/api_service.dart';
import 'package:management/network/model/goods_model.dart';
import 'package:management/network/model/inventoryConf.dart';
import 'package:management/network/model/store.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

class InventoryConfirmation extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return InventoryConfirmationState();
  }

}

class InventoryConfirmationState extends State<InventoryConfirmation>{

  ProgressDialog pr;
  List<Store> vendorList = <Store>[];
  Store selectedVenderId;
  String storeid;
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  List<InventoryListData> InventoryList = <InventoryListData>[];

  Future<List> loadStockItemList() async {
    final api = Provider.of<ApiService>(context, listen: false);
    await api.Gettransfer(0, 7, 0,storeid,0,"",0,0).then((result) {
      print(result.inventoryData);
      if (result.inventoryData.isNotEmpty) {
        setState(() {
          InventoryList = result.inventoryData;
        });
      }else{
        InventoryList = [];
      }
      print(InventoryList);
    }).catchError((error) {
      print(error);
    });
  }



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

        child: Text("ADD",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );



    return Scaffold(

      appBar: AppBar(
        title: Text("Inventory Confirmation"),
      ),
    body:Container(

    child: Column(
    children: <Widget>[
      Container(
          margin: const EdgeInsets.all(20.0),
        child: DropdownButtonFormField(
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
              this.loadStockItemList();
            });
          },
        )
      ),
      InventoryList.isNotEmpty
          ? Expanded(child: ListView.builder(
        itemCount: InventoryList.length,
        itemBuilder: _buildRow,
      ),
      )
          : Container(
      )

    ])
      )

    );
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
                    child: Text('From Store : ',
                        style: TextStyle(fontWeight: FontWeight.bold)),
//                    decoration: ,
                  ),
                  Container(
                      child: Text('To Store : ',
                          style: TextStyle(fontWeight: FontWeight.bold))
                  ),
                  Container(
                      child: Text("Item : ",
                          style: TextStyle(fontWeight: FontWeight.bold))
                  ),
                  Container(
                      child: Text("Barcode : ",
                          style: TextStyle(fontWeight: FontWeight.bold))
                  ),
                  Container(
                      child: Text("Issued Qty : ",
                          style: TextStyle(fontWeight: FontWeight.bold))
                  ),
                  Container(
                      child: Text("Status : ",
                          style: TextStyle(fontWeight: FontWeight.bold))
                  ),
                ]
            ),
          ),

          Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text(InventoryList[index].FromStore != null ? InventoryList[index].FromStore :''),
                  ),
                  Container(
                    child: Text(InventoryList[index].ToStore != null ? InventoryList[index].ToStore :''),
                  ),
                  Container(
                    child: Text(InventoryList[index].ItemDesc != null ? InventoryList[index].ItemDesc :''),
                  ),
                  Container(
                    child: Text(InventoryList[index].Barcode != null ? InventoryList[index].Barcode :''),
                  ),
                  Container(
                    child: Text(InventoryList[index].IssuedQty.toString() != null ? InventoryList[index].IssuedQty.toString() :''),
                  ),
                  Container(
                    child: Text(InventoryList[index].Status != null ? InventoryList[index].Status :''),
                  ),
                ]
            ),
          ),
        ],
      ),
    );
  }
}