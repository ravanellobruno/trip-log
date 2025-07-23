import 'db_ini.dart';
import '../models/place_model.dart';
import '../enums/place_type_enum.dart';

class PlacesTb {
  static Future<void> add(Place place) async {
    try {
      final db = await DbIni.database;
      await db.insert('places', place.toMap());
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<void> update(Place place) async {
    try {
      final db = await DbIni.database;
      final map = place.toMap();
      await db.update('places', map, where: 'id = ?', whereArgs: [place.id]);
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<List<Place>> getAllByType(PlaceTypeEnum type) async {
    try {
      final db = await DbIni.database;

      final maps = await db.query(
        'places',
        where: 'type = ?',
        whereArgs: [type.index],
      );

      return List.generate(maps.length, (i) => Place.fromMap(maps[i]));
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<void> delete(int id) async {
    try {
      final db = await DbIni.database;
      await db.delete('places', where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<Place?> getById(int id) async {
    try {
      final db = await DbIni.database;
      final maps = await db.query('places', where: 'id = ?', whereArgs: [id]);

      if (maps.isNotEmpty) {
        return Place.fromMap(maps.first);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
