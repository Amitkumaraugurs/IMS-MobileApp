import 'package:json_annotation/json_annotation.dart';
part 'store_stock_balance.g.dart';

@JsonSerializable()
class StoreStock {
  String id;
  String storeName;

  StoreStock({this.id, this.storeName});

  factory StoreStock.fromJson(Map<String, dynamic> json) {
    return StoreStock(
      id: json["Id"],
      storeName: json["StoreName"],
    );
  }
}

@JsonSerializable()
class StoreStocklist {
  List<StoreStock> storeStockdata;

  StoreStocklist({this.storeStockdata});

  factory StoreStocklist.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['result'] as List;
    List<StoreStock> storeStockList =
        list.map((i) => StoreStock.fromJson(i)).toList();
    return StoreStocklist(storeStockdata: storeStockList);
  }
}

@JsonSerializable()
class StoreStockBal {
  String id;
  String storeId;
  String issueQty;
  String masterQty;
  String soldQty;
  String damageQty;
  String returnQtyToStock;
  String barcode;
  String receivedOn;
  String isReceived;

  StoreStockBal(
      {this.id,
      this.storeId,
      this.issueQty,
      this.masterQty,
      this.soldQty,
      this.damageQty,
      this.returnQtyToStock,
      this.barcode,
      this.receivedOn,
      this.isReceived});

  factory StoreStockBal.fromJson(Map<String, dynamic> json) {
    return StoreStockBal(
      id: json["Id"],
      storeId: json["StoreId"],
      issueQty: json["IssueQty"],
      masterQty: json["MasterQty"],
      soldQty: json["SoldQty"],
      damageQty: json["DamageQty"],
      returnQtyToStock: json["ReturnQtyToStock"],
      barcode: json["Barcode"],
      receivedOn: json["ReceivedOn"],
      isReceived: json["IsReceived"],
    );
  }
}

@JsonSerializable()
class StoreStockBalList {
  List<StoreStockBal> storeStockBaldata;

  StoreStockBalList({this.storeStockBaldata});

  factory StoreStockBalList.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['result'] as List;
    List<StoreStockBal> storeStockBal =
        list.map((i) => StoreStockBal.fromJson(i)).toList();
    return StoreStockBalList(storeStockBaldata: storeStockBal);
  }
}
