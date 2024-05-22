// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MessageEntityRegister.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageEntityRegister _$MessageEntityRegisterFromJson(
        Map<String, dynamic> json) =>
    MessageEntityRegister(
      statusCode: json['statusCode'] as int,
      message: json['message'] as String,
      json: json['json'] as String?,
    );

Map<String, dynamic> _$MessageEntityRegisterToJson(
        MessageEntityRegister instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'json': instance.json,
    };
