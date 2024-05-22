// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MessageEntityUser.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageEntityUser _$MessageEntityUserFromJson(Map<String, dynamic> json) =>
    MessageEntityUser(
      statusCode: json['statusCode'] as int,
      message: json['message'] as String,
      json: UserEntity.fromJson(json['json'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MessageEntityUserToJson(MessageEntityUser instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'json': instance.json,
    };
