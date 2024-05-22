// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserEntity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEntity _$UserEntityFromJson(Map<String, dynamic> json) => UserEntity(
      id: json['id'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      surname: json['surname'] as String,
      patronymic: json['patronymic'] as String,
      userDate: DateTime.parse(json['userDate'] as String),
      identityCard: json['identityCard'] as String,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$UserEntityToJson(UserEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'phone': instance.phone,
      'email': instance.email,
      'name': instance.name,
      'surname': instance.surname,
      'patronymic': instance.patronymic,
      'userDate': instance.userDate.toIso8601String(),
      'identityCard': instance.identityCard,
      'image': instance.image,
    };
