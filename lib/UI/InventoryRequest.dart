import 'package:flutter/material.dart';
import 'package:management/network/model/goods_model.dart';

class InventoryRequest extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return InventoryRequestState();
  }

}

class InventoryRequestState extends State<InventoryRequest>{

 // List<Vendor> vendorList = <Vendor>[];
 // Vendor selectedVenderId;
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);



  @override
  Widget build(BuildContext context) {

    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xffff6E40),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),

        child: Text("GO",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );



    return Scaffold(

      appBar: AppBar(
        title: Text("Inventory Requests"),
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
         // value: selectedVenderId,
//                          onSaved: (value) => goodsForm.VendorId = value.VendorId.toString(),
          isDense: true,
          /*items: this.vendorList.map((Vendor data) {
            return DropdownMenuItem<Vendor>(
              child:  Text(data.VendorName),
              value: data,
            );
          }).toList(),
          onChanged: (Vendor value) {
            setState(() {
              //goodsForm.VendorId = value.VendorId.toString();
             // selectedVenderId = value;
            });
          },*/
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
        decoration: InputDecoration(
            contentPadding:
            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            filled: true,
            fillColor: Colors.white,
            labelText: 'Transport',
            hintText: "Transport",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0))),
        // onSaved: (val) => goodsForm.ItemDesc = val,
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
        decoration: InputDecoration(
            contentPadding:
            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            filled: true,
            fillColor: Colors.white,
            labelText: 'Docket No.',
            hintText: "Enter Docket No.",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0))),
        // onSaved: (val) => goodsForm.ItemDesc = val,
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