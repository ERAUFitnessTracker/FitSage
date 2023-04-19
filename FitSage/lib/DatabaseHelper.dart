// ignore_for_file: file_names, depend_on_referenced_packages

import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'user.dart';
import 'event.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._getInstance();
  static Database? _database;

  DatabaseHelper._getInstance();
  final userTable = '''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY,
        name TEXT,
        weight REAL,
        height REAL,
        age INTEGER,
        gender TEXT,
        goal TEXT
      )
    ''';
  final eventsTable = '''
      CREATE TABLE events (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        workoutName TEXT,
        workoutMuscle TEXT,
        met REAL,
        day INTEGER,
        month INTEGER,
        year INTEGER,
        totalCalories INTEGER
      ) 
    ''';

  //// GET DATABASE ////
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
    await db.execute(userTable);
    await db.execute(eventsTable);
  }

  ///// USER TABLE CRUD /////
  // Creates user
  Future<int> createUser(User user) async {
    Database db = await instance.database;

    return await db.insert('users', user.toMap());
  }

  // Queries user
  Future<List<User>?> readUser(int id) async {
    Database db = await instance.database;

    List<Map<String, dynamic>> maps = await db.query('users',
        columns: ['id', 'name', 'weight', 'height', 'age', 'gender', 'goal'],
        where: 'id = ?',
        whereArgs: [id]);

    if (maps.isNotEmpty) {
      return maps.map((e) => User.fromMap(e)).toList();
    }

    return null;
  }

  // Updates user
  Future<int> updateUser(User user) async {
    final Database db = await instance.database;
    return await db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [0],
    );
  }

  // Deletes user
  Future<int> deleteUser(int id) async {
    final db = await instance.database;
    int result = await db.delete("users", where: "id = ?", whereArgs: [0]);

    return result;
  }

  Future<bool> isIDEmpty(int id) async {
    List? user = await readUser(id);
    return user == null;
  }

  // Checks if user exists
  Future<bool> userHasData() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> result =
        await db.rawQuery('SELECT COUNT(*) FROM users');

    return Sqflite.firstIntValue(result)! > 0;
  }

  Future<int> getLastUserID() async {
    int id = 0;
    List? user = await readUser(id);
    while (user != null) {
      id++;
    }
    return id;
  }

  Future<int> getLastEventID() async {
    int id = 0;
    List? event = await queryEvent(id);
    while (event != null) {
      id++;
    }
    return id;
  }

  // Gets all users
  static Future<List<Map<String, dynamic>>> getUsers() async {
    final Database database = await instance.database;
    return database.query('users');
  }

  // Gets separate user biometrics
  Future<String> getUserInfo(String choice) async {
    final Database database = await instance.database;
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
      case 'goal':
        return user['goal'].toString();
      default:
        return "";
    }
  }
///////////////////////////

///// EVENTS TABLE CRUD /////
// Creates event
  Future<int> insertEvent(Event event) async {
    Database db = await instance.database;
    return await db.insert('events', event.toMap());
  }

// Queries all events
  static Future<List<Map<String, dynamic>>> queryAllEvents() async {
    Database db = await instance.database;
    return await db.query('events');
  }

// Queries single event
  Future<List<Event>?> queryEvent(int id) async {
    Database db = await instance.database;

    List<Map<String, dynamic>> maps = await db.query('events',
        columns: [
          'id',
          'workoutName',
          'workoutMuscle',
          'met',
          'day',
          'month',
          'year',
          'totalCalories'
        ],
        where: 'id = ?',
        whereArgs: [id]);

    if (maps.isNotEmpty) {
      return maps.map((e) => Event.fromMap(e)).toList();
    }

    return null;
  }

  Future<List<Map<String, dynamic>>> queryEventsforDay(
      int day, int month, int year) async {
    Database db = await instance.database;

    return await db.query(
      'events',
      columns: [
        'id',
        'workoutName',
        'workoutMuscle',
        'met',
        'day',
        'month',
        'year',
        'totalCalories'
      ],
      where: 'day = ? AND month = ? AND year = ?',
      whereArgs: [day, month, year],
    );
  }

// Updates event
  Future<int> updateEvent(Event event, int id) async {
    final db = await instance.database;
    return await db
        .update('events', event.toMap(), where: 'id = ?', whereArgs: [id]);
  }

// Deletes event
  Future<int> deleteEvent(int id) async {
    final db = await instance.database;
    return await db.delete('events', where: 'id = ?', whereArgs: [id]);
  }

  // Checks if event exists
  Future<bool> doesEventExist(String workoutName, String workoutMuscle, int day,
      int month, int year) async {
    final db = await instance.database;
    final result = await db.query(
      'events',
      where:
          'workoutName = ? AND workoutMuscle = ? AND day = ? AND month = ? AND year = ?',
      whereArgs: [workoutName, workoutMuscle, day, month, year],
    );
    return result.isNotEmpty;
  }

  Future<bool> doesNullEventExist(
      String workoutName, String workoutMuscle) async {
    final db = await instance.database;
    final result = await db.query(
      'events',
      where: 'workoutName = ? AND workoutMuscle = ?',
      whereArgs: [workoutName, workoutMuscle],
    );
    return result.isNotEmpty;
  }

  //for nutrition calculator

  //adds calories for the day (ik this one is ugly sorry)
  Future<void> incrementCaloriesForDay(
      int day, int month, int year, int incrementAmount) async {
    int oldCalories = await getCaloriesForDay(day, month, year);
    int newCalories = oldCalories + incrementAmount;
    await setCaloriesForDay(day, month, year, newCalories);
  }

  Future<int> updateCalories(
      Event event, int day, int month, int year, int newCalories) async {
    final db = await instance.database;
    return await db.update('events', {'totalCalories': newCalories},
        where: 'day = ? AND month = ? AND year = ?',
        whereArgs: [day, month, year]);
  }

  Future<int> getIDForDay(int day, int month, int year) async {
    int id = 0;
    final events = await queryEventsforDay(day, month, year);
    if (events.isNotEmpty) {
      id = events.first['id'];
    }
    return id;
  }

  Future<int> getCaloriesForDay(int day, int month, int year) async {
    int totalCalories = 0;
    final events = await queryEventsforDay(day, month, year);
    //if there is data for the day, get the total calories
    if (events.isNotEmpty) {
      for (final event in events) {
        totalCalories = Event.fromMap(event).totalCalories;
      }
      return totalCalories;
    }
    // If no events exist for this day, create a new one and return 0
    else {
      final newEvent = Event(
          workoutName: '',
          workoutMuscle: '',
          met: 0,
          day: day,
          month: month,
          year: year,
          totalCalories: 0);
      await insertEvent(newEvent);
      return totalCalories;
    }
  }

  Future<void> setCaloriesForDay(
      int day, int month, int year, int newCalories) async {
    final events = await queryEventsforDay(day, month, year);
    for (final event in events) {
      await updateCalories(Event.fromMap(event), day, month, year, newCalories);
    }
  }

//////////////////////////
}
