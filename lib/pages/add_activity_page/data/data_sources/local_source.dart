import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/add_activity_model.dart';

class LocalDatabase {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('activty.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE notes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        descriptionOptional TEXT NOT NULL,
        dueDate TEXT NOT NULL
      )
    ''');
  }

  // CRUD Methods
  Future<int> insert(AddActivityModel note) async {
    final db = await database;
    return await db.insert('notes', note.toMap());
  }

  Future<List<AddActivityModel>> getAll() async {
    final db = await database;
    final result = await db.query('notes',
      orderBy: 'dueDate DESC',
    );
    return result.map((e) => AddActivityModel.fromMap(e)).toList();
  }

  Future<int> update(AddActivityModel note) async {
    final db = await database;
    return await db.update('notes', note.toMap(), where: 'id = ?', whereArgs: [note.id]);
  }

  Future<int> delete(int id) async {
    final db = await database;
    return await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }
}