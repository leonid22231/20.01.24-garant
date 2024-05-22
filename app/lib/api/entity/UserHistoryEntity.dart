import 'package:app/api/entity/CreditEntity.dart';
import 'package:app/api/entity/DealEntity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'UserHistoryEntity.g.dart';
@JsonSerializable()
class UserHistoryEntity{
  List<CreditEntity> credits;
  List<DealEntity> deals;

  UserHistoryEntity({
    required this.credits,
    required this.deals
});

  factory UserHistoryEntity.fromJson(Map<String, dynamic> json) => _$UserHistoryEntityFromJson(json);
  Map<String, dynamic> toJson() => _$UserHistoryEntityToJson(this);
}