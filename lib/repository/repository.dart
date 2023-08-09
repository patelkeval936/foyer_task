// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:foyer/model/device_profile_settings.dart';

class Repository {

  static late Database db;

  Future<void> openDB() async {
    db = await openDatabase(
      join(await getDatabasesPath(), 'profiles.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE profiles(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, latitude TEXT,longitude TEXT,themeColor TEXT,fontSize REAL)',
        );
      },
      version: 1
    );
  }

  Future<List<DeviceProfileSettings>> getProfiles() async {
    final List<Map<String, dynamic>> maps = await db.query('profiles');
    List<DeviceProfileSettings> deviceProfiles = List.generate(maps.length, (i) {
      return DeviceProfileSettings.fromJson(maps[i]);
    });
    return deviceProfiles;
  }

  Future<void> addProfile(DeviceProfileSettings profileSettings) async {
    await db.insert(
      'profiles',
      profileSettings.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateProfiles(DeviceProfileSettings profileSettings,int id) async {
     await db.update(
      'profiles',
      profileSettings.toJson(),
      where: 'id = ?',
      whereArgs: [id],
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  Future<void> deleteProfile(int id) async {
    await db.delete(
      'profiles',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

}
