// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GuarantEntity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GuarantEntity _$GuarantEntityFromJson(Map<String, dynamic> json) =>
    GuarantEntity(
      id: json['id'] as String,
      name: json['name'] as String,
      surname: json['surname'] as String,
      patronymic: json['patronymic'] as String,
      identityCard: json['identityCard'] as String,
      phone: json['phone'] as String,
    );

Map<String, dynamic> _$GuarantEntityToJson(GuarantEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'surname': instance.surname,
      'patronymic': instance.patronymic,
      'identityCard': instance.identityCard,
      'phone': instance.phone,
    };
