import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:note_it/src/models/note.dart';
import 'package:provider/provider.dart';

class NoteNotifier with ChangeNotifier {
  static NoteNotifier of(BuildContext context) =>
      Provider.of<NoteNotifier>(context, listen: false);

  List<Note> notes = [...getDummyNotes()];

  void addNote(Note note) {
    notes.add(note);
    notifyListeners();
  }
}
