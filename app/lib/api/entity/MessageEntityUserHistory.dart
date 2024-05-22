import 'package:app/api/entity/MessageEntity.dart';
import 'package:app/api/entity/UserHistoryEntity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'MessageEntityUserHistory.g.dart';
@JsonSerializable()
class MessageEntityUserHistory extends MessageEntity{
  UserHistoryEntity json;

  MessageEntityUserHistory({required super.statusCode, required super.message, required this.json});

  factory MessageEntityUserHistory.fromJson(Map<String, dynamic> json) => _$MessageEntityUserHistoryFromJson(json);
  Map<String, dynamic> toJson() => _$MessageEntityUserHistoryToJson(this);

}