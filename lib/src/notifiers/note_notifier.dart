import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:note_it/src/models/note.dart';
import 'package:note_it/src/services/db_service.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

class NoteNotifier with ChangeNotifier {
  static NoteNotifier of(BuildContext context) =>
      Provider.of<NoteNotifier>(context, listen: false);

  DBService _localDBService = DBService();
  Database _db;

  List<Note> _notes = [...getDummyNotes()];

  UnmodifiableListView<Note> get notes => UnmodifiableListView(_notes);

  Future<void> getDbInstance() async => _db = await _localDBService.getDb();

  void addNote(Note note) {
    _notes.add(note);
    _localDBService.addNote(note);
    notifyListeners();
  }
}
