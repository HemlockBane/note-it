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

  // NotesDBService _localDBService;
  // Database _db;

  List<Note> _notes = [];

  List<Note> get notes => _notes;

  // Future<void> init() async =>
  //     _localDBService = await NotesDBService.getInstance();

  Future<void> addNote(Note note) async {
    final dbService = await NotesDBService.getInstance();
    final noteId = await dbService.addNote(note);
    note.id = noteId;  
    _notes.add(note);
    notifyListeners();
  }

  Future<List<Note>> getNotes() async {
    final dbService = await NotesDBService.getInstance();
    final notes = await dbService.getNotes();
    _notes.addAll(notes);
    return notes;
  }

  Future<void> editNote(Note editedNote) async {
    final dbService = await NotesDBService.getInstance();
    dbService.editNote(editedNote);

    final oldNoteIndex = _notes.indexWhere((note) => note.id == editedNote.id);
    _notes.replaceRange(oldNoteIndex, oldNoteIndex + 1, [editedNote]);
    notifyListeners();
  }
}
