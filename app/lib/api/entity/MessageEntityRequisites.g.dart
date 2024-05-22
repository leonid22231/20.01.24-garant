// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MessageEntityRequisites.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageEntityRequisites _$MessageEntityRequisitesFromJson(
        Map<String, dynamic> json) =>
    MessageEntityRequisites(
      statusCode: json['statusCode'] as int,
      message: json['message'] as String,
      json: (json['json'] as List<dynamic>)
          .map((e) => RequisitesEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MessageEntityRequisitesToJson(
        MessageEntityRequisites instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'json': instance.json,
    };
