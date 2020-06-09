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
    // await dbService.addNote(note);
    _notes.add(note);
    notifyListeners();
  }

  Future<List<Note>> getNotes() async {
    final dbService = await NotesDBService.getInstance();
    final notes = await dbService.getNotes();
    _notes.addAll(notes);
    return notes;
  }

  Future editNote(Note editedNote) async{
    final dbService = await NotesDBService.getInstance();
    // dbService.editNote(editedNote);

    // edit note in list

    // Get the movie's index

    // _notes.indexOf(editedNote);

    // _notes.replaceRange();

  

    notifyListeners();
  }
}
