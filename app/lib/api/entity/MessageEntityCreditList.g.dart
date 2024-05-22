// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MessageEntityCreditList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageEntityCreditList _$MessageEntityCreditListFromJson(
        Map<String, dynamic> json) =>
    MessageEntityCreditList(
      statusCode: json['statusCode'] as int,
      message: json['message'] as String,
      json: (json['json'] as List<dynamic>)
          .map((e) => CreditEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MessageEntityCreditListToJson(
        MessageEntityCreditList instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'json': instance.json,
    };
