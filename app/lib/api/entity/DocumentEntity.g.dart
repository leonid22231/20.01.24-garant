// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DocumentEntity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentEntity _$DocumentEntityFromJson(Map<String, dynamic> json) =>
    DocumentEntity(
      id: json['id'] as String,
      fileName: json['fileName'] as String,
    );

Map<String, dynamic> _$DocumentEntityToJson(DocumentEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fileName': instance.fileName,
    };
