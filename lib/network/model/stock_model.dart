import 'package:json_annotation/json_annotation.dart';
part 'stock_model.g.dart';


//@JsonSerializable()
//class StockFormModelResultInstance {
//  String Message;
//  bool Status;
//
//  StockFormModelResultInstance({this.Message, this.Status});
//
//  factory StockFormModelResultInstance.fromJson(Map<String, dynamic> json) {
//    return StockFormModelResultInstance(
//      Message: json["Message"],
//      Status: json["Status"],
//    );
//  }
//}
//
//@JsonSerializable()
//class StockFormModelResponse {
//  List<StockFormModelResultInstance> responseData;
//
//  StockFormModelResponse({this.responseData});
//
//  factory StockFormModelResponse.fromJson(Map<String, dynamic> parsedJson) {
//    var list = parsedJson['Response'] as List;
//    List<StockFormModelResultInstance> res =
//    list.map((i) => StockFormModelResultInstance.fromJson(i)).toList();
//    print(res);
//    return StockFormModelResponse(responseData: res);
//  }
//}


@JsonSerializable()
class StockListData {
  int Id;
  String Qty;
  String Article;
//  int StockBal;
  String Barcode;
  String ItemDesc;
  String StyleNo;
  String Color;
  String Size;
  double CostPerPrice;
  String GroupName;
  String Category;
  String Subcategory;
  double RetailPrice;
  double Margin;
  double VAT;
  double SAT;
  double Discount;
  String BrandStyleCode;
  String CreatedOn;
  bool Status;
  int CatId;
  int GroupId;
  int SubGroupId;


  StockListData({
        this.Id,
        this.Qty,
        this.Article,
//        this.StockBal,
        this.Barcode,
        this.ItemDesc,
        this.StyleNo,
        this.Color,
        this.Size,
        this.CostPerPrice,
        this.GroupName,
        this.Category,
        this.Subcategory,
        this.RetailPrice,
        this.Margin,
        this.VAT,
        this.SAT,
        this.Discount,
        this.BrandStyleCode,
        this.CreatedOn,
        this.Status,
        this.CatId,
        this.GroupId,
        this.SubGroupId
      });

  factory StockListData.fromJson(Map<String, dynamic> json) => _$StockListDataFromJson(json);
  Map<String, dynamic> toJson() => _$StockListDataToJson(this);
}

@JsonSerializable()
class Stocklist {
  List<StockListData> stockData;

  Stocklist({this.stockData});

  factory Stocklist.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['Table'] as List;
    List<StockListData> stockList = list.map((i) => StockListData.fromJson(i)).toList();
    return Stocklist(stockData: stockList);
  }
}