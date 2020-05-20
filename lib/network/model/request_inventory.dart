import 'package:json_annotation/json_annotation.dart';
part 'request_inventory.g.dart';

@JsonSerializable()
class RequestListData {
  int Id;
  int PurchaseId;
  String Barcode;
  String ItemDesc;
  int subgroupid;
  int RequestedQty;
  double StockBal;
  int StoreId;
  String StoreName;
  String Status;
  String RequestDate;
  String ResponseDate;


  RequestListData({
        this.Id,
        this.PurchaseId,
        this.Barcode,
        this.ItemDesc,
        this.RequestedQty,
        this.Status,
        this.RequestDate,
        this.ResponseDate
      });

  factory RequestListData.fromJson(Map<String, dynamic> json) => _$RequestListDataFromJson(json);
  Map<String, dynamic> toJson() => _$RequestListDataToJson(this);
}

@JsonSerializable()
class Requestlist {
  List<RequestListData> RequestData;

  Requestlist({this.RequestData});

  factory Requestlist.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['Table'] as List;
    List<RequestListData> stockList = list.map((i) => RequestListData.fromJson(i)).toList();
    return Requestlist(RequestData: stockList);
  }
}