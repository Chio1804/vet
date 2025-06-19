// import 'package:flutter/foundation.dart';
// import 'package:path/path.dart';
// import 'package:sqflite_common/sqflite.dart';
// import 'package:sqflite_common_ffi/sqflite_ffi.dart';
// import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
// import 'package:praktikum_1/service/cat/cat_model.dart'; // Adjust path if needed

// class CatDatabaseHelper {
//   static final CatDatabaseHelper _instance = CatDatabaseHelper._internal();
//   static Database? _database;

//   factory CatDatabaseHelper() => _instance;

//   CatDatabaseHelper._internal();

//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDatabase();
//     return _database!;
//   }

//   Future<Database> _initDatabase() async {
//     // Use correct factory for web or native
//     if (kIsWeb) {
//       databaseFactory = databaseFactoryFfiWeb;
//     } else {
//       sqfliteFfiInit();
//       databaseFactory = databaseFactoryFfi;
//     }

//     final dbPath = await databaseFactory.getDatabasesPath();
//     final path = join(dbPath, 'cat_database.db');

//     return await databaseFactory.openDatabase(
//       path,
//       options: OpenDatabaseOptions(
//         version: 2,
//         onCreate: _onCreate,
//         onUpgrade: _onUpgrade,
//       ),
//     );
//   }

//   Future<void> _onCreate(Database db, int version) async {
//     await db.execute('''
//       CREATE TABLE cats (
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         title TEXT NOT NULL,
//         description TEXT NOT NULL,
//         completed INTEGER NOT NULL,
//         type TEXT NOT NULL
//       )
//     ''');
//   }

//   Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
//     if (oldVersion < 2) {
//       await db.execute('ALTER TABLE cats ADD COLUMN type TEXT DEFAULT "Other"');
//     }
//   }

//   Future<int> insertCat(catadd cat) async {
//     final db = await database;
//     return await db.insert(
//       'cats',
//       cat.toMap(),
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }

//   Future<List<catadd>> getCats() async {
//     final db = await database;
//     final List<Map<String, dynamic>> maps = await db.query('cats');
//     return maps.map((map) => catadd.fromMap(map)).toList();
//   }

//   Future<int> updateCat(catadd cat) async {
//     final db = await database;
//     return await db.update(
//       'cats',
//       cat.toMap(),
//       where: 'id = ?',
//       whereArgs: [cat.id],
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }

//   Future<int> deleteCat(int id) async {
//     final db = await database;
//     return await db.delete(
//       'cats',
//       where: 'id = ?',
//       whereArgs: [id],
//     );
//   }

//   Future<void> deleteAllCats() async {
//     final db = await database;
//     await db.delete('cats');
//   }
// }
