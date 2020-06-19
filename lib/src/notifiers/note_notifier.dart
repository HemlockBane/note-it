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

  Future<void> editNote(Note noteToEdit) async {
    final dbService = await NotesDBService.getInstance();
    await dbService.editNote(noteToEdit);

    final oldNoteIndex = _notes.indexWhere((note) => note.id == noteToEdit.id);
    _notes.replaceRange(oldNoteIndex, oldNoteIndex + 1, [noteToEdit]);
    notifyListeners();
  }

  Future<void> deleteNote(Note noteToDelete) async {
    final dbService = await NotesDBService.getInstance();
    await dbService.deleteNote(noteToDelete);
    _notes.removeWhere((note) => note.id == noteToDelete.id);
    notifyListeners();
  }
}
