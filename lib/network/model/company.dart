import 'package:json_annotation/json_annotation.dart';
part 'company.g.dart';


@JsonSerializable()
class Company {
  String companyid;
  String companyname;


  Company({this.companyid, this.companyname});

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      companyid: json["companyid"],
      companyname: json["companyname"],
    );
  }

}

@JsonSerializable()
class Companylist {
  List<Company> companydata;

  Companylist({this.companydata});

  factory Companylist.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['result'] as List;
    List<Company> companyList = list.map((i) => Company.fromJson(i)).toList();
    return Companylist(companydata: companyList);
  }
}

@JsonSerializable()
class Usertype {
  String UserScope;


  Usertype({this.UserScope});

  factory Usertype.fromJson(Map<String, dynamic> json) {
    return Usertype(
      UserScope: json["UserScope"]
    );
  }

}

@JsonSerializable()
class Usertypelist {
  List<Usertype> usertypedata;

  Usertypelist({this.usertypedata});

  factory Usertypelist.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['result'] as List;
    List<Usertype> companyList = list.map((i) => Usertype.fromJson(i)).toList();
    return Usertypelist(usertypedata: companyList);
  }
}

@JsonSerializable()
class UserName {
  String UserId;
  String Email;


  UserName({this.UserId, this.Email});

  factory UserName.fromJson(Map<String, dynamic> json) {
    return UserName(
      UserId: json["UserId"],
      Email: json["Email"],
    );
  }

}

@JsonSerializable()
class UserNamelist {
  List<UserName> usernamedata;

  UserNamelist({this.usernamedata});

  factory UserNamelist.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['result'] as List;
    List<UserName> companyList = list.map((i) => UserName.fromJson(i)).toList();
    return UserNamelist(usernamedata: companyList);
  }
}