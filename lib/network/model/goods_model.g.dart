// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goods_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PurchaseListData _$PurchaseListDataFromJson(Map<String, dynamic> json) {
  return PurchaseListData(
    BarCode: json['BarCode'] as String,
    ItemDesc: json['ItemDesc'] as String,
    Qty: json['Qty'] as int,
    StockBal: json['StockBal'] as int,
    DateStock: json['DateStock'] as String,
    Offer: json['Offer'] as String,
    SaleQty: json['SaleQty'] as int,
  );
}

Map<String, dynamic> _$PurchaseListDataToJson(PurchaseListData instance) =>
    <String, dynamic>{
      'BarCode': instance.BarCode,
      'ItemDesc': instance.ItemDesc,
      'Qty': instance.Qty,
      'StockBal': instance.StockBal,
      'DateStock': instance.DateStock,
      'Offer': instance.Offer,
      'SaleQty': instance.SaleQty,
    };

Purchaselist _$PurchaselistFromJson(Map<String, dynamic> json) {
  return Purchaselist(
    purchasedata: (json['purchasedata'] as List)
        ?.map((e) => e == null
            ? null
            : PurchaseListData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$PurchaselistToJson(Purchaselist instance) =>
    <String, dynamic>{
      'purchasedata': instance.purchasedata,
    };

Vendor _$VendorFromJson(Map<String, dynamic> json) {
  return Vendor(
    VendorId: json['VendorId'] as int,
    VendorName: json['VendorName'] as String,
  );
}

Map<String, dynamic> _$VendorToJson(Vendor instance) => <String, dynamic>{
      'VendorId': instance.VendorId,
      'VendorName': instance.VendorName,
    };

Vendorlist _$VendorlistFromJson(Map<String, dynamic> json) {
  return Vendorlist(
    vendordata: (json['vendordata'] as List)
        ?.map((e) =>
            e == null ? null : Vendor.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$VendorlistToJson(Vendorlist instance) =>
    <String, dynamic>{
      'vendordata': instance.vendordata,
    };

Group _$GroupFromJson(Map<String, dynamic> json) {
  return Group(
    GroupId: json['GroupId'] as int,
    GroupName: json['GroupName'] as String,
  );
}

Map<String, dynamic> _$GroupToJson(Group instance) => <String, dynamic>{
      'GroupId': instance.GroupId,
      'GroupName': instance.GroupName,
    };

Grouplist _$GrouplistFromJson(Map<String, dynamic> json) {
  return Grouplist(
    groupData: (json['groupData'] as List)
        ?.map(
            (e) => e == null ? null : Group.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$GrouplistToJson(Grouplist instance) => <String, dynamic>{
      'groupData': instance.groupData,
    };

Category _$CategoryFromJson(Map<String, dynamic> json) {
  return Category(
    CatId: json['CatId'] as int,
    CatName: json['CatName'] as String,
    GroupId: json['GroupId'] as int,
  );
}

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'CatId': instance.CatId,
      'CatName': instance.CatName,
      'GroupId': instance.GroupId,
    };

Categorylist _$CategorylistFromJson(Map<String, dynamic> json) {
  return Categorylist(
    catData: (json['catData'] as List)
        ?.map((e) =>
            e == null ? null : Category.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CategorylistToJson(Categorylist instance) =>
    <String, dynamic>{
      'catData': instance.catData,
    };

SubCategory _$SubCategoryFromJson(Map<String, dynamic> json) {
  return SubCategory(
    SubId: json['SubId'] as int,
    SubName: json['SubName'] as String,
    CatId: json['CatId'] as int,
  );
}

Map<String, dynamic> _$SubCategoryToJson(SubCategory instance) =>
    <String, dynamic>{
      'SubId': instance.SubId,
      'SubName': instance.SubName,
      'CatId': instance.CatId,
    };

SubCategorylist _$SubCategorylistFromJson(Map<String, dynamic> json) {
  return SubCategorylist(
    subcatData: (json['subcatData'] as List)
        ?.map((e) =>
            e == null ? null : SubCategory.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SubCategorylistToJson(SubCategorylist instance) =>
    <String, dynamic>{
      'subcatData': instance.subcatData,
    };

Season _$SeasonFromJson(Map<String, dynamic> json) {
  return Season(
    Id: json['Id'] as int,
    SeasonName: json['SeasonName'] as String,
    CreatedOn: json['CreatedOn'] as String,
    Status: json['Status'] as bool,
  );
}

Map<String, dynamic> _$SeasonToJson(Season instance) => <String, dynamic>{
      'Id': instance.Id,
      'SeasonName': instance.SeasonName,
      'CreatedOn': instance.CreatedOn,
      'Status': instance.Status,
    };

SeasonList _$SeasonListFromJson(Map<String, dynamic> json) {
  return SeasonList(
    seasonData: (json['seasonData'] as List)
        ?.map((e) =>
            e == null ? null : Season.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SeasonListToJson(SeasonList instance) =>
    <String, dynamic>{
      'seasonData': instance.seasonData,
    };

GoodsFormModelResultInstance _$GoodsFormModelResultInstanceFromJson(
    Map<String, dynamic> json) {
  return GoodsFormModelResultInstance(
    Message: json['Message'] as String,
    Status: json['Status'] as bool,
  );
}

Map<String, dynamic> _$GoodsFormModelResultInstanceToJson(
        GoodsFormModelResultInstance instance) =>
    <String, dynamic>{
      'Message': instance.Message,
      'Status': instance.Status,
    };

GoodsFormModelResponse _$GoodsFormModelResponseFromJson(
    Map<String, dynamic> json) {
  return GoodsFormModelResponse(
    responseData: (json['responseData'] as List)
        ?.map((e) => e == null
            ? null
            : GoodsFormModelResultInstance.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$GoodsFormModelResponseToJson(
        GoodsFormModelResponse instance) =>
    <String, dynamic>{
      'responseData': instance.responseData,
    };
