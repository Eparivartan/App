import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = "localdatabse.db";

  static Future<Database> _getDB() async {
    return openDatabase(
      join(await getDatabasesPath(), _dbName),
      onCreate: (db, version) async => await db.execute(
        "CREATE TABLE RECENT_ACTIVITY("
        "VIEWED_TAB STRING NOT NULL"
        ");",
      ),
      version: _version,
    );
  }

  static Future addData(Map<String, dynamic> data) async {
    final db = await _getDB();
    return await db.insert("RECENT_ACTIVITY", data,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future updateData(Map<String, dynamic> data) async {
    final db = await _getDB();
    return await db.update("RECENT_ACTIVITY", data,
        where: 'VIEWED_TAB != ""',
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future deleteData() async {
    final db = await _getDB();
    return await db.delete(
      "RECENT_ACTIVITY",
      where: 'VIEWED_TAB != ""',
    );
  }

  static Future<List<Map<String, dynamic>>?> getAllData() async {
    final db = await _getDB();
    return await db.query("RECENT_ACTIVITY");
  }
}
