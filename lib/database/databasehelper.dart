import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'user_data.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE users(username TEXT PRIMARY KEY, value INTEGER)",
        );
      },
      version: 1,
    );
  }

  Future<void> insertUser(String username, int value) async {
    final db = await database;
    try {
      await db.insert(
        'users',
        {'username': username, 'value': value},
        conflictAlgorithm: ConflictAlgorithm.fail,
      );
    } catch (e) {}
  }

  Future<Map<String, dynamic>?> getUser(String username) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: "username = ?",
      whereArgs: [username],
    );
    if (maps.isNotEmpty) {
      return maps.first;
    }

    return null;
  }

  Future<void> updateValue(String username, int value) async {
    final db = await database;
    try {
      await db.update(
        'users',
        {'value': value},
        where: "username = ?",
        whereArgs: [username],
      );
    } catch (e) {}
  }
}
