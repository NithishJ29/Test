// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// class DatabaseHelper {
//   static final DatabaseHelper _instance = DatabaseHelper._internal();
//   factory DatabaseHelper() => _instance;
//   DatabaseHelper._internal();

//   static Database? _database;

//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDatabase();
//     return _database!;
//   }

//   Future<Database> _initDatabase() async {
//     final String path = join(await getDatabasesPath(), 'app.db');
//     return await openDatabase(path, version: 1, onCreate: _createDb);
//   }

//   void _createDb(Database db, int version) async {
//     await db.execute('''
//       CREATE TABLE products(
//         id INTEGER PRIMARY KEY,
//         name TEXT NOT NULL,
//         description TEXT NOT NULL
//       )
//     ''');
//   }

//   Future<void> insertProduct(Map<String, dynamic> product) async {
//     final db = await database;
//     if (product['name'] != null && product['description'] != null) {
//       await db.insert('products', product,
//           conflictAlgorithm: ConflictAlgorithm.replace);
//     }
//   }

//   Future<List<Map<String, dynamic>>> getProducts() async {
//     final db = await database;
//     return await db.query('products');
//   }
// }
