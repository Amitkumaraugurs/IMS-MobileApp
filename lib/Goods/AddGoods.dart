import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:management/network/api_service.dart';
import 'package:management/network/model/goods_model.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddGoods extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddGoodsStates();
  }
}

class GoodsFormObject {
  String VendorId ;
  String CatId ;
  String GroupId ;
  String SubGruopId ;
  String Barcode = "";
//  String Concept;
  String ItemDesc;
  String StyleNo;
  String Color = "";
  String Size = "";
  String CostPerPrice = "";
  String RetailPrice = "";
  String Quantity = "";
//  String SaleQuantity;
//  String StockBal;
  String DateStock = "";
  String Season = "";
  String Margin = "";
  String VAT = "";
  String SAT = "";
  String Offer = "";
  String BrandStyleCode = "";
//  String StoreId;
  String Transport = "";
  String DocketNo = "";
//  String StockLife;
//  String OutTransport;
//  String OutDockectNo;
  String Artical = "";
  String Action = "";

  GoodsFormObject({this.VendorId,
      this.CatId,
      this.GroupId,
      this.SubGruopId,
      this.Barcode,
      this.Color,
      this.Size,
      this.CostPerPrice,
      this.RetailPrice,
      this.Quantity,
      this.DateStock,
      this.Season,
      this.Margin,
      this.VAT,
      this.SAT,
      this.Offer,
      this.BrandStyleCode,
      this.Transport,
      this.DocketNo,
      this.Artical,
      this.Action});

//  final Function validator;

}

class AddGoodsStates extends State<AddGoods> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  

//  FocusNode myFocusNode;

