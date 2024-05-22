// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RequisitesEntity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequisitesEntity _$RequisitesEntityFromJson(Map<String, dynamic> json) =>
    RequisitesEntity(
      id: json['id'] as String?,
      bankName: json['bankName'] as String,
      cardNumber: json['cardNumber'] as String,
      bikNumber: json['bikNumber'] as String,
    );

Map<String, dynamic> _$RequisitesEntityToJson(RequisitesEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'bankName': instance.bankName,
      'cardNumber': instance.cardNumber,
      'bikNumber': instance.bikNumber,
    };
