import 'package:flutter/material.dart';
import 'package:management/network/model/goods_model.dart';

class InventoryConfirmation extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return InventoryConfirmationState();
  }

}

class InventoryConfirmationState extends State<InventoryConfirmation>{

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


    ])
      )
     )
    );
  }
}