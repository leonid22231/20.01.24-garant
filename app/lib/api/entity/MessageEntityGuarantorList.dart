import 'package:app/api/entity/GuarantEntity.dart';
import 'package:app/api/entity/MessageEntity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'MessageEntityGuarantorList.g.dart';

@JsonSerializable()
class MessageEntityGuarantorList extends MessageEntity{
  List<GuarantEntity> json;

  MessageEntityGuarantorList({required super.statusCode, required super.message, required this.json});

  factory MessageEntityGuarantorList.fromJson(Map<String, dynamic> json) => _$MessageEntityGuarantorListFromJson(json);
  Map<String, dynamic> toJson() => _$MessageEntityGuarantorListToJson(this);
}