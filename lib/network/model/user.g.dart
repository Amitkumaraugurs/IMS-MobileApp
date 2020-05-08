// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Userlist _$UserlistFromJson(Map<String, dynamic> json) {
  return Userlist(
    userdata: (json['userdata'] as List)
        ?.map(
            (e) => e == null ? null : User.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$UserlistToJson(Userlist instance) => <String, dynamic>{
      'userdata': instance.userdata,
    };

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    Serial: json['Serial'] as String,
    Status: json['Status'] as String,
    StoreId: json['StoreId'] as String,
    StoreName: json['StoreName'] as String,
    UpdatedOn: json['UpdatedOn'] as String,
    CreatedOn: json['CreatedOn'] as String,
    UserId: json['UserId'] as String,
    UserPassword: json['UserPassword'] as String,
    UserScope: json['UserScope'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'Serial': instance.Serial,
      'Status': instance.Status,
      'StoreId': instance.StoreId,
      'StoreName': instance.StoreName,
      'UpdatedOn': instance.UpdatedOn,
      'CreatedOn': instance.CreatedOn,
      'UserId': instance.UserId,
      'UserPassword': instance.UserPassword,
      'UserScope': instance.UserScope,
    };
