import 'package:json_annotation/json_annotation.dart';
part 'store.g.dart';


@JsonSerializable()
class Store {
  int storeId;
  String storeName;

  Store({this.storeId, this.storeName});

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      storeId: json["Id"],
      storeName: json["StoreName"],
    );
  }
}

@JsonSerializable()
class Storelist {
  List<Store> storedata;

  Storelist({this.storedata});

  factory Storelist.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['Table'] as List;
    List<Store> vendorList = list.map((i) => Store.fromJson(i)).toList();
    return Storelist(storedata: vendorList);
  }


}