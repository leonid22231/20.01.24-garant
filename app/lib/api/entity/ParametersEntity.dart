import 'package:app/api/entity/GuarantEntity.dart';
import 'package:app/api/entity/RequisitesEntity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ParametersEntity.g.dart';
@JsonSerializable()
class ParametersEntity{
  GuarantEntity? guarantor;
  RequisitesEntity requisites;

  ParametersEntity({this.guarantor,required this.requisites});

  factory ParametersEntity.fromJson(Map<String, dynamic> json) => _$ParametersEntityFromJson(json);
  Map<String, dynamic> toJson() => _$ParametersEntityToJson(this);
}