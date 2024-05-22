import 'package:app/api/entity/MessageEntity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'MessageEntityRegister.g.dart';

@JsonSerializable()
class MessageEntityRegister extends MessageEntity{
  String? json;

  MessageEntityRegister({required super.statusCode, required super.message, required this.json});

  factory MessageEntityRegister.fromJson(Map<String, dynamic> json) => _$MessageEntityRegisterFromJson(json);
  Map<String, dynamic> toJson() => _$MessageEntityRegisterToJson(this);
}