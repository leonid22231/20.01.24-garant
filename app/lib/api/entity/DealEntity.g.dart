// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DealEntity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DealEntity _$DealEntityFromJson(Map<String, dynamic> json) => DealEntity(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      duration: json['duration'] as int,
      price: (json['price'] as num).toDouble(),
      type: json['type'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      file: json['file'] as String?,
      code: json['code'] as String,
      seller: json['seller'] == null
          ? null
          : UserEntity.fromJson(json['seller'] as Map<String, dynamic>),
      buyer: json['buyer'] == null
          ? null
          : UserEntity.fromJson(json['buyer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DealEntityToJson(DealEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'duration': instance.duration,
      'price': instance.price,
      'type': instance.type,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'file': instance.file,
      'code': instance.code,
      'seller': instance.seller,
      'buyer': instance.buyer,
    };
