import 'package:sqflite/sqflite.dart';

import '../../../mqtt/data/model/mqtt_model.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;

  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/mqtt.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  // MQTT model table
  static const String mqttConfigurationTable = 'tbl_mqtt_configuration';

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $mqttConfigurationTable (
        username TEXT PRIMARY KEY,
        password TEXT,
        host TEXT,
        port INTEGER
      )
    ''');
  }

  Future<bool> insert({required MqttModel model}) async {
    final db = await database;

    if (db == null) {
      return false;
    }

    try {
      await db.insert(
        mqttConfigurationTable,
        model.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return true;
    } catch (e) {
      print('Failed to insert: $e');
      return false;
    }
  }

  Future<Map<String, dynamic>> getDataByUsername({required String username}) async {
    final db = await database;

    final List<Map<String, dynamic>> result = await db!.query(
      mqttConfigurationTable,
      where: 'username = ?',
      whereArgs: [username],
    );

    if (result.isNotEmpty) {
      return result.first;
    } else {
      throw Exception('Username $username not found');
    }
  }

  Future<bool> deleteDataByUsername({required String username}) async {
    final db = await database;

    if (db == null) {
      return false;
    }

    try {
      await db.delete(
        mqttConfigurationTable,
        where: 'username = ?',
        whereArgs: [username],
      );
      return true;
    } catch (e) {
      print('Failed to delete: $e');
      return false;
    }
  }

}
