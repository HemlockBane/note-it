import 'package:note_it/src/models/note.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DBService {
  final tableName = 'notes';
  final dbName = 'notes.db';
  final sqlString = '';
  Future<Database> _db;

  Future<Database> getDb() {
    _db ??= _initDb();
    return _db;
  }

  Future<Database> _initDb() async {
    final databasesPath = await getDatabasesPath();
    final dbPath = path.join(databasesPath, dbName);
    final db = openDatabase(dbPath,
        version: 1,
        onCreate: (Database db, int version) => db.execute(sqlString));
    return db;
  }

  addNote(Note note) {}

  editNote() {}

  getNote() {}

  deleteNote() {}
}
