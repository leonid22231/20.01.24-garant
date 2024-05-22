import 'package:json_annotation/json_annotation.dart';

part 'MessageEntity.g.dart';

@JsonSerializable()
class MessageEntity{
  int statusCode;
  String message;

  MessageEntity({required this.statusCode,required this.message});

  factory MessageEntity.fromJson(Map<String, dynamic> json) => _$MessageEntityFromJson(json);

  Map<String, dynamic> toJson() => _$MessageEntityToJson(this);
}