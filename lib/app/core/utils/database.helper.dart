import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const _databaseName = "DriverApp.db";
  static const _databaseVersion = 1;

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  late Database _database;

  Future<Database> get database async {
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE tokenTable (
            _id INTEGER PRIMARY KEY,
            accessToken TEXT NOT NULL,
            refreshToken TEXT NOT NULL
          )
          ''');
  }

  /// Get List of Tokens in tokenTable
  Future<List<Map<String, dynamic>>> queryTokenTable() async {
    Database db = await instance.database;
    return await db.query('tokenTable');
  }

  /// Get Current Row Count of tokenTable
  Future<dynamic> queryTokenTableRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM tokenTable'));
  }

  /// Update or Insert Data in tokenTable
  Future<int> upsertToken(Map<String, dynamic> row) async {
    Database db = await instance.database;

    final rowCount = await queryTokenTableRowCount();

    if (rowCount != 0) {
      final allRows = await db
          .rawQuery("SELECT * FROM tokenTable ORDER BY _id DESC LIMIT 1");
      row['_id'] = allRows.first['_id'];
      return updateToken(row);
    }

    return await db.insert('tokenTable', row);
  }

  /// Update Token in tokenTable
  Future<int> updateToken(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row['_id'];
    return await db
        .update('tokenTable', row, where: '_id = ?', whereArgs: [id]);
  }
}
