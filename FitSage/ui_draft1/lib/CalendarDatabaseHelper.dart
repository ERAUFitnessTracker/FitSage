// ignore_for_file: file_names, depend_on_referenced_packages

import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'event.dart';

class CalendarDatabaseHelper {
  static final CalendarDatabaseHelper instance =
      CalendarDatabaseHelper._getInstance();
  static Database? _database;
  final table = 'events';
  final columnId = 'id';

  CalendarDatabaseHelper._getInstance();

  //// CREATE USER ////
  Future<Database> get database async {
    _database = await _initDatabase();
    return _database!;
  }

  // INTITALIZES DATABASE
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'fitsageDB.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  // CREATES TABLES
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        workoutName TEXT,
        workoutMuscle TEXT,
        day INTEGER,
        month INTEGER,
        year INTEGER
      )
    ''');
  }

  Future<int> insertEvent(Event event) async {
    Database db = await instance.database;
    return await db.insert(table, event.toMap());
  }

  Future<List<Map<String, dynamic>>> queryAllEvents() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<List<Event>?> queryEvent(int id) async {
    Database db = await instance.database;

    List<Map<String, dynamic>> maps = await db.query(table,
        columns: ['id', 'workoutName', 'workoutMuscle', 'day', 'month', 'year'],
        where: '$columnId = ?',
        whereArgs: [id]);

    if (maps.isNotEmpty) {
      return maps.map((e) => Event.fromMap(e)).toList();
    }

    return null;
  }

  Future<int> updateEvent(Event event) async {
    final db = await database;
    final id = event.id;
    return await db
        .update(table, event.toMap(), where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> deleteEvent(int id) async {
    final db = await database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
}
