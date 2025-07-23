import '../models/place_model.dart';
import '../enums/place_type_enum.dart';
import '../db/places_tb.dart';

class PlacesRepo {
  static Future<void> add(Place place) async {
    place.type = PlaceTypeEnum.unvisited;
    await PlacesTb.add(place);
  }

  static Future<void> update(Place place) async {
    await PlacesTb.update(place);
  }

  static Future<void> move(PlaceTypeEnum to, Place place) async {
    place.type = to;
    await PlacesTb.update(place);
  }

  static Future<List<Place>> getAllByType(PlaceTypeEnum type) async {
    return await PlacesTb.getAllByType(type);
  }

  static Future<void> delete(int id) async {
    await PlacesTb.delete(id);
  }

  static Future<Place?> getById(int id) async {
    return await PlacesTb.getById(id);
  }
}
