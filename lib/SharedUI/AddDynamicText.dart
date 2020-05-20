import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


class AddDynamicText extends StatelessWidget{
  @override
  Widget build(BuildContext context){

    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Flexible(
            child: new TextFormField(
              decoration: InputDecoration(
                contentPadding:
                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                filled: true,
                fillColor: Colors.white,
                labelText: 'Size',
                hintText: "Enter Size",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
              ),
//                          autofocus: true,
//              onSaved: (val) => stockForm.Size = val,
//                          inputFormatters: [
//                            WhitelistingTextInputFormatter.digitsOnly
//                          ],
              // decoration: InputDecoration(
              //     contentPadding: EdgeInsets.all(10))
            ),
          ),
          SizedBox(
            width: 5.0,
          ),
          new Flexible(
            child: new TextFormField(
              decoration: InputDecoration(
                  contentPadding:
                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Quantity',
                  hintText: "Enter Quantity",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0))),
//              onSaved: (val) => stockForm.Quantity = val,
//                          inputFormatters: [
//                            WhitelistingTextInputFormatter.digitsOnly
//                          ],
              // decoration: InputDecoration(
              //     contentPadding: EdgeInsets.all(10))
            ),
          ),
        ],
      ),
    );

//    return Container(
//      child: new TextField(
//        decoration: new InputDecoration(hintText: "Enter"),
//      )
//    );

  }
}