// THIS IS FOR TESTING STUFF


// import 'package:flutter/material.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
//
// void main() => runApp(MyApp());
//
// class User {
//   int id;
//   String name;
//   int weight;
//   int height;
//   int age;
//   String gender;
//
//   User({required this.id, required this.name, required this.weight, required this.height, required this.age, required this.gender});
//
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'name': name,
//       'weight': weight,
//       'height': height,
//       'age': age,
//       'gender': gender,
//     };
//   }
//
//   factory User.fromMap(Map<String, dynamic> map) {
//     return User(
//       id: map['id'],
//       name: map['name'],
//       weight: map['weight'],
//       height: map['height'],
//       age: map['age'],
//       gender: map['gender'],
//     );
//   }
// }
//
// class DatabaseHelper {
//   static final DatabaseHelper instance = DatabaseHelper._getInstance();
//   static Database? _database;
//
//   DatabaseHelper._getInstance();
//
//   Future<Database> get database async {
//     if (_database != null) {
//       return _database!;
//     }
//
//     _database = await _initDatabase();
//     return _database!;
//   }
//
//   Future<Database> _initDatabase() async {
//     String path = join(await getDatabasesPath(), 'my_database.db');
//
//     return await openDatabase(path, version: 1, onCreate: _onCreate);
//   }
//
//   Future<void> _onCreate(Database db, int version) async {
//     await db.execute('''
//       CREATE TABLE users (
//         id INTEGER PRIMARY KEY,
//         name TEXT,
//         weight INTEGER,
//         height INTEGER,
//         age INTEGER,
//         gender TEXT
//       )
//     ''');
//   }
//
//   Future<int> insert(User user) async {
//     Database db = await instance.database;
//
//     return await db.insert('users', user.toMap());
//   }
//
//   Future<List<User>?> getUser(int id) async {
//     Database db = await instance.database;
//
//     List<Map<String, dynamic>> maps = await db.query('users',
//         columns: ['id', 'name', 'weight', 'height', 'age', 'gender'],
//         where: 'id = ?',
//         whereArgs: [id]);
//
//     if (maps.length > 0) {
//       return maps.map((e) => User.fromMap(e)).toList();
//     }
//
//     return null;
//   }
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: 'User Info',
//       home: MyHomePage(),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});
//
//   @override
//   }
//
// }
//
// class UserForm extends StatefulWidget {
//   @override
//   _UserFormState createState() => _UserFormState();
// }
//
// class _UserFormState extends State<UserForm> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _weightController = TextEditingController();
//   final TextEditingController _heightController = TextEditingController();
//   final TextEditingController _ageController = TextEditingController();
//   final TextEditingController _genderController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('User Info'),
//       ),
//
//       body: Form(
//         key: _formKey,
//         child: Padding(
//           padding: EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               TextFormField(
//                 controller: _nameController,
//                 decoration: InputDecoration(
//                   labelText: 'Name',
//                 ),
//                 validator: (value) {
//                   if (value == null) {
//                     return 'Please enter your name.';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _weightController,
//                 keyboardType: TextInputType.number,
//                 decoration: InputDecoration(
//                   labelText: 'Weight (in lbs)',
//                 ),
//                 validator: (value) {
//                   if (value == null) {
//                     return 'Please enter your weight.';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _heightController,
//                 keyboardType: TextInputType.number,
//                 decoration: InputDecoration(
//                   labelText: 'Height (in inches)',
//                 ),
//                 validator: (value) {
//                   if (value == null) {
//                     return 'Please enter your height.';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _ageController,
//                 keyboardType: TextInputType.number,
//                 decoration: InputDecoration(
//                   labelText: 'Age',
//                 ),
//                 validator: (value) {
//                   if (value== null) {
//                     return 'Please enter your age.';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _genderController,
//                 decoration: InputDecoration(
//                   labelText: 'Gender',
//                 ),
//                 validator: (value) {
//                   if (value == null) {
//                     return 'Please enter your gender.';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(
//                 height: 16.0,
//               ),
//               Center(
//                 child:
//                 ElevatedButton(
//                   onPressed: () async {
//                     if (_formKey.currentState!.validate()) {
//                       User user = User(
//                         name: _nameController.text,
//                         weight: int.parse(_weightController.text),
//                         height: int.parse(_heightController.text),
//                         age: int.parse(_ageController.text),
//                         gender: _genderController.text, id: 0,
//                       );
//
//                       int id = await DatabaseHelper.instance.insert(user);
//
//
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content: Text('User added with ID: $id'),
//                         ),
//                       );
//                     }
//                   },
//                   child: Text('Submit'),
//                 ),
//               ),
//               SizedBox(
//                 height: 19.0,
//               ),
//               Center(
//                 child:
//                 ElevatedButton(
//                   onPressed: () async {
//                     await DatabasePrinter.printUsers(context);
//                   },
//                   child: Text('Print users'),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class DatabasePrinter {
//   static Future<void> printUsers(BuildContext context) async {
//     final Database database = await openDatabase(
//       join(await getDatabasesPath(), 'my_database.db'),
//     );
//
//     final List<Map<String, dynamic>> users = await database.query('users');
//
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(users.toString()),
//       ),
//     );
//   }
// }
//
//
// class UserListWidget extends StatelessWidget {
//   const UserListWidget({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<Map<String, dynamic>>>(
//       future: _getUsers(),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           final users = snapshot.data!;
//           return ListView.builder(
//             itemCount: users.length,
//             itemBuilder: (context, index) {
//               final user = users[index];
//               return ListTile(
//                 title: Text(user['name']),
//                 subtitle: Text(user['age'].toString()),
//                 trailing: Text(user['gender']),
//                 onTap: () {},
//               );
//             },
//           );
//         } else {
//           return Center(child: CircularProgressIndicator());
//         }
//       },
//     );
//   }
//
//   Future<List<Map<String, dynamic>>> _getUsers() async {
//     final Database database = await openDatabase(
//       join(await getDatabasesPath(), 'my_database.db'),
//     );
//
//     return database.query('users');
//   }
// }
//
//
//
