import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:management/network/api_service.dart';
import 'package:management/network/model/store_stock_balance.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:moment/moment.dart';

class SearchFormObject {
  String store;
  String fromDate;
  String toDate;

  SearchFormObject({this.fromDate, this.store, this.toDate});
}

class StoreStockBalance extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StoreStockBalanceState();
  }
}

class StoreStockBalanceState extends State<StoreStockBalance> {
  @override
  void initState() {
    super.initState();
    this.loadStore();
  }

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  SearchFormObject serachForm = new SearchFormObject();

  List<StoreStock> storeList = <StoreStock>[];
  StoreStock selectedStoreId;

  bool viewVisible = true;

  final TextEditingController _fromDateController = new TextEditingController();
  final TextEditingController _toDateController = new TextEditingController();

  List<StoreStockBal> searchStockStore = <StoreStockBal>[];

  Future _chooseDate(
      BuildContext context, String initialDateString, type) async {
    var now = new DateTime.now();
    var currentYear = now.year;
    var initialDate = convertToDate(initialDateString) ?? now;
    initialDate = (initialDate.year >= 1900 && initialDate.isBefore(now)
        ? initialDate
        : now);
    print("initialDate");
    print(initialDate);

    var result = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: new DateTime(currentYear - 1),
        lastDate: new DateTime(currentYear + 50));

    if (result == null) return;
    setState(() {
      if (type == "from") {
        _fromDateController.text = new DateFormat.yMd().format(result);
        _toDateController.text = new DateFormat.yMd().format(result);
      }
      if (type == "to") {
        _toDateController.text = new DateFormat.yMd().format(result);
      }
    });
  }

  void showLongToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.redAccent,
        // gravity: type == "1" ? ToastGravity.BOTTOM : ToastGravity.TOP,
        textColor: Colors.white);
  }

  onSearch() {
    try {
      print(int.parse(selectedStoreId.id));
      if (selectedStoreId.id.isNotEmpty &&
          _fromDateController.text.isNotEmpty &&
          _toDateController.text.isNotEmpty) {
        // if (_fromDateController.text.isNotEmpty &&
        //     _toDateController.text.isNotEmpty &&
        //     (strtotime(_fromDateController.text) <
        //         strtotime(serachForm.toDate))) {

        //         }
        Provider.of<ApiService>(context, listen: false)
            .searchStoreStock(int.parse(selectedStoreId.id),
                _fromDateController.text, _toDateController.text)
            .then((result) {
          setState(() {
            viewVisible = false;
            searchStockStore = result.storeStockBaldata.isNotEmpty
                ? result.storeStockBaldata
                : [];
          });
        });
      } else {
        showLongToast("Please Select Store, From date, To date.");
      }
    } catch (error) {
      print(error);
    }
  }

  onReset() {
    setState(() {
      _fromDateController.clear();
      _toDateController.clear();
      selectedStoreId = null;
      selectedStoreId = this.storeList[0];
      this.searchStockStore = [];
    });
  }

  DateTime convertToDate(String input) {
    try {
      var d = new DateFormat.yMd().parseStrict(input);
      return d;
    } catch (e) {
      return null;
    }
  }

  Future<List> loadStore() async {
    try {
      final api = Provider.of<ApiService>(context, listen: false);
      return await api.getStoreStockList(0, "", "", "", "", 7).then((result) {
        if (result.storeStockdata.isNotEmpty) {
          setState(() {
            this.storeList = result.storeStockdata;
            selectedStoreId = this.storeList[0];
          });
        }
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(
        fontFamily: 'Montserrat', fontSize: 15.0, color: Colors.white);
    return Scaffold(
      appBar: AppBar(
        title: Text("Store Stock Balance"),
      ),
      body: Container(
        child: Container(
          // child: Form(
          // key: _formKey,
          child: Column(children: <Widget>[
            // Visibility(
            //   maintainSize: true,
            //   maintainAnimation: true,
            //   maintainState: true,
            //   visible: viewVisible,
            //   child:
            Container(
              margin: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Flexible(
                    child: new TextFormField(
                      // style: TextStyle(height: 1.5),
                      decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'From Date ',
                          hintText: "Enter From Date ",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0))),
                      controller: _fromDateController,
                      keyboardType: TextInputType.number,
                      onTap: (() {
                        _chooseDate(context, _fromDateController.text, "from");
                      }),
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  new Flexible(
                    child: new TextFormField(
                      // style: TextStyle(height: 1.5),
                      decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'To Date ',
                          hintText: "Enter To Date ",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0))),
                      controller: _toDateController,
                      keyboardType: TextInputType.number,
                      onTap: (() {
                        _chooseDate(context, _toDateController.text, "to");
                      }),
                    ),
                  ),
                ],
              ),
            ),
            // ),
            Container(
              margin: const EdgeInsets.all(10.0),
              //  width: 700.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Flexible(
                    child: DropdownButtonFormField<StoreStock>(
                      decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Select Store",
                          labelText: 'Store',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0))),
                      value: selectedStoreId,
                      isDense: true,
                      items: this.storeList.map((StoreStock data) {
                        return DropdownMenuItem<StoreStock>(
                          child: Text(data.storeName),
                          value: data,
                        );
                      }).toList(),
                      onChanged: (StoreStock value) {
                        setState(() {
                          selectedStoreId = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  new Flexible(
                    child: new IconButton(
                      color: Colors.deepOrange,
                      icon: Icon(
                        Icons.search,
                        color: Colors.deepOrange,
                      ),
                      onPressed: onSearch,
                    ),
                    // child: new Material(
                    //   // elevation: 5.0,
                    //   borderRadius: BorderRadius.circular(30.0),
                    //   color: Color(0xffff6E40),
                    //   child: MaterialButton(
                    //     minWidth: MediaQuery.of(context).size.width,
                    //     padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    //     onPressed: onSearch,
                    //     child: Text("Search",
                    //         textAlign: TextAlign.center,
                    //         style: style.copyWith(
                    //             color: Colors.white,
                    //             fontWeight: FontWeight.bold)),
                    //   ),
                    // ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  new Flexible(
                    child: new IconButton(
                      color: Colors.deepOrange,
                      icon: Icon(Icons.refresh, color: Colors.deepOrange),
                      onPressed: onReset,
                    ),
                    // child: new Material(
                    //   elevation: 1.0,
                    //   borderRadius: BorderRadius.circular(30.0),
                    //   color: Color(0x778899),
                    //   child: MaterialButton(
                    //     // minWidth: MediaQuery.of(context).size.width,
                    //     padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    //     onPressed: onReset,
                    //     child: Text("Reset",
                    //         textAlign: TextAlign.center,
                    //         style: style.copyWith(
                    //             color: Colors.white,
                    //             fontWeight: FontWeight.bold)),
                    //   ),
                    // ),
                  ),
                ],
              ),
            ),
            searchStockStore.isNotEmpty
                ? Expanded( 
                    child: ListView.builder(
                        itemCount: searchStockStore.length,
                        itemBuilder: _buildRow))
                : Container(
                    margin: const EdgeInsets.all(170.0),
                    child: Text("No Data"),
                  ),
          ]),
          // ),
        ),
      ),
    );
  }

  Widget _buildRow(BuildContext context, int index) {
    return Card(
        child: InkWell(
      child: Row(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(7.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text('Barcode : ',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    child: Text('Issued Qty : ',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    child: Text('Master Qty : ',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    child: Text("Sold Qty : ",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Container(
                      child: Text("Damage Qty : ",
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  Container(
                      child: Text("Return Qty : ",
                          style: TextStyle(fontWeight: FontWeight.bold))),
                ]),
          ),
          Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text(searchStockStore[index].barcode.toString()),
                  ),
                  Container(
                    child: Text(searchStockStore[index].issueQty.toString()),
                  ),
                  Container(
                    child: Text(searchStockStore[index].masterQty.toString()),
                  ),
                  Container(
                    child: Text(searchStockStore[index].soldQty.toString()),
                  ),
                  Container(
                    child: Text(searchStockStore[index].damageQty.toString()),
                  ),
                  Container(
                    child: Text(
                        searchStockStore[index].returnQtyToStock.toString()),
                  ),
                ]),
          ),
        ],
      ),
    ));
  }
}
