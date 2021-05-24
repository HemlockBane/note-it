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

  List<Note> get notes => _notes
      .where((note) => note.isArchived == false && note.isSoftDeleted == false)
      .toList();

  List<Note> get bookmarkedNotes =>
      notes.where((note) => note.isBookmarked == true).toList();

  List<Note> get archivedNotes =>
      _notes.where((note) => note.isArchived == true && note.isSoftDeleted == false).toList();

  List<Note> get deletedNotes =>
      _notes.where((note) => note.isSoftDeleted == true).toList();

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
    _notes
        .clear(); // To prevent duplicate notes i.e addding the same notes to the previous notes
    _notes.addAll(notes);
    notifyListeners();
    return notes;
  }

  Future<void> editNote(Note updatedNote) async {
    final dbService = await NotesDBService.getInstance();
    await dbService.editNote(updatedNote);

    final oldNoteIndex = _notes.indexWhere((note) => note.id == updatedNote.id);
    _notes.replaceRange(oldNoteIndex, oldNoteIndex + 1, [updatedNote]);
    notifyListeners();
  }

  Future<void> hardDeleteNote(Note noteToDelete) async {
    final dbService = await NotesDBService.getInstance();
    await dbService.hardDeleteNote(noteToDelete);
    _notes.removeWhere((note) => note.id == noteToDelete.id);
    notifyListeners();
  }
}
