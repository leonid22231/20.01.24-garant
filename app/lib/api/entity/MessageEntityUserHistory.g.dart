// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MessageEntityUserHistory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageEntityUserHistory _$MessageEntityUserHistoryFromJson(
        Map<String, dynamic> json) =>
    MessageEntityUserHistory(
      statusCode: json['statusCode'] as int,
      message: json['message'] as String,
      json: UserHistoryEntity.fromJson(json['json'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MessageEntityUserHistoryToJson(
        MessageEntityUserHistory instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'json': instance.json,
    };
