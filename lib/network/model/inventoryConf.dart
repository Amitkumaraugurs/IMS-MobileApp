import 'package:json_annotation/json_annotation.dart';
part 'inventoryConf.g.dart';

@JsonSerializable()
class InventoryListData {
  int Id;
  int PurchaseId;
  String Barcode;
  String ItemDesc;
  String RequestedQty;
  int IssuedQty;
  String AvailavleQty;
  String FromStoreId;
  String ToStoreId;
  String ToStore;
  String FromStore;
  String Status;
  String RequestDate;
  String ResponseDate;


  InventoryListData({
        this.Id,
        this.PurchaseId,
        this.Barcode,
        this.ItemDesc,
        this.RequestedQty,
        this.IssuedQty,
        this.AvailavleQty,
        this.FromStoreId,
        this.ToStoreId,
        this.ToStore,
        this.FromStore,
        this.Status,
        this.RequestDate,
        this.ResponseDate
      });

  factory InventoryListData.fromJson(Map<String, dynamic> json) => _$InventoryListDataFromJson(json);
  Map<String, dynamic> toJson() => _$InventoryListDataToJson(this);
}

@JsonSerializable()
class Inventorylist {
  List<InventoryListData> inventoryData;

  Inventorylist({this.inventoryData});

  factory Inventorylist.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['Table'] as List;
    List<InventoryListData> stockList = list.map((i) => InventoryListData.fromJson(i)).toList();
    return Inventorylist(inventoryData: stockList);
  }
}