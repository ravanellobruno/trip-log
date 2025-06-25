import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/place_model.dart';

class PlacesTb {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) {
      return _db!;
    }

    _db = await initDb();

    return _db!;
  }

  static Future<Database> initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'trip_log.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE places (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            base64Img TEXT,
            name TEXT NOT NULL,
            description TEXT,
            type INTEGER
          )
        ''');
      },
    );
  }

  static Future<void> add(Place place) async {
    try {
      final db = await database;
      await db.insert('places', place.toMap());
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<void> update(Place place) async {
    try {
      final db = await database;
      final map = place.toMap();
      await db.update('places', map, where: 'id = ?', whereArgs: [place.id]);
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<List<Place>> getAll() async {
    try {
      final db = await database;
      final maps = await db.query('places');

      return List.generate(maps.length, (i) => Place.fromMap(maps[i]));
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<void> delete(int id) async {
    try {
      final db = await database;
      await db.delete('places', where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<Place?> getById(int id) async {
    try {
      final db = await database;
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
