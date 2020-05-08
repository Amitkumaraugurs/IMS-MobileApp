import 'package:json_annotation/json_annotation.dart';
part 'goods_model.g.dart';

@JsonSerializable()
class PurchaseListData {
  String BarCode;
  String ItemDesc;
  int Qty;
  int StockBal;
  String DateStock;
  String Offer;
  int SaleQty;

  PurchaseListData(
      {this.BarCode,
      this.ItemDesc,
      this.Qty,
      this.StockBal,
      this.DateStock,
      this.Offer,
      this.SaleQty});

  factory PurchaseListData.fromJson(Map<String, dynamic> json) => _$PurchaseListDataFromJson(json);
  Map<String, dynamic> toJson() => _$PurchaseListDataToJson(this);
}

@JsonSerializable()
class Purchaselist {
  List<PurchaseListData> purchasedata;

  Purchaselist({this.purchasedata});

  factory Purchaselist.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['Table'] as List;
    List<PurchaseListData> purchaseList =
        list.map((i) => PurchaseListData.fromJson(i)).toList();
    return Purchaselist(purchasedata: purchaseList);
  }
}

@JsonSerializable()
class Vendor {
  int VendorId;
  String VendorName;

  Vendor({this.VendorId, this.VendorName});

  factory Vendor.fromJson(Map<String, dynamic> json) {
    return Vendor(
      VendorId: json["VendorId"],
      VendorName: json["VendorName"],
    );
  }
}

@JsonSerializable()
class Vendorlist {
  List<Vendor> vendordata;

  Vendorlist({this.vendordata});

  factory Vendorlist.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['Table'] as List;
    List<Vendor> vendorList = list.map((i) => Vendor.fromJson(i)).toList();
    return Vendorlist(vendordata: vendorList);
  }
}

@JsonSerializable()
class Group {
  int GroupId;
  String GroupName;

  Group({this.GroupId, this.GroupName});

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(GroupId: json["GroupId"], GroupName: json["GroupName"]);
  }
}

@JsonSerializable()
class Grouplist {
  List<Group> groupData;

  Grouplist({this.groupData});

  factory Grouplist.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['Table'] as List;
    List<Group> groupList = list.map((i) => Group.fromJson(i)).toList();
    return Grouplist(groupData: groupList);
  }
}

@JsonSerializable()
class Category {
  int CatId;
  String CatName;
  int GroupId;

  Category({this.CatId, this.CatName, this.GroupId});

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}

@JsonSerializable()
class Categorylist {
  List<Category> catData;

  Categorylist({this.catData});

  factory Categorylist.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['Table'] as List;
    List<Category> catList = list.map((i) => Category.fromJson(i)).toList();
    return Categorylist(catData: catList);
  }
}

@JsonSerializable()
class SubCategory {
  int SubId;
  String SubName;
  int CatId;

  SubCategory({this.SubId, this.SubName, this.CatId});

  factory SubCategory.fromJson(Map<String, dynamic> json) =>
      _$SubCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$SubCategoryToJson(this);
}

@JsonSerializable()
class SubCategorylist {
  List<SubCategory> subcatData;

  SubCategorylist({this.subcatData});

  factory SubCategorylist.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['Table'] as List;
    List<SubCategory> subcatList =
        list.map((i) => SubCategory.fromJson(i)).toList();
    return SubCategorylist(subcatData: subcatList);
  }
}

//@JsonSerializable()
//class GoodsFormModel {
//  String VendorId = "";
//  String CatId = "";
//  String GroupId = "";
//  String SubGruopId = "";
//  String Barcode = "";
//
//  String Concept; String ItemDesc;String StyleNo;
//
//  String Color = "";
//  String Size = "";
//  String CostPerPrice = "";
//  String RetailPrice = "";
//  String Quantity = "";
//
//  String SaleQuantity;String StockBal;
//
//  String DateStock = "";
//  String Season = "";
//  String Margin = "";
//  String VAT = "";
//  String SAT = "";
//  String Offer = "";
//  String BrandStyleCode = "";
//
//  String StoreId;
//
//  String Transport = "";
//  String DocketNo = "";
//
//  String StockLife;String OutTransport; String OutDockectNo;
//
//  String Artical = "";
//  String Action = "";
//
//  GoodsFormModel({
//    this.VendorId,
//    this.CatId,
//    this.GroupId,
//    this.SubGruopId,
//    this.Barcode,
//
//    this.Concept, this.ItemDesc, this.StyleNo,
//
//    this.Color,
//    this.Size,
//    this.CostPerPrice,
//    this.RetailPrice,
//    this.Quantity,
//
//    this.SaleQuantity, this.StockBal,
//
//    this.DateStock,
//    this.Season,
//    this.Margin,
//    this.VAT,
//    this.SAT,
//    this.Offer,
//    this.BrandStyleCode,
//
//    this.StoreId,
//
//    this.Transport,
//    this.DocketNo,
//
//    this.StockLife, this.OutTransport, this.OutDockectNo,
//
//    this.Artical,
//    this.Action
//  });
//
//  factory GoodsFormModel.fromJson(Map<String, dynamic> json) => _$GoodsFormModelFromJson(json);
//  Map<String, dynamic> toJson() => _$GoodsFormModelToJson(this);
//}

@JsonSerializable()
class GoodsFormModelResultInstance {
  String Message;
  bool Status;

  GoodsFormModelResultInstance({this.Message, this.Status});

  factory GoodsFormModelResultInstance.fromJson(Map<String, dynamic> json) {
    return GoodsFormModelResultInstance(
      Message: json["Message"],
      Status: json["Status"],
    );
  }

//  factory GoodsFormModelResultInstance.fromJson(Map<String, dynamic> json) =>
//      _$GoodsFormModelResultInstanceFromJson(json);
//  Map<String, dynamic> toJson() => _$GoodsFormModelResultInstanceToJson(this);
}

@JsonSerializable()
class GoodsFormModelResponse {
  List<GoodsFormModelResultInstance> responseData;

  GoodsFormModelResponse({this.responseData});

  factory GoodsFormModelResponse.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson['Response']);
//    return parsedJson['Response'];
    var list = parsedJson['Response'] as List;
    List<GoodsFormModelResultInstance> res =
        list.map((i) => GoodsFormModelResultInstance.fromJson(i)).toList();
    print(res);
    return GoodsFormModelResponse(responseData: res);
  }
}
