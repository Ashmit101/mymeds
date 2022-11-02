import 'package:sqflite/sqflite.dart';

import '../models/activity.dart';
import '../models/medicine.dart';

class DBHelper {
  static Database? _db;
  static const int _version = 1;
  static const String _tableName = 'items';

  static Future<void> initDb() async {
    if (_db != null) {
      return;
    }
    try {
      String path = '${await getDatabasesPath()}items.db';
      _db =
          await openDatabase(path, version: _version, onCreate: (db, version) {
        print('Creating a new database');

        var sqlCreate = "CREATE TABLE $_tableName("
            "id INTEGER PRIMARY KEY AUTOINCREMENT, "
            "title STRING, note TEXT, date STRING, "
            "meal INTEGER, sequence INTEGER, dose INTEGER,"
            "time STRING, type INTEGER)";

        return db.execute(sqlCreate);

      });
    } catch (e) {
      print(e);
    }
  }

  static Future<int?> insertMedicine(Medicine? medicine) async {
    print("Insert function called");
    print(medicine!.toJson().toString());
    int? id = await _db?.insert(_tableName, medicine.toJson()) ?? -1;
    print('Stored in row id: $id');
    return id;
  }

  static Future<int?> insertActivity(Activity? activity) async {
    print("Insert function called");
    print(activity!.toJson().toString());
    int? id = await _db?.insert(_tableName, activity.toJson()) ?? -1;
    print('Stored in row id: $id');
    return id;
  }


  static Future<List<Map<String, dynamic>>> readAllMedicines() async {
    final result = await _db?.query(_tableName, where: '"type" = ?', whereArgs: ['1']);
    return result as List<Map<String, dynamic>>;
  }

  static Future<List<Map<String, dynamic>>> readAllActivities() async {
    final result = await _db?.query(_tableName, where: '"type" = ?', whereArgs: ['2']);
    return result as List<Map<String, dynamic>>;
  }
}
