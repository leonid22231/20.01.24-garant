import 'package:app/api/entity/CreditEntity.dart';
import 'package:json_annotation/json_annotation.dart';

import 'MessageEntity.dart';

part 'MessageEntityCreditList.g.dart';

@JsonSerializable()
class MessageEntityCreditList extends MessageEntity{
  List<CreditEntity> json;

  MessageEntityCreditList({required super.statusCode, required super.message, required this.json});

  factory MessageEntityCreditList.fromJson(Map<String, dynamic> json) => _$MessageEntityCreditListFromJson(json);
  Map<String, dynamic> toJson() => _$MessageEntityCreditListToJson(this);
}