import 'package:json_annotation/json_annotation.dart';
part 'vendor_balance.g.dart';

@JsonSerializable()
class Vendor {
  String VendorId;
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
class BalanceVendorlist {
  List<Vendor> vendordata;

  BalanceVendorlist({this.vendordata});

  factory BalanceVendorlist.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['result'] as List;
    List<Vendor> vendorList = list.map((i) => Vendor.fromJson(i)).toList();
    return BalanceVendorlist(vendordata: vendorList);
  }
}

@JsonSerializable()
class VendorSearchBal {
  String invoiceNo;
  String vendorName;
  String balance;

  // int id;
  // int storeid;
  // String vendorCode;
  // String name;
  // String address;
  // String tin;
  // int city;
  // int state;
  // String contact;
  // String remarks;
  // int action;

  VendorSearchBal({this.invoiceNo, this.vendorName, this.balance
      // this.id,
      // this.storeid,
      // this.vendorCode,
      // this.name,
      // this.address,
      // this.tin,
      // this.city,
      // this.state,
      // this.contact,
      // this.remarks,
      // this.action
      });

  factory VendorSearchBal.fromJson(Map<String, dynamic> json) {
    return VendorSearchBal(
        invoiceNo: json['InvoiceNo'].toString(),
        vendorName: json['Vendor'],
        balance: json['balance']
        // id: json['id'],
        // storeid: json['storeid'],
        // vendorCode: json['vendorCode'],
        // name: json['name'],
        // address: json['address'],
        // tin: json['tin'],
        // city: json['city'],
        // state: json['state'],
        // contact: json['contact'],
        // remarks: json['remarks'],
        // action: json['action']
        );
  }
}

@JsonSerializable()
class VendorSearchBalList {
  List<VendorSearchBal> vendorSearchBal;

  VendorSearchBalList({this.vendorSearchBal});

  factory VendorSearchBalList.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson["result"] as List;
    List<VendorSearchBal> vendorSearchList =
        list.map((i) => VendorSearchBal.fromJson(i)).toList();
    return VendorSearchBalList(vendorSearchBal: vendorSearchList);
  }
}
