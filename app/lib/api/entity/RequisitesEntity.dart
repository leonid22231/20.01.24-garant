import 'package:json_annotation/json_annotation.dart';

part 'RequisitesEntity.g.dart';
@JsonSerializable()
class RequisitesEntity{
  String? id;
  String bankName;
  String cardNumber;
  String bikNumber;

  RequisitesEntity({this.id,required this.bankName,required this.cardNumber,required this.bikNumber});

  factory RequisitesEntity.fromJson(Map<String, dynamic> json) => _$RequisitesEntityFromJson(json);
  Map<String, dynamic> toJson() => _$RequisitesEntityToJson(this);
}