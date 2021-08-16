import 'package:flutter/material.dart';
import 'package:flutter_heart/models/TestPulse.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:sqflite/sqflite.dart';
import 'dart:async';

final String tablePulse = 'pulse';

final String columnId = '_id';
final String columnDate = "date";
final String columnMetric = "metric";
final String columnSmile = 'image';

class DatabaseProvider with ChangeNotifier {
  late Database _db;
  static final DatabaseProvider _provider = DatabaseProvider._internal();
  bool _isOpen = false;

  factory DatabaseProvider() {
    return _provider;
  }

  DatabaseProvider._internal() {
    open();
  }

  get isOpen => _isOpen;

  Future open() async {
    final dbPath = await getDatabasesPath();
    _db = await openDatabase("$dbPath/test123.db", version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
create table $tablePulse ( 
  $columnId integer primary key autoincrement,
  $columnSmile integer, 
  $columnMetric integer not null,
  $columnDate integer not null)
''');
    });

    // To-Do remove
    new Future.delayed(const Duration(seconds: 5), () {
      _isOpen = true;
      notifyListeners();
    });
  }

  Future<int> insert(TestPulse pulse) async {
    int id = await _db.insert(tablePulse, pulse.toMap());
    return id;
  }

  Future<TestPulse?> getRecord(int id) async {
    List<Map> maps = await _db.query(tablePulse,
        columns: [columnId, columnDate, columnMetric, columnSmile],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      TestPulse pulse = TestPulse.fromJson(maps.first);
      return pulse;
    }
    return null;
  }

  Future<List<TestPulse>> getAllRecords() async {
    List<TestPulse> recipes = (await _db.query(tablePulse)).map((item) {
      TestPulse recipe = TestPulse.fromJson(item);
      return recipe;
    }).toList();

    return recipes;
  }

  Future<int> delete(int id) async {
    return await _db
        .delete(tablePulse, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(TestPulse recipes) async {
    return await _db.update(tablePulse, recipes.toMap(),
        where: '$columnId = ?', whereArgs: [recipes.id]);
  }

  Future close() async => _db.close();
}
