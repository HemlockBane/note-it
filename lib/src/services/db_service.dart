import 'dart:async';

import 'package:note_it/src/models/note.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class NotesDBService {
  static final tableName = 'notes';
  static final dbName = 'notes.db';
  static final _sqlString =
      'CREATE TABLE notes(id INTEGER PRIMARY KEY, title TEXT, content TEXT, date_created TEXT)';
  static Database _db;

  NotesDBService._();

  static Future<NotesDBService> getInstance() async {
    _db ??= await _openDb();
    return NotesDBService._();
  } // instance variables can't be accessed from static variables

  static Future<Database> _openDb() async {
    final databasesPath = await getDatabasesPath();
    final dbPath = path.join(databasesPath, dbName);
    final db = openDatabase(dbPath, version: 1, onCreate: _createDB);

    return db;
  }

  /// Only called if the db has not been created in the device
  static Future<void> _createDB(Database db, int version) =>
      db.execute(_sqlString);

  Future<void> addNote(Note note) async {
    final map = note.toMap();
    // print(map);

    final responseCode = await _db.insert(tableName, map,
        conflictAlgorithm: ConflictAlgorithm.replace);

    print(responseCode);
  }

  editNote() {}

  Future<List<Note>> getNotes() async {
    final maps = await _db.query(tableName);
    // print(maps);

    return List.generate(maps.length, (index) => Note.fromMap(maps[index]));
  }

  deleteNote() {}
}