//  Goodsform goodsForm = new Goodsform();

  GoodsFormObject goodsForm = new GoodsFormObject();

  List<Vendor> vendorList = <Vendor>[];
  Vendor selectedVenderId;

  List<Group> groupList = <Group>[];
  Group selectedGroupId;

  List<Category> categoryList = <Category>[];
  Category selectedCatId;

  List<SubCategory> subcatList = <SubCategory>[];
  SubCategory selectedSubCat;

  bool isBarcode = false;

  Future<List> loadVendor() async {
    final api = Provider.of<ApiService>(context, listen: false);
    await api.getVendorList(0, 0, "", "", "", "", 0, 0, "", "", 7).then((result) {
      if(result.vendordata.isNotEmpty ){
        this.vendorList = result.vendordata;
        setState(() {
          selectedVenderId = result.vendordata[0];
          goodsForm.VendorId = result.vendordata[0].VendorId.toString();
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
      print(result.groupData.isNotEmpty);
      selectedGroupId = result.groupData[0];
      if(result.groupData.isNotEmpty ){
        setState(() {
          selectedGroupId = result.groupData[0];
          goodsForm.GroupId = result.groupData[0].GroupId.toString();
        });
        this.groupList = result.groupData;
        this.onLoadCategory();
      }
    }).catchError((error) {
      print(error);
    });
  }

  Future<List> onLoadCategory() async {
//    this.categoryList = [];
    final api = Provider.of<ApiService>(context, listen: false);
    await api.getCategoryList(0, "", selectedGroupId.GroupId, 4).then((result) {
      if(result.catData.isNotEmpty){
//        selectedCatId = result.catData[0];
        setState(() {
          selectedCatId = result.catData[0];
          goodsForm.CatId = result.catData[0].CatId.toString();
        });
        this.categoryList = result.catData;
        this.onLoadSubCategory();
      }
    }).catchError((error) {
      print(error);
    });
  }

  Future<List> onLoadSubCategory() async {
    print(selectedCatId);
    this.subcatList = [];
    final api = Provider.of<ApiService>(context, listen: false);
    await api.getSubCategoryList(0, "", 0, selectedCatId.CatId, 0, 0, 7, "").then((result) {
      if(result.subcatData.isNotEmpty){
        selectedSubCat = result.subcatData[0];
        setState(() {
          selectedSubCat = result.subcatData[0];
          goodsForm.SubGruopId = result.subcatData[0].SubId.toString();
        });
        this.subcatList = result.subcatData;
      }
    }).catchError((error) {
      print(error);
    });
  }

  Future<String> onSubmit() {

    try {
      _formKey.currentState.save();
      _formKey.currentState.validate();

      print("submit");
//    print(goodsForm);
//    print(goodsForm.VendorId);
//    print(goodsForm.CatId);
//    print(goodsForm.GroupId);
//    print(goodsForm.SubGruopId);
//    print(goodsForm.Barcode);
//    print(goodsForm.Color);
//    print(goodsForm.Size);
//    print(goodsForm.RetailPrice);
//    print(goodsForm.Quantity);
//
//    print(goodsForm.DateStock);
//    print(goodsForm.Season);
//    print(goodsForm.Margin);
//    print(goodsForm.VAT);
//    print(goodsForm.SAT);
//
//    print(goodsForm.Offer);
//    print(goodsForm.BrandStyleCode);
//    print(goodsForm.Transport);
//    print(goodsForm.DocketNo);
//    print(goodsForm.Artical);
//
//    print(_formKey.currentState.validate());
//
      if (_formKey.currentState.validate() == true) {
        print('here');
        var costPerPrice = goodsForm.CostPerPrice.isNotEmpty ?  double.parse(goodsForm.CostPerPrice).toStringAsFixed(2) : "";
        var retailPrice = goodsForm.RetailPrice.isNotEmpty ?  double.parse(goodsForm.RetailPrice).toStringAsFixed(2) : "";
        var quantity = goodsForm.Quantity.isNotEmpty ?  double.parse(goodsForm.Quantity).toStringAsFixed(2) : "";
        var margin = goodsForm.Margin.isNotEmpty ?  double.parse(goodsForm.Margin).toStringAsFixed(2) : "";
        var vat = goodsForm.VAT.isNotEmpty ?  double.parse(goodsForm.VAT).toStringAsFixed(2) : "";
        var sat = goodsForm.SAT.isNotEmpty ?  double.parse(goodsForm.SAT).toStringAsFixed(2) : "";

        final api = Provider.of<ApiService>(context, listen: false);
        api.submitGoodsFormData(
            0,
            int.parse(goodsForm.VendorId),
            int.parse(goodsForm.CatId),
            int.parse(goodsForm.GroupId),
            int.parse(goodsForm.SubGruopId),
            goodsForm.Barcode,
            "0",
            "",
            "",
            goodsForm.Color,
            goodsForm.Size,
            costPerPrice,
            retailPrice,
            quantity,
            0,
            0,
            goodsForm.DateStock,
            goodsForm.Season,
            margin,
            vat,
            sat,
            goodsForm.Offer,
            goodsForm.BrandStyleCode,
            0,
            goodsForm.Transport,
            goodsForm.DocketNo,
            0,
            "",
            "",
            goodsForm.Artical, 0).then((result) {
          print(result);

//          print(result.Message);
//          if (result.Status == true && result.Message == "Success") {
//            print("dddd");
//            _formKey.currentState.reset();
//            Fluttertoast.showToast(
//                msg: "Data saved successfully.",
//                toastLength: Toast.LENGTH_SHORT,
//                gravity: ToastGravity.CENTER,
//                timeInSecForIosWeb: 1,
//                backgroundColor: Colors.green,
//                textColor: Colors.white,
//                fontSize: 16.0
//            );
////          } else {
//          }
        });
      }
    }catch(error){
      print(error);
      Fluttertoast.showToast(
          msg: error,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }

  Future<dynamic> onReset() {
    _formKey.currentState.reset();
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
    this.loadGroup();
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
    String categorySelected;

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Item"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Container(
                  height: 20.0,
                  width: double.infinity,
                  color: Colors.teal,
                  child: Center(child: Text("Store", style: style)),
                ),
                Container(
                  margin: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Flexible(
                        child: new TextFormField(
                          textInputAction: TextInputAction.done,
//                          autofocus: true,
//                          focusNode: myFocusNode,
                          decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Transport',
                              hintText: "Enter Transport No.",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                          onSaved: (val) => goodsForm.Transport = val,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please enter the value";
                            }else {
                              return null;
                            }
                          },
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
                              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Enter Docket No",
                              labelText: 'Docket No',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
//                          autofocus: true,
                          onSaved: (val) => goodsForm.DocketNo = val,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return "Please enter the value";
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
                              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Select Vendor",
                              labelText: 'Vendor',
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))
                          ),
                          value: selectedVenderId,
//                          onSaved: (value) => goodsForm.VendorId = value.VendorId.toString(),
                          isDense: true,
                          items: this.vendorList.map((Vendor data) {
                            return DropdownMenuItem<Vendor>(
                              child:  Text(data.VendorName),
                              value: data,
                            );
                          }).toList(),
                          onChanged: (Vendor value) {
                            setState(() {
                              goodsForm.VendorId = value.VendorId.toString();
                              selectedVenderId = value;
                            });
                          },
                          validator: (Vendor value) {
                            if (selectedVenderId.VendorId == null) {
                              return "Please select vendor";
                            }else {
                              return null;
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      new Flexible(
                        child: DropdownButtonFormField<Group>(
//                          onSaved: (value) => goodsForm.GroupId = value.GroupId.toString(),
//                        hint: Text("Select item"),
                          onChanged: (Group value) {
                            onLoadCategory();
                            setState(() {
                              goodsForm.GroupId = value.GroupId.toString();
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
                        child:  DropdownButtonFormField<Category>(
//                          onSaved: (val) => goodsForm.CatId = val.CatId.toString(),
                          onChanged: (Category value) {
                            onLoadSubCategory();
                            setState(() {
                              goodsForm.CatId = value.CatId.toString();
                              selectedCatId = value;
                            });
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
                          // decoration: InputDecoration(
                          //     contentPadding: EdgeInsets.all(10))
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      new Flexible(
                        child:  DropdownButtonFormField<SubCategory>(
                          decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                               filled: true,
                              fillColor: Colors.white,
                              labelText: 'Sub Category',
                              hintText: "Select Sub Category",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                          onChanged: (SubCategory value) {
                            setState(() {
                              goodsForm.SubGruopId = value.SubId.toString();
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
//                          onSaved: (val) => goodsForm.SubGruopId = val.SubId.toString(),
                          value: selectedSubCat,
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
                          onSaved: (val) => goodsForm.ItemDesc = val,
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
                            labelText: 'Style No',
                            hintText: "Enter Style No",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
//                          autofocus: true,
                          onSaved: (val) => goodsForm.StyleNo = val,
                          validator: (dynamic value) {
                            if (value.isEmpty) {
                              return "Please enter style no";
                            }
                            return null;
                          },
//                          inputFormatters: [
//                            WhitelistingTextInputFormatter.digitsOnly
//                          ],
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
//                          autofocus: true,
                          onSaved: (val) => goodsForm.Color = val,
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
                            labelText: 'Size',
                            hintText: "Enter Size",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
//                          autofocus: true,
                          onSaved: (val) => goodsForm.Size = val,
//                          inputFormatters: [
//                            WhitelistingTextInputFormatter.digitsOnly
//                          ],
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
                          onSaved: (val) => goodsForm.CostPerPrice = val,
                          validator: (dynamic value) {
                            if (value.isEmpty) {
                              return "Please enter cost price";
                            }
                            return null;
                          },
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
                              labelText: 'Retail Price',
                              hintText: "Enter Retail Price",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                          onSaved: (val) => goodsForm.RetailPrice = val,
//                          autofocus: true,
                          validator: (dynamic value) {
                            if (value.isEmpty) {
                              return "Please enter retail price";
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
                          onSaved: (val) => goodsForm.Quantity = val,
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
                              labelText: 'Inwarding Date ',
                              hintText: "Enter Inwarding Date ",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                          controller: _controller,
                          onTap: (() {
                            _chooseDate(context, _controller.text);
                          }),
                          onSaved: (val) => goodsForm.DateStock = val,
                        ),
                      )
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
                              labelText: 'Season',
                              hintText: "Enter Season",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                          onSaved: (val) => goodsForm.Season = val,
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
                            labelText: 'Margin (In %)',
                            hintText: "Enter Margin (In %)",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                          onSaved: (val) => goodsForm.Margin = val,
//                          inputFormatters: [
//                            WhitelistingTextInputFormatter.digitsOnly
//                          ],
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
                          onSaved: (val) => goodsForm.VAT = val,
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
                              labelText: 'Sat',
                              hintText: "Enter Sat",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                          onSaved: (val) => goodsForm.SAT = val,
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
//                          inputFormatters: [
//                            WhitelistingTextInputFormatter.digitsOnly
//                          ],
                          // decoration: InputDecoration(
                          //     contentPadding: EdgeInsets.all(10))
                          onSaved: (val) => goodsForm.Offer = val,
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
                              labelText: 'Brand Style Code',
                              hintText: "Enter Brand Style Code",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                          // decoration: InputDecoration(
                          //     contentPadding: EdgeInsets.all(10))
                          onSaved: (val) => goodsForm.BrandStyleCode = val,
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
                              labelText: 'Artical',
                              hintText: "Enter Artical",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                          onSaved: (val) => goodsForm.Artical = val,
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
                      SizedBox(
                        width: 5.0,
                      ),
//                      new Flexible(
//                        child: new TextFormField(
//                            decoration: InputDecoration(
//                                contentPadding:
//                                    EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                                filled: true,
//                                fillColor: Colors.white,
//                                labelText: '',
//                                hintText: "",
//                                border: OutlineInputBorder(
//                                    borderRadius: BorderRadius.circular(10.0)))
//                            // decoration: InputDecoration(
//                            //     contentPadding: EdgeInsets.all(10))
//                            ),
//                      ),
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
                          onSaved: (val) => goodsForm.Barcode = val,

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
                          child: new Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(30.0),
                        color: Color(0xffff6E40),
                        child: MaterialButton(
                          minWidth: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          onPressed: ()=> {
                            if(_formKey.currentState.validate()){
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
        ),
      ),
    );
  }
}
