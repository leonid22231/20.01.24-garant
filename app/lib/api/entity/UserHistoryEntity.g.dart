// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserHistoryEntity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserHistoryEntity _$UserHistoryEntityFromJson(Map<String, dynamic> json) =>
    UserHistoryEntity(
      credits: (json['credits'] as List<dynamic>)
          .map((e) => CreditEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      deals: (json['deals'] as List<dynamic>)
          .map((e) => DealEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserHistoryEntityToJson(UserHistoryEntity instance) =>
    <String, dynamic>{
      'credits': instance.credits,
      'deals': instance.deals,
    };
