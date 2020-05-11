// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Store _$StoreFromJson(Map<String, dynamic> json) {
  return Store(
    storeId: json['storeId'] as int,
    storeName: json['storeName'] as String,
  );
}

Map<String, dynamic> _$StoreToJson(Store instance) => <String, dynamic>{
      'storeId': instance.storeId,
      'storeName': instance.storeName,
    };

Storelist _$StorelistFromJson(Map<String, dynamic> json) {
  return Storelist(
    storedata: (json['storedata'] as List)
        ?.map(
            (e) => e == null ? null : Store.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$StorelistToJson(Storelist instance) => <String, dynamic>{
      'storedata': instance.storedata,
    };
