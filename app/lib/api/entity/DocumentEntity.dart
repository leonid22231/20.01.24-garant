import 'package:json_annotation/json_annotation.dart';
part 'DocumentEntity.g.dart';
@JsonSerializable()
class DocumentEntity{
  String id;
  String fileName;

  DocumentEntity({required this.id,required  this.fileName});

  factory DocumentEntity.fromJson(Map<String, dynamic> json) => _$DocumentEntityFromJson(json);
  Map<String, dynamic> toJson() => _$DocumentEntityToJson(this);
}