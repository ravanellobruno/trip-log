enum PlaceTypeEnum { unvisited, visited }

extension PlaceTypeEnumExtension on PlaceTypeEnum {
  String get value {
    switch (this) {
      case PlaceTypeEnum.unvisited:
        return 'u';
      case PlaceTypeEnum.visited:
        return 'v';
    }
  }
}
