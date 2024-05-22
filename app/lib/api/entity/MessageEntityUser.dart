import 'package:app/api/entity/MessageEntity.dart';
import 'package:app/api/entity/UserEntity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'MessageEntityUser.g.dart';
@JsonSerializable()
class MessageEntityUser extends MessageEntity{
  UserEntity json;

  MessageEntityUser({required super.statusCode, required super.message, required this.json});

  factory MessageEntityUser.fromJson(Map<String, dynamic> json) => _$MessageEntityUserFromJson(json);
  Map<String, dynamic> toJson() => _$MessageEntityUserToJson(this);
}