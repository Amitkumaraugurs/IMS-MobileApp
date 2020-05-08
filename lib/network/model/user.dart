import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class Userlist{

List<User> userdata;


Userlist({this.userdata});

  factory Userlist.fromJson(Map<String, dynamic> parsedJson){

    var list = parsedJson['Table'] as List;
    print(list.runtimeType);
    List<User> userList = list.map((i) => User.fromJson(i)).toList();

    return Userlist(
        userdata: userList

    );
  }

}

@JsonSerializable()
class User {
  String Serial;
  String Status;
  String StoreId;
  String StoreName;
  String UpdatedOn;
  String CreatedOn;
  String UserId;
  String UserPassword;
  String UserScope;

  User({this.Serial,this.Status,this.StoreId,this.StoreName,this.UpdatedOn,this.CreatedOn,this.UserId,this.UserPassword,this.UserScope });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  /*factory Userlist.fromJson(Map<String, dynamic> json) {
    return Userlist(
      Serial: json['Serial'],
      Status: json['Status'],
      StoreId: json['StoreId'],
      StoreName: json['StoreName'],
      UpdatedOn: json['UpdatedOn'],
      CreatedOn: json['CreatedOn'],
      UserId: json['UserId'],
      UserPassword: json['UserPassword'],
      UserScope: json['UserScope']
    );
  }*/
}