import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:management/network/api_service.dart';
import 'package:management/network/model/vendor_balance.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';

class VendorBalance extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return VendorBalanceState();
  }
}

class VendorBalanceState extends State<VendorBalance> {
  @override
  void initState() {
    super.initState();
    this.loadVendor();
  }

  ProgressDialog pr;

  List<Vendor> vendorList = <Vendor>[];

  Vendor selectedVenderId;

  List<VendorSearchBal> vendorSearchBal = <VendorSearchBal>[];

  List dynamicTextField = [];

  TextEditingController paidAmount = new TextEditingController();

  Future<List> loadVendor() async {
    pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);
    pr.style(
        message: 'loading...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.w600));
    pr.show();
    final api = Provider.of<ApiService>(context, listen: false);
    return await api
        .getBalVendorList(0, 0, "", "", "", "", 0, 0, "", "", 7)
        .then((result) {
      if (result.vendordata.isNotEmpty) {
        setState(() {
          this.vendorList = result.vendordata;
        });
        pr.hide().then((isHidden) {
          print(isHidden);
        });
      }
    }).catchError((error) {
      print(error);
    });
  }

  onVendorChange() async {
    this.vendorSearchBal = [];
    await Provider.of<ApiService>(context, listen: false)
        .getVendorBalanceList(selectedVenderId.VendorId, 0, 2)
        // selectedVenderId.VendorId, 0, "", "", "", "", 0, 0, "", "", 2)
        .then((result) {
      if (result.vendorSearchBal.length > 0) {
        setState(() {
          this.vendorSearchBal = result.vendorSearchBal;
        });
      }
    }).catchError((onError) {
      print(onError);
    });
  }

  void showLongToast(String message, String type) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: type == "1" ? Colors.green : Colors.redAccent,
        // gravity: type == "1" ? ToastGravity.BOTTOM : ToastGravity.TOP,
        textColor: Colors.white);
  }

  Future<String> onUpdate(invoiceNo, balance) async {
    try {
      if (paidAmount.text.isNotEmpty) {
        var bal = double.parse(balance);
        var amount = double.parse(paidAmount.text);
        if (bal >= amount) {
          var paidAmt = (bal - amount);
          return await Provider.of<ApiService>(context, listen: false)
              .updateVendorBalance(
                  paidAmt, int.parse(selectedVenderId.VendorId), invoiceNo, 1)
              .then((result) {
            var res = jsonDecode(result);
            if (res['result'] == 1) {
              showLongToast("Data submitted successfully.", "1");
              this.onVendorChange();
              setState(() {
                this.paidAmount.clear();
              });
            }
          });
        } else {
          showLongToast("Please enter amount less than " + balance, "2");
        }
      } else {
        showLongToast("Enter Paid Amount.", "2");
      }
    } catch (error) {
      showLongToast(error, "0");
      print(error);
    }
  }

  onReset() {
    setState(() {
      this.vendorSearchBal = [];
      selectedVenderId = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(
        fontFamily: 'Montserrat', fontSize: 15.0, color: Colors.white);
    return Scaffold(
      appBar: AppBar(
        title: Text("Vendor Balance"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: 40.0,
              width: double.infinity,
              color: Colors.teal,
              child: Center(child: Text("Check Vendor Balance", style: style)),
            ),
            Card(
              child: Container(
                margin: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Flexible(
                      child: DropdownButtonFormField<Vendor>(
                        decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Select Vendor",
                            labelText: 'Vendor',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                        value: selectedVenderId,
                        isDense: true,
                        items: this.vendorList.map((Vendor data) {
                          return DropdownMenuItem<Vendor>(
                            child: Text(data.VendorName),
                            value: data,
                          );
                        }).toList(),
                        onChanged: (Vendor value) {
                          setState(() {
                            selectedVenderId = value;
                            onVendorChange();
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Tooltip(
                        message: 'Reset',
                        child: new IconButton(
                          color: Colors.deepOrange,
                          icon: Icon(Icons.refresh, color: Colors.deepOrange),
                          onPressed: onReset,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            vendorSearchBal.isNotEmpty
                ? Card(
                    child: Container(
                    margin: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.all(7.0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  child: Text('Invoice No : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ),
                                Container(
                                  child: Text('Vendor Name : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ),
                                Container(
                                  child: Text("Balance : ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ),
                              ]),
                        ),
                        Container(
                          margin: const EdgeInsets.all(7.0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                      vendorSearchBal[0].invoiceNo.toString()),
                                ),
                                Container(
                                  child: Text(
                                      vendorSearchBal[0].vendorName.toString()),
                                ),
                                Container(
                                  child: Text(
                                      vendorSearchBal[0].balance.toString()),
                                ),
                              ]),
                        ),
                        Container(
                          child: new Flexible(
                            child: new TextFormField(
                              textInputAction: TextInputAction.go,
                              controller: paidAmount,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                filled: true,
                                fillColor: Colors.white,
                                labelText: 'Paid Amount',
                                hintText: "Enter Paid Amount",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Container(
                          child: new IconButton(
                            color: Colors.deepOrange,
                            icon: Icon(Icons.update, color: Colors.deepOrange),
                            onPressed: () => {
                              onUpdate(vendorSearchBal[0].invoiceNo,
                                  vendorSearchBal[0].balance)
                            },
                          ),
                        ),
                      ],
                    ),
                  ))
                : Container(
                    margin: const EdgeInsets.all(170.0),
                    child: Text("No Data"),
                  ),

            // vendorSearchBal.isNotEmpty
            //     ? Expanded(
            //         child: ListView.builder(
            //             itemCount: vendorSearchBal.length,
            //             // itemBuilder: (_, index) => dynamicTextField[index]),
            //             itemBuilder: _buildRow))
            //     : Container(
            //         margin: const EdgeInsets.all(170.0),
            //         child: Text("No Data"),
            //       ),

            // )
          ],
        ),
      ),
    );
  }

  // Widget _buildRow(BuildContext context, int index) {
  //   return Card(
  //     child: Row(
  //       // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //       children: <Widget>[
  //         Container(
  //           margin: const EdgeInsets.all(7.0),
  //           child: Column(
  //               mainAxisAlignment: MainAxisAlignment.spaceAround,
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: <Widget>[
  //                 Container(
  //                   child: Text('Invoice No : ',
  //                       style: TextStyle(fontWeight: FontWeight.bold)),
  //                 ),
  //                 Container(
  //                   child: Text('Vendor Name : ',
  //                       style: TextStyle(fontWeight: FontWeight.bold)),
  //                 ),
  //                 Container(
  //                   child: Text("Balance : ",
  //                       style: TextStyle(fontWeight: FontWeight.bold)),
  //                 ),
  //               ]),
  //         ),
  //         Container(
  //           margin: const EdgeInsets.all(7.0),
  //           child: Column(
  //               mainAxisAlignment: MainAxisAlignment.spaceAround,
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: <Widget>[
  //                 Container(
  //                   child: Text(vendorSearchBal[index].invoiceNo.toString()),
  //                 ),
  //                 Container(
  //                   child: Text(vendorSearchBal[index].vendorName.toString()),
  //                 ),
  //                 Container(
  //                   child: Text(vendorSearchBal[index].balance.toString()),
  //                 ),
  //               ]),
  //         ),
  //         Container(
  //           child: new Flexible(
  //             child: new TextFormField(
  //               textInputAction: TextInputAction.go,
  //               controller: paidAmount,
  //               decoration: InputDecoration(
  //                 contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
  //                 filled: true,
  //                 fillColor: Colors.white,
  //                 labelText: 'Paid Amount',
  //                 hintText: "Enter Paid Amount",
  //                 border: OutlineInputBorder(
  //                     borderRadius: BorderRadius.circular(10.0)),
  //               ),
  //             ),
  //           ),
  //         ),
  //         SizedBox(
  //           width: 5.0,
  //         ),
  //         Container(
  //           child: new IconButton(
  //             color: Colors.deepOrange,
  //             icon: Icon(Icons.update, color: Colors.deepOrange),
  //             onPressed: () => {onUpdate(vendorSearchBal[index].invoiceNo)},
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }
}
