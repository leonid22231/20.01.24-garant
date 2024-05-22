// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ParametersEntity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParametersEntity _$ParametersEntityFromJson(Map<String, dynamic> json) =>
    ParametersEntity(
      guarantor: json['guarantor'] == null
          ? null
          : GuarantEntity.fromJson(json['guarantor'] as Map<String, dynamic>),
      requisites:
          RequisitesEntity.fromJson(json['requisites'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ParametersEntityToJson(ParametersEntity instance) =>
    <String, dynamic>{
      'guarantor': instance.guarantor,
      'requisites': instance.requisites,
    };
