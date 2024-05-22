import 'package:json_annotation/json_annotation.dart';

part 'UserEntity.g.dart';

@JsonSerializable()
class UserEntity {
  String id;
  String phone;
  String email;
  String name;
  String surname;
  String patronymic;
  DateTime userDate;
  String identityCard;
  String? image;

  UserEntity(
      {required this.id,
        required this.phone,
        required this.email,
        required this.name,
        required this.surname,
        required this.patronymic,
        required this.userDate,
        required this.identityCard,
        this.image});

  factory UserEntity.fromJson(Map<String, dynamic> json) => _$UserEntityFromJson(json);
  Map<String, dynamic> toJson() => _$UserEntityToJson(this);
}