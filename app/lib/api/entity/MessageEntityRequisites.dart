import 'package:app/api/entity/MessageEntity.dart';
import 'package:app/api/entity/RequisitesEntity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'MessageEntityRequisites.g.dart';
@JsonSerializable()
class MessageEntityRequisites extends MessageEntity{
  List<RequisitesEntity> json;

  MessageEntityRequisites({required super.statusCode, required super.message, required this.json});

  factory MessageEntityRequisites.fromJson(Map<String, dynamic> json) => _$MessageEntityRequisitesFromJson(json);
  Map<String, dynamic> toJson() => _$MessageEntityRequisitesToJson(this);
}