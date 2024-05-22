import 'package:app/api/entity/UserEntity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'DealEntity.g.dart';

@JsonSerializable()
class DealEntity{
  String id;
  String name;
  String description;
  int duration;
  double price;
  String type;
  DateTime startDate;
  DateTime? endDate;
  String? file;
  String code;
  UserEntity? seller;
  UserEntity? buyer;

  DealEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.duration,
    required this.price,
    required this.type,
    required this.startDate,
    this.endDate,
    this.file,
    required this.code,
    this.seller,
    this.buyer
});

  factory DealEntity.fromJson(Map<String, dynamic> json) => _$DealEntityFromJson(json);
  Map<String, dynamic> toJson() => _$DealEntityToJson(this);
}