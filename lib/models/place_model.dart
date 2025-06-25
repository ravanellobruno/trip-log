import '../enums/place_type_enum.dart';

class Place {
  int? id;
  String name;
  String? description;
  String? base64Img;
  PlaceTypeEnum? type;

  Place({
    this.id,
    required this.name,
    this.description,
    this.base64Img,
    this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'base64Img': base64Img,
      'name': name,
      'description': description!.trim().isEmpty ? null : description,
      'type': type!.index,
    };
  }

  factory Place.fromMap(Map<String, dynamic> map) {
    return Place(
      id: map['id'],
      base64Img: map['base64Img'],
      name: map['name'],
      description: map['description'] ?? '',
      type: PlaceTypeEnum.values[map['type']],
    );
  }
}
