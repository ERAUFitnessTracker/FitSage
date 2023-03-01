import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ui_draft1/userData.dart';

import 'UserForm.dart';
import 'WhiteBoxForData.dart';
import 'user.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._getInstance();
  static Database? _database;

  DatabaseHelper._getInstance();

  Future<Database> get database async {
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'my_database.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY,
        name TEXT,
        weight REAL,
        height REAL,
        age INTEGER,
        gender TEXT
      )
    ''');
  }

  Future<int> insert(User user) async {
    Database db = await instance.database;

    return await db.insert('users', user.toMap());
  }

  Future<List<User>?> getUser(int id) async {
    Database db = await instance.database;

    List<Map<String, dynamic>> maps = await db.query('users',
        columns: ['id', 'name', 'weight', 'height', 'age', 'gender'],
        where: 'id = ?',
        whereArgs: [id]);

    if (maps.length > 0) {
      return maps.map((e) => User.fromMap(e)).toList();
    }

    return null;
  }

  Future<int> replaceUser(User user) async {
    final Database db = await instance.database;
    return await db.update('users',
        user.toMap(),
    );
  }

  Future<bool> hasData() async {
    Database db = await instance.database;
    if (db != null) {
      final List<Map<String, dynamic>> result =
      await db.rawQuery('SELECT COUNT(*) FROM users');

      return Sqflite.firstIntValue(result)! > 0;
    } else {
      return Future.value(false);
    }
  }
  Future<int> getLastID() async {
    int id = 0;
    List? user = await getUser(id);
    while (user != null) {
      id++;
    }
    return id;
  }

  Future<bool> isIDEmpty(int id) async {
    List? user = await getUser(id);
        return user == null;
}

  static Future<List<Map<String, dynamic>>> getUsers() async {
    final Database database = await openDatabase(
      join(await getDatabasesPath(), 'my_database.db'),
    );
    return database.query('users');
  }
}
class DatabaseCheck extends StatelessWidget {
  const DatabaseCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: DatabaseHelper.instance.hasData(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!) {
          // If the database has data, display it instead of the form
          return const UserDataPrint();
        } else {
          // If the database is empty, display the form
          return const UserForm();
        }
      },
    );
  }
}

