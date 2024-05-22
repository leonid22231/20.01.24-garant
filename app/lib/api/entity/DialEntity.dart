import 'package:app/api/entity/CreditEntity.dart';
import 'package:image_picker/image_picker.dart';

class DialEntity{
  String? id;
  String name;
  String description;
  XFile? file;
  String type;
  String? seller;
  String? buyer;
  int duration;
  DialEntity({
 this.id,
    required this.name,
    required this.description,
    required this.type,
    this.file,
    this.buyer,
    this.seller,
    required this.duration,
  });
}