import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'UserDataPrint.dart';
import 'UserForm.dart';
import 'user.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._getInstance();
  static Database? _database;

  DatabaseHelper._getInstance();

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
      CREATE TABLE users (
        id INTEGER PRIMARY KEY,
        name TEXT,
        weight REAL,
        height REAL,
        age INTEGER,
        gender TEXT,
      )
    ''');

    // db.execute('''
    //   CREATE TABLE workouts (
    //     id INTEGER PRIMARY KEY,
    //     name TEXT,
    //     mGroup TEXT,
    //     met REAL,
    //   )
    // ''');
  }

  Future<int> createUser(User user) async {
    Database db = await instance.database;

    return await db.insert('users', user.toMap());
  }

  //// READ USER ////
  Future<List<User>?> readUser(int id) async {
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

  /////////////////////

  //// UPDATE USER ////
  Future<int> updateUser(User user) async {
    final Database db = await instance.database;
    return await db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [0],
    );
  }
  /////////////////////

  //// DELETE USER ////
  Future<int> deleteUser(int id) async {
    //returns number of items deleted
    final db = await instance.database;

    int result = await db.delete("users", where: "id = ?", whereArgs: [0]);

    return result;
  }

  Future<bool> isIDEmpty(int id) async {
    List? user = await readUser(id);
    return user == null;
  }
  /////////////////////

  //// CHECK IF USER EXISTS ////
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
    List? user = await readUser(id);
    while (user != null) {
      id++;
    }
    return id;
  }

  static Future<List<Map<String, dynamic>>> getUsers() async {
    final Database database = await openDatabase(
      join(await getDatabasesPath(), 'fitsageDB.db'),
    );
    return database.query('users');
  }

  Future<String> getUserInfo(String choice) async {
    final Database database = await openDatabase(
      join(await getDatabasesPath(), 'fitsageDB.db'),
    );
    List<Map<String, Object?>> users = await database.query('users');
    Map<String, dynamic> user = users[0];
    switch (choice) {
      case 'name':
        return user['name'].toString();
      case 'weight':
        return user['weight'].toString();
      case 'height':
        return user['height'].toString();
      case 'age':
        return user['age'].toString();
      case 'gender':
        return user['gender'].toString();
      default:
        return "";
    }
  }
}
