import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:management/network/api_service.dart';
import 'package:management/network/model/goods_model.dart';
import 'package:provider/provider.dart';
import 'package:oktoast/oktoast.dart';
// import 'package:flutter/scheduler.dart';


class AddStockItem extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddStockItemState();
    throw UnimplementedError();
  }
}

class StockFormObject {
  String CatId;
  String GroupId;
  String SubGruopId;
  String Artical = "";
  String ItemDesc;
  String StyleNo;
  String Color = "";
//  String Size = "";
//  List<StockFormObject> Size;
  List Size = [];
  String CostPerPrice = "";
  String RetailPrice = "";
  String Margin = "";
  String VAT = "";
//  String SAT = "";
  String Discount = "";
  String BrandStyleCode = "";
  String Season = "";
  String Barcode = "";
  String Action = "";

  StockFormObject(
      {this.CatId,
      this.GroupId,
      this.SubGruopId,
      this.Artical,
      this.ItemDesc,
      this.StyleNo,
      this.Color,
      this.Size,
      this.CostPerPrice,
      this.RetailPrice,
      this.Margin,
      this.VAT,
//      this.SAT,
      this.Discount,
      this.BrandStyleCode,
      this.Season,
      this.Barcode,
      this.Action});
}

class AddStockItemState extends State<AddStockItem> {

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  StockFormObject stockForm = new StockFormObject();

  List SizeDataList = [];

  List QuantityDataList = [];

  List<Vendor> vendorList = <Vendor>[];
  Vendor selectedVenderId;

  List<Season> seasonList = <Season>[];
  Season selectedSeasonId;

  List<Group> groupList = <Group>[];
  Group selectedGroupId;

  List<Category> categoryList = <Category>[];
  Category selectedCatId;

  List<SubCategory> subcatList = <SubCategory>[];
  SubCategory selectedSubCat;

  bool isBarcode = false;

  List<AddDynamicText> dynamicTextField = [];

  bool isButtonRemoveDisabled = true;

  Future<List> loadVendor() async {
    final api = Provider.of<ApiService>(context, listen: false);
    await api
        .getVendorList(0, 0, "", "", "", "", 0, 0, "", "", 7)
        .then((result) {
      print(result.vendordata);
      if (result.vendordata.isNotEmpty) {
        this.vendorList = result.vendordata;
        print(this.vendorList);
        setState(() {
          selectedVenderId = result.vendordata[0];
          stockForm.BrandStyleCode = result.vendordata[0].VendorId.toString();
        });
      }
//      this.vendorList = data.vendordata;
    }).catchError((error) {
      print(error);
    });
  }

  Future<List> loadSeason() async {
    final api = Provider.of<ApiService>(context, listen: false);
    await api.getSeasonList(0, "", 6).then((result) {
      print(result.seasonData);
      if (result.seasonData.isNotEmpty) {
        this.seasonList = result.seasonData;
        print(this.seasonList);
        setState(() {
          selectedSeasonId = result.seasonData[0];
          stockForm.Season = result.seasonData[0].Id.toString();
        });
      }
//      this.vendorList = data.vendordata;
    }).catchError((error) {
      print(error);
    });
  }

  Future<List> loadGroup() async {
    final api = Provider.of<ApiService>(context, listen: false);
    await api.getGroupList(0, "", 0, 4).then((result) {
      print(result.groupData);
      selectedGroupId = result.groupData[0];
      if (result.groupData.isNotEmpty) {
        setState(() {
          selectedGroupId = result.groupData[0];
          stockForm.GroupId = result.groupData[0].GroupId.toString();
        });
        this.groupList = result.groupData;
        this.onLoadCategory();
      }
    }).catchError((error) {
      print(error);
    });
  }

  Future<List> onLoadCategory() async {
    final api = Provider.of<ApiService>(context, listen: false);
    await api.getCategoryList(0, "", selectedGroupId.GroupId, 4).then((result) {
      if (result.catData.isNotEmpty) {
//        selectedCatId = result.catData[0];
        setState(() {
          selectedCatId = result.catData[0];
          stockForm.CatId = result.catData[0].CatId.toString();
        });
        this.categoryList = result.catData;
        this.onLoadSubCategory();
      }
    }).catchError((error) {
      print(error);
    });
  }

  Future<List> onLoadSubCategory() async {
    this.subcatList = [];
    final api = Provider.of<ApiService>(context, listen: false);
    await api
        .getSubCategoryList(0, "", 0, selectedCatId.CatId, 0, 0, 7, "")
        .then((result) {
      if (result.subcatData.isNotEmpty) {
        selectedSubCat = result.subcatData[0];
        setState(() {
          selectedSubCat = result.subcatData[0];
          stockForm.SubGruopId = result.subcatData[0].SubId.toString();
        });
        this.subcatList = result.subcatData;
      }
    }).catchError((error) {
      print(error);
    });
  }

  Future<String> onSubmit() async{
    print("submit");
    try {
      _formKey.currentState.save();
      _formKey.currentState.validate();
      var quantity = [];
      var size = [];
      dynamicTextField.forEach((widget) => size.addAll({widget.controllerSize.text}));
      dynamicTextField.forEach((widget) => quantity.addAll({widget.controllerQty.text}));
      String quant = quantity.join(', ');
      String newSize = size.join(', ');

      if (_formKey.currentState.validate() == true) {
        var costPerPrice = stockForm.CostPerPrice.isNotEmpty
            ? double.parse(stockForm.CostPerPrice).toStringAsFixed(2)
            : "";
        var retailPrice = stockForm.RetailPrice.isNotEmpty
            ? double.parse(stockForm.RetailPrice).toStringAsFixed(2)
            : "";
        var margin = stockForm.Margin.isNotEmpty
            ? double.parse(stockForm.Margin).toStringAsFixed(2)
            : "";
        var vat = stockForm.VAT.isNotEmpty
            ? double.parse(stockForm.VAT).toStringAsFixed(2)
            : "";
//        var sat = stockForm.SAT.isNotEmpty
//            ? double.parse(stockForm.SAT).toStringAsFixed(2)
//            : "";
        final api = Provider.of<ApiService>(context, listen: false);
        await api.submitStockFormData(
                0,
                selectedCatId.CatId,
                selectedGroupId.GroupId,
                selectedSubCat.SubId,
                stockForm.Artical,
                stockForm.ItemDesc,
                stockForm.StyleNo,
                stockForm.Color,
                newSize,
                costPerPrice,
                retailPrice,
                margin,
                vat,
                "",
                stockForm.Discount,
                selectedVenderId.VendorId,
                stockForm.Season,
                stockForm.Barcode,
                quant,
                0)
            .then((result) {
          var res = jsonDecode(result);
          if (res[0]['Status'] == true && res[0]['Message'] == "Success") {
            print("dddd");
            this.loadVendor();
            this.loadSeason();
            this.loadGroup();
            dynamicTextField.forEach((widget) => widget.controllerSize.clear());
            dynamicTextField.forEach((widget) => widget.controllerQty.clear());
            _formKey.currentState.reset();

            // showToast('Data Saved Successfully.');

            // Fluttertoast.showToast(msg: "Data Saved Successfully.");

            // Fluttertoast.showToast(
            //     msg: "Data Saved Successfully.",
            //     toastLength: Toast.LENGTH_LONG,
            //     backgroundColor: Colors.green,
            //     textColor: Colors.white);

            //  Fluttertoast.showToast(
            //      msg: "Data saved successfully.",
            //      toastLength: Toast.LENGTH_SHORT,
            //      gravity: ToastGravity.CENTER,
            //     //  timeInSecForIosWeb: 1,
            //      backgroundColor: Colors.green,
            //textColor: Colors.white,
            //      fontSize: 16.0
            //  );
          // } else {
          //   showToast('Some error occured.');
          }
        });
      }
    } catch (error) {
      print("error");
      print(error);
//      Fluttertoast.showToast(
//          msg: error,
//          toastLength: Toast.LENGTH_SHORT,
//          gravity: ToastGravity.CENTER,
//          timeInSecForIosWeb: 1,
//          backgroundColor: Colors.red,
//          textColor: Colors.white,
//          fontSize: 16.0);
    }
  }

  Future<dynamic> onReset() {
    _formKey.currentState.reset();
  }

  addDynamicTextField() {
    if (dynamicTextField.length > 1) {
      isButtonRemoveDisabled = false;
    }
    dynamicTextField.add(new AddDynamicText());
  }

  removeDynamicTextField() {
    dynamicTextField.removeAt(dynamicTextField.length - 1);
    if (dynamicTextField.length == 1) {
      isButtonRemoveDisabled = true;
    }
  }

  // Start for date

  final TextEditingController _controller = new TextEditingController();

  Future _chooseDate(BuildContext context, String initialDateString) async {
    var now = new DateTime.now();
    var initialDate = convertToDate(initialDateString) ?? now;
    initialDate = (initialDate.year >= 1900 && initialDate.isBefore(now)
        ? initialDate
        : now);
    var currentYear = now.year;
    var result = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: new DateTime(currentYear - 1),
        lastDate: new DateTime(currentYear + 20));
    if (result == null) return;
    setState(() {
      _controller.text = new DateFormat.yMd().format(result);
    });
  }

  //end for date

  DateTime convertToDate(String input) {
    try {
      var d = new DateFormat.yMd().parseStrict(input);
      return d;
    } catch (e) {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    this.loadVendor();
    this.loadSeason();
    this.loadGroup();
    this.addDynamicTextField();
    //  SchedulerBinding.instance.addPostFrameCallback((_) {
    //   Navigator.of(context).pushNamed("StockList");
    // });
//    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
//    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final halfMediaWidth = MediaQuery.of(context).size.width / 2.0;
    // TODO: implement build
    TextStyle style = TextStyle(
        fontFamily: 'Montserrat', fontSize: 15.0, color: Colors.white);
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Stock Items"),
      ),
      body: SingleChildScrollView(
//      body: Container(
//        child: Container(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Container(
                height: 35.0,
                width: double.infinity,
                color: Colors.teal,
                child: Center(child: Text("Stock Items", style: style)),
              ),
              Container(
                margin: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Flexible(
                      child: DropdownButtonFormField<Group>(
//                          onSaved: (value) => stockForm.GroupId = value.GroupId.toString(),
//                        hint: Text("Select item"),
                        onChanged: (Group value) {
                          onLoadCategory();
                          setState(() {
                            stockForm.GroupId = value.GroupId.toString();
                            selectedGroupId = value;
                          });
                        },
                        validator: (Group value) {
                          if (selectedGroupId.GroupId == null) {
                            return "Please select group";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Group',
                            hintText: "Select Group",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                        value: selectedGroupId,
                        isDense: true,
                        items: this.groupList.map((Group data) {
                          return DropdownMenuItem<Group>(
                            child: new Text(data.GroupName),
                            value: data,
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    new Flexible(
                      child: DropdownButtonFormField<Category>(
//                          onSaved: (val) => stockForm.CatId = val.CatId.toString(),
                        onChanged: (Category value) {
                          onLoadSubCategory();
                          setState(() {
                            stockForm.CatId = value.CatId.toString();
                            selectedCatId = value;
                          });
                        },
                        validator: (Category value) {
                          if (selectedCatId.CatId == null) {
                            return "Please select category";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Category',
                            hintText: "Select Category",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),

                        value: selectedCatId,
                        isDense: true,
                        items: this.categoryList.map((Category data) {
                          return DropdownMenuItem<Category>(
                            child: new Text(data.CatName),
                            value: data,
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Flexible(
                      child: DropdownButtonFormField<SubCategory>(
                        decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Sub Category',
                            hintText: "Select Sub Category",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                        validator: (SubCategory value) {
                          if (selectedSubCat.SubId == null) {
                            return "Please select sub category";
                          }
                          return null;
                        },
                        onChanged: (SubCategory value) {
                          setState(() {
                            stockForm.SubGruopId = value.SubId.toString();
                            selectedSubCat = value;
                          });
                        },
                        isDense: true,
                        items: this.subcatList.map((SubCategory data) {
                          return DropdownMenuItem<SubCategory>(
                            child: new Text(data.SubName),
                            value: data,
                          );
                        }).toList(),
//                          onSaved: (val) => stockForm.SubGruopId = val.SubId.toString(),
                        value: selectedSubCat,
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
                            labelText: 'Artical',
                            hintText: "Enter Artical",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                        onSaved: (val) => stockForm.Artical = val,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Please enter artical value.";
                          }
                          return null;
                        },
                        // decoration: InputDecoration(
                        //     contentPadding: EdgeInsets.all(10))
                      ),
                    ),
                  ],
                ),
              ),
              Container(
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
//                          onSaved: (value) => goodsForm.VendorId = value.VendorId.toString(),
                        isDense: true,
                        items: this.vendorList.map((Vendor data) {
                          return DropdownMenuItem<Vendor>(
                            child: Text(data.VendorName),
                            value: data,
                          );
                        }).toList(),
                        onChanged: (Vendor value) {
                          setState(() {
                            stockForm.BrandStyleCode =
                                value.VendorId.toString();
                            selectedVenderId = value;
                          });
                        },
                        validator: (Vendor value) {
                          if (selectedVenderId.VendorId == null) {
                            return "Please select vendor";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    new Flexible(
                      child: DropdownButtonFormField<Season>(
                        onChanged: (Season value) {
                          setState(() {
                            stockForm.Season = value.Id.toString();
                            selectedSeasonId = value;
                          });
                        },
                        decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: "Season",
                            hintText: "Select Season",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                        value: selectedSeasonId,
                        isDense: true,
                        items: this.seasonList.map((Season data) {
                          return DropdownMenuItem<Season>(
                            child: new Text(data.SeasonName),
                            value: data,
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
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
                          labelText: 'Style No',
                          hintText: "Enter Style No",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
//                          autofocus: true,
                        onSaved: (val) => stockForm.StyleNo = val,
                        validator: (dynamic value) {
                          if (value.isEmpty) {
                            return "Please enter style no";
                          }
                          return null;
                        },
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
                            labelText: 'Color',
                            hintText: "Enter Color",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                        onSaved: (val) => stockForm.Color = val,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
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
                            labelText: 'Cost Price',
                            hintText: "Enter Cost Price",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
//                          autofocus: true,
                        onSaved: (val) => stockForm.CostPerPrice = val,
                        keyboardType: TextInputType.number,
                        validator: (dynamic value) {
                          if (value.isEmpty) {
                            return "Please enter cost price";
                          }
                          return null;
                        },
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
                            labelText: 'Retail Price',
                            hintText: "Enter Retail Price",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                        onSaved: (val) => stockForm.RetailPrice = val,
                        keyboardType: TextInputType.number,
                        validator: (dynamic value) {
                          if (value.isEmpty) {
                            return "Please enter retail price";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
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
                            labelText: 'GST (In %)',
                            hintText: "Enter GST (In %)",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                        onSaved: (val) => stockForm.VAT = val,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
//                      new Flexible(
//                        child: new TextFormField(
//                          decoration: InputDecoration(
//                              contentPadding:
//                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                              filled: true,
//                              fillColor: Colors.white,
//                              labelText: 'Sat',
//                              hintText: "Enter Sat",
//                              border: OutlineInputBorder(
//                                  borderRadius: BorderRadius.circular(10.0))),
//                          onSaved: (val) => stockForm.SAT = val,
//                        ),
//                      ),

                    new Flexible(
                      child: new TextFormField(
                        decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Discount (In %)',
                            hintText: "Enter Discount (In %)",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                        onSaved: (val) => stockForm.Discount = val,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
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
                          labelText: 'Margin (In %)',
                          hintText: "Enter Margin (In %)",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        onSaved: (val) => stockForm.Margin = val,
                        keyboardType: TextInputType.number,
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
                          labelText: 'RFID',
                          hintText: "Enter RFID (In %)",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
//                          onSaved: (val) => stockForm.Margin = val,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
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
                            labelText: 'Item Desctription',
                            hintText: "Enter Item Description",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                        onSaved: (val) => stockForm.ItemDesc = val,
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
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
//                      new Flexible(
////                          child: new Checkbox(
////                            value: isBarcode,
////                            onChanged: (bool value) {
////                              setState(() {
////                                isBarcode = value;
////                              });
////                            },
////                          )
//                      ),
//                      SizedBox(
//                        width: 1.0,
//                      ),
//                      new Flexible(
////                          child: new Text(""
//////                              "Want to generate barcode."
////                          )
//                      ),
//                      SizedBox(
//                        width: 5.0,
//                      ),
                    new Flexible(
                      child: new TextFormField(
                        decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Barcode',
                            hintText: "Barcode",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                        onSaved: (val) => stockForm.Barcode = val,
//                           decoration: InputDecoration(
//                               contentPadding: EdgeInsets.all(10))
                      ),
                    ),
                  ],
                ),
              ),
//                Container(
//                  margin: const EdgeInsets.all(10.0),
//                  child: Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceAround,
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    children: <Widget>[
//                      new Flexible(
//                        child: new TextFormField(
//                          decoration: InputDecoration(
//                            contentPadding:
//                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                            filled: true,
//                            fillColor: Colors.white,
//                            labelText: 'Size',
//                            hintText: "Enter Size",
//                            border: OutlineInputBorder(
//                                borderRadius: BorderRadius.circular(10.0)),
//                          ),
////                          autofocus: true,
//                          onSaved: (val) => stockForm.Size = val,
////                          inputFormatters: [
////                            WhitelistingTextInputFormatter.digitsOnly
////                          ],
//                          // decoration: InputDecoration(
//                          //     contentPadding: EdgeInsets.all(10))
//                        ),
//                      ),
//                      SizedBox(
//                        width: 5.0,
//                      ),
//                      new Flexible(
//                        child: new TextFormField(
//                          decoration: InputDecoration(
//                              contentPadding:
//                              EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                              filled: true,
//                              fillColor: Colors.white,
//                              labelText: 'Quantity',
//                              hintText: "Enter Quantity",
//                              border: OutlineInputBorder(
//                                  borderRadius: BorderRadius.circular(10.0))),
//                          onSaved: (val) => stockForm.Quantity = val,
////                          inputFormatters: [
////                            WhitelistingTextInputFormatter.digitsOnly
////                          ],
//                          // decoration: InputDecoration(
//                          //     contentPadding: EdgeInsets.all(10))
//                        ),
//                      ),
//                      SizedBox(
//                        width: 5.0,
//                      ),
//                      new Flexible(
//                        child: Icon(
//                          Icons.add,
//                          color: Colors.deepOrange,
//                          size: 24.0,
//                          semanticLabel: 'Text to announce in accessibility modes'
//                      ),
//                    ],
//                  ),
//                ),
//                Container(
//                    margin: const EdgeInsets.all(10.0),
//                    child: Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceAround,
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                    )
//                ),
              Container(
                margin: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Flexible(
                      child: new ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: dynamicTextField.length,
                          itemBuilder: (_, int index) =>
                              dynamicTextField[index]),
                    ),
//                      ),
                    SizedBox(
                      width: 5.0,
                    ),
                    new IconButton(
//                        icon: Icon(Icons.remove_circle),
                      color: Colors.deepOrange,
                      icon: Icon(Icons.add_circle,
                          color: Colors.deepOrange,
//                            size: 24.0,
                          semanticLabel:
                              'Text to announce in accessibility modes'),
                      onPressed: addDynamicTextField,
                    ),
//                      if(dynamicTextField.length > 1){
                    SizedBox(
                      width: 5.0,
                    ),
                    new IconButton(
//                        icon: Icon(Icons.remove_circle),
                      color: Colors.deepOrange,
                      icon: Icon(Icons.remove_circle,
                          color: isButtonRemoveDisabled == false
                              ? Colors.deepOrange
                              : Colors.grey,
//                            size: 24.0,
                          semanticLabel:
                              'Text to announce in accessibility modes'),
                      onPressed: isButtonRemoveDisabled == false
                          ? removeDynamicTextField
                          : null,
                    ),
//  }
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Flexible(
                        child: new Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(30.0),
                      color: Color(0xffff6E40),
                      child: MaterialButton(
                        minWidth: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        onPressed: () => {
                          if (_formKey.currentState.validate())
                            {
                              onSubmit(),
                            }
                        },
                        child: Text("Submit",
                            textAlign: TextAlign.center,
                            style: style.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    )),
                    SizedBox(
                      width: 5.0,
                    ),
                    new Flexible(
                        child: new Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(30.0),
                      color: Color(0x778899),
                      child: MaterialButton(
                        minWidth: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        onPressed: onReset,
                        child: Text("Reset",
                            textAlign: TextAlign.center,
                            style: style.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    )),
                  ],
                ),
              ),
            ],
          ),
        ),
//        ),
      ),
    );
  }
}

class AddDynamicText extends StatelessWidget {
  TextEditingController controllerQty = new TextEditingController();
  TextEditingController controllerSize = new TextEditingController();

  @override
  StockFormObject stockForm = new StockFormObject();

  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Flexible(
            child: new TextFormField(
              controller: controllerSize,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                filled: true,
                fillColor: Colors.white,
                labelText: 'Size',
                hintText: "Enter Size",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
              ),
            ),
          ),
          SizedBox(
            width: 5.0,
          ),
          new Flexible(
            child: new TextFormField(
              controller: controllerQty,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Quantity',
                  hintText: "Enter Quantity",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0))),
            ),
          ),
        ],
      ),
    );
  }
}
