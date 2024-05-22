import 'package:app/api/entity/DocumentEntity.dart';
import 'package:app/api/entity/GuarantEntity.dart';
import 'package:app/api/entity/RequisitesEntity.dart';
import 'package:app/api/entity/UserEntity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'CreditEntity.g.dart';

@JsonSerializable()
class CreditEntity {
  String id;
  double value;
  double percent;
  int duration;
  UserEntity? borrower;
  UserEntity? lender;
  String? number;
  GuarantEntity? guarant;
  DocumentEntity? doc;
  DateTime? startDate;
  String lastStatus;
  DateTime lastStatusTime;
  RequisitesEntity requisites;
  CreditEntity(
      {required this.id,
        required this.value,
        required this.percent,
        required this.duration,
        required this.lastStatus,
        required this.lastStatusTime,
        required this.requisites,
        required this.number,
        this.borrower,
        this.lender,
        this.guarant,
        this.doc,
        this.startDate});

  factory CreditEntity.fromJson(Map<String, dynamic> json) => _$CreditEntityFromJson(json);
  Map<String, dynamic> toJson() => _$CreditEntityToJson(this);
}