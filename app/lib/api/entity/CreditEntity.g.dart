// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CreditEntity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreditEntity _$CreditEntityFromJson(Map<String, dynamic> json) => CreditEntity(
      id: json['id'] as String,
      value: (json['value'] as num).toDouble(),
      percent: (json['percent'] as num).toDouble(),
      duration: json['duration'] as int,
      lastStatus: json['lastStatus'] as String,
      lastStatusTime: DateTime.parse(json['lastStatusTime'] as String),
      requisites:
          RequisitesEntity.fromJson(json['requisites'] as Map<String, dynamic>),
      number: json['number'] as String?,
      borrower: json['borrower'] == null
          ? null
          : UserEntity.fromJson(json['borrower'] as Map<String, dynamic>),
      lender: json['lender'] == null
          ? null
          : UserEntity.fromJson(json['lender'] as Map<String, dynamic>),
      guarant: json['guarant'] == null
          ? null
          : GuarantEntity.fromJson(json['guarant'] as Map<String, dynamic>),
      doc: json['doc'] == null
          ? null
          : DocumentEntity.fromJson(json['doc'] as Map<String, dynamic>),
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
    );

Map<String, dynamic> _$CreditEntityToJson(CreditEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'value': instance.value,
      'percent': instance.percent,
      'duration': instance.duration,
      'borrower': instance.borrower,
      'lender': instance.lender,
      'number': instance.number,
      'guarant': instance.guarant,
      'doc': instance.doc,
      'startDate': instance.startDate?.toIso8601String(),
      'lastStatus': instance.lastStatus,
      'lastStatusTime': instance.lastStatusTime.toIso8601String(),
      'requisites': instance.requisites,
    };
