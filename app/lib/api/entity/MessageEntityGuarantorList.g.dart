// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MessageEntityGuarantorList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageEntityGuarantorList _$MessageEntityGuarantorListFromJson(
        Map<String, dynamic> json) =>
    MessageEntityGuarantorList(
      statusCode: json['statusCode'] as int,
      message: json['message'] as String,
      json: (json['json'] as List<dynamic>)
          .map((e) => GuarantEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MessageEntityGuarantorListToJson(
        MessageEntityGuarantorList instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'json': instance.json,
    };
