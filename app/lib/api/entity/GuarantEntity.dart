import 'package:json_annotation/json_annotation.dart';

part 'GuarantEntity.g.dart';

@JsonSerializable()
class GuarantEntity{
  String id;
  String name;
  String surname;
  String patronymic;
  String identityCard;
  String phone;

  GuarantEntity(
      {required this.id,
        required this.name,
        required this.surname,
        required this.patronymic,
        required this.identityCard,
        required this.phone});

  factory GuarantEntity.fromJson(Map<String, dynamic> json) => _$GuarantEntityFromJson(json);
  Map<String, dynamic> toJson() => _$GuarantEntityToJson(this);
}