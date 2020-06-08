import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:management/network/model/stock_model.dart';
import 'package:provider/provider.dart';
import 'package:management/network/api_service.dart';
import 'package:management/network/model/goods_model.dart';
import 'package:progress_dialog/progress_dialog.dart';

// import 'package:flutter/scheduler.dart';
// import 'package:flutter/foundation.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:oktoast/oktoast.dart';

class EditStockItem extends StatefulWidget {
  @override
  EditStockItem(this.id) : super();

  final int id;

  State<StatefulWidget> createState() {
    return EditStockItemState();
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
  List Size = [];
  String CostPerPrice = "";
  String RetailPrice = "";
  String Margin = "";
  String VAT = "";
  String Discount = "";
  String BrandStyleCode = "";
  String Season = "";
  String Barcode = "";
  List Quantity = [];
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
      this.Discount,
      this.BrandStyleCode,
      this.Season,
      this.Barcode,
      this.Action});
}

class EditStockItemState extends State<EditStockItem> {
  ProgressDialog pr;

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  StockFormObject stockForm = new StockFormObject();

  // EditStockItemState({Key key, @required this.stockList}) : super(key: key);

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

  List<StockListData> stockList = <StockListData>[];

  List sizeArray = [];

  List quantityArray = [];

  TextEditingController controllerQty = new TextEditingController();

  TextEditingController controllerSize = new TextEditingController();

  Future<List> loadStockItemList() async {
    final api = Provider.of<ApiService>(context, listen: false);
    return await api
        .getStockList(
            0, 0, 0, 0, "", "", "", "", "", 0, 0, 0, 0, 0, 0, "", "", "", "", 4)
        .then((result) {
      var data = result.stockData;

      // for (var i = 0; i <= data.length; i++) {
      //   print(data[i].Id);
      //   print(widget.id);
      //   if (data[i].Id == widget.id) {
      //     setState(() {
      //       this.stockList.add(data[i]);
      //       print("this.stockList");
      //       print(this.stockList.first);
      //       sizeArray = this.stockList.first.Size.split(",");
      //       quantityArray = this.stockList.first.Qty.split(",");
      //     });
      //   }
      // }

      data.forEach((element) => {
            print(element.Id),
            print(widget.id),
            if (element.Id == widget.id)
              {
                setState(() {
                  this.stockList.add(element);
                  sizeArray = stockList.first.Size.split(",");
                  quantityArray = stockList.first.Qty.split(",");
                }),
              }
          });

      if (this.stockList.isNotEmpty) {
        this.loadVendor();
        this.loadSeason();
        this.loadGroup();

        if (sizeArray.length > 0) {
          if (sizeArray.length > 1) {
            isButtonRemoveDisabled = false;
          }
          for (var i = 0; i < sizeArray.length; i++) {
            dynamicTextField.add(new AddDynamicText());
            dynamicTextField[i].controllerSize.text = sizeArray[i];
            dynamicTextField[i].controllerQty.text = quantityArray[i];
          }
        } else {
          this.addDynamicTextField();
        }
      }
    }).catchError((error) {
      print(error);
    });
  }

  Future<List> loadVendor() async {
    final api = Provider.of<ApiService>(context, listen: false);
    return await api
        .getVendorList(0, 0, "", "", "", "", 0, 0, "", "", 7)
        .then((result) {
      if (result.vendordata.isNotEmpty) {
        setState(() {
          this.vendorList = result.vendordata;
          this.vendorList.forEach((element) => {
                if (element.VendorId.toString() ==
                    stockList.first.BrandStyleCode)
                  {
                    selectedVenderId = element,
                    print(selectedVenderId),
                  }
              });
        });
      }
    }).catchError((error) {
      print(error);
    });
  }

  Future<List> loadSeason() async {
    final api = Provider.of<ApiService>(context, listen: false);
    return await api.getSeasonList(0, "", 6).then((result) {
      if (result.seasonData.isNotEmpty) {
        setState(() {
          this.seasonList = result.seasonData;
          this.seasonList.forEach((element) => {
                if (element.Id.toString() == stockList.first.Season)
                  {
                    selectedSeasonId = element,
                  }
              });
        });
      } else {
        this.seasonList = [];
      }
    }).catchError((error) {
      print(error);
    });
  }

  Future<List> loadGroup() async {
    final api = Provider.of<ApiService>(context, listen: false);
    return await api.getGroupList(0, "", 0, 4).then((result) {
      if (result.groupData.isNotEmpty) {
        setState(() {
          this.groupList = result.groupData;
          this.groupList.forEach((element) => {
                if (element.GroupId == stockList.first.GroupId)
                  {
                    selectedGroupId = element,
                  }
              });
        });
        this.onLoadCategory();
      } else {
        this.groupList = [];
      }
    }).catchError((error) {
      print(error);
    });
  }

  Future<List> onLoadCategory() async {
    this.categoryList = [];
    final api = Provider.of<ApiService>(context, listen: false);
    return await api
        .getCategoryList(0, "", selectedGroupId.GroupId, 4)
        .then((result) {
      if (result.catData.isNotEmpty) {
        setState(() {
          this.categoryList = result.catData;
          this.categoryList.forEach((element) => {
                if (element.CatId == stockList.first.CatId)
                  {
                    selectedCatId = element,
                  }
              });
        });
        this.onLoadSubCategory();
      } else {
        this.categoryList = [];
      }
    }).catchError((error) {
      print(error);
    });
  }

  Future<List> onLoadSubCategory() async {
    this.subcatList = [];
    final api = Provider.of<ApiService>(context, listen: false);
    return await api
        .getSubCategoryList(0, "", 0, selectedCatId.CatId, 0, 0, 7, "")
        .then((result) {
      if (result.subcatData.isNotEmpty) {
        setState(() {
          this.subcatList = result.subcatData;
          this.subcatList.forEach((val) => {
                if (val.SubId == stockList.first.SubGroupId)
                  {
                    selectedSubCat = val,
                  }
              });
        });
      } else {
        this.subcatList = [];
      }
    }).catchError((error) {
      print(error);
    });
  }

  Future<String> onSubmit() async {
    try {
      _formKey.currentState.save();
      _formKey.currentState.validate();
      var quantity = [];
      var size = [];

      dynamicTextField
          .forEach((widget) => size.addAll({widget.controllerSize.text}));
      dynamicTextField
          .forEach((widget) => quantity.addAll({widget.controllerQty.text}));

      String quant = quantity.join(',');
      String newSize = size.join(',');

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
        pr = new ProgressDialog(context,
            type: ProgressDialogType.Normal,
            isDismissible: false,
            showLogs: true);
        pr.style(
            message: 'processing...',
            borderRadius: 10.0,
            backgroundColor: Colors.white,
            progressWidget: CircularProgressIndicator(),
            elevation: 10.0,
            insetAnimCurve: Curves.easeInOut,
            progress: 0.0,
            maxProgress: 100.0,
            messageTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.w600));
        pr.show();
        final api = Provider.of<ApiService>(context, listen: false);
        await api
            .submitStockFormData(
                stockList.first.Id,
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
                selectedSeasonId.Id,
                stockList.first.Barcode,
                quant,
                "",
                1)
            .then((result) {
          var res = jsonDecode(result);
          if (res.first['Status'] == true &&
              res.first['Message'] == "Success") {
            _formKey.currentState.reset();
            pr.hide();
            // .then((isHidden) {
            //   print(isHidden);
            // });
            Navigator.pop(context, true);
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (BuildContext context) => new StockList()));

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
      pr.hide().then((isHidden) {
        print(isHidden);
      });
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

  // Future<dynamic> onReset() {
  //   _formKey.currentState.reset();
  // }

  addDynamicTextField() {
    if (sizeArray.length > 0) {
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
    this.loadStockItemList();
//    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final halfMediaWidth = MediaQuery.of(context).size.width / 2.0;
    TextStyle style = TextStyle(
        fontFamily: 'Montserrat', fontSize: 15.0, color: Colors.white);
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Stock Items"),
      ),
      body: SingleChildScrollView(
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
                        onChanged: (Group value) {
                          setState(() {
                            stockForm.GroupId = value.GroupId.toString();
                            selectedGroupId = value;
                          });
                          onLoadCategory();
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
                        onChanged: (Category value) {
                          setState(() {
                            stockForm.CatId = value.CatId.toString();
                            selectedCatId = value;
                          });
                          onLoadSubCategory();
                        },
                        validator: (Category value) {
                          if (selectedCatId.CatId == null) {
                            return "Please select Category";
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
                            return "Please select sub Category";
                          }
                          return null;
                        },
                        onChanged: (SubCategory value) {
                          setState(() {
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
                            labelText: 'Article',
                            hintText: "Enter Article",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                        initialValue: stockList.first.Article.isNotEmpty
                            ? stockList?.first?.Article
                            : null,
                        onSaved: (val) => stockForm.Artical = val,
                        onChanged: (newValue) => stockForm.Artical = newValue,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Please enter artical value.";
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
                        validator: (Season value) {
                          if (selectedSeasonId.Id == null) {
                            return "Please select season";
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
                          labelText: 'Style No',
                          hintText: "Enter Style No",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        initialValue: stockList.first.StyleNo.isNotEmpty
                            ? stockList?.first?.StyleNo
                            : null,
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
                        initialValue: stockList.first.Color.isNotEmpty
                            ? stockList?.first?.Color
                            : null,
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
                        initialValue:
                            stockList.first.CostPerPrice.toString().isNotEmpty
                                ? stockList?.first?.CostPerPrice.toString()
                                : null,
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
                        initialValue:
                            stockList.first.RetailPrice.toString().isNotEmpty
                                ? stockList?.first?.RetailPrice.toString()
                                : null,
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
                        initialValue:
                            stockList?.first?.VAT.toString().isNotEmpty
                                ? stockList?.first?.VAT.toString()
                                : null,
                        validator: (dynamic value) {
                          if (value.isEmpty) {
                            return "Please enter GST";
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
                            labelText: 'Discount (In %)',
                            hintText: "Enter Discount (In %)",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                        onSaved: (val) => stockForm.Discount = val,
                        keyboardType: TextInputType.number,
                        initialValue:
                            stockList?.first?.Discount.toString().isNotEmpty
                                ? stockList?.first?.Discount.toString()
                                : null,
                        validator: (dynamic value) {
                          if (value.isEmpty) {
                            return "Please enter Discount";
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
                          labelText: 'Margin (In %)',
                          hintText: "Enter Margin (In %)",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        onSaved: (val) => stockForm.Margin = val,
                        initialValue:
                            stockList?.first?.Margin.toString().isNotEmpty
                                ? stockList?.first?.Margin.toString()
                                : null,
                        keyboardType: TextInputType.number,
                        validator: (dynamic value) {
                          if (value.isEmpty) {
                            return "Please enter Margin";
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
                            labelText: 'Item Desctription',
                            hintText: "Enter Item Description",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                        onSaved: (val) => stockForm.ItemDesc = val,
                        initialValue: stockList.first.ItemDesc.isNotEmpty
                            ? stockList?.first?.ItemDesc
                            : null,
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
                      child: new ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: dynamicTextField.length,
                          itemBuilder: (_, int index) =>
                              dynamicTextField[index]),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    new IconButton(
                      color: Colors.deepOrange,
                      icon: Icon(Icons.add_circle),
                      onPressed: addDynamicTextField,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    new IconButton(
                      color: Colors.deepOrange,
                      icon: Icon(Icons.remove_circle,
                          color: isButtonRemoveDisabled == false
                              ? Colors.deepOrange
                              : Colors.grey),
                      onPressed: isButtonRemoveDisabled == false
                          ? removeDynamicTextField
                          : null,
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
                        child: new Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(30.0),
                      color: Color(0xffff6E40),
                      child: MaterialButton(
                        minWidth: MediaQuery.of(context).size.width / 3.0,
                        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        onPressed: () => {
                          if (_formKey.currentState.validate())
                            {
                              onSubmit(),
                            }
                        },
                        child: Text("Update",
                            textAlign: TextAlign.center,
                            style: style.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    )),
                    SizedBox(
                      width: 5.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddDynamicText extends StatelessWidget {
  TextEditingController controllerQty = new TextEditingController();
  TextEditingController controllerSize = new TextEditingController();

  @override
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
              textInputAction: TextInputAction.go,
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
