import 'package:flutter/material.dart';
import 'package:note_it/src/constants/app_strings.dart';
import 'package:note_it/src/models/note.dart';
import 'package:note_it/src/notifiers/note_notifier.dart';
import 'package:note_it/src/screens/view_note.dart';
import 'package:note_it/src/widgets/drawer.dart';
import 'package:note_it/src/widgets/no_notes_info.dart';
import 'package:note_it/src/widgets/note_list.dart';
import 'package:provider/provider.dart';

class AllNotesScreen extends StatefulWidget {
  @override
  _AllNotesScreenState createState() => _AllNotesScreenState();
}

class _AllNotesScreenState extends State<AllNotesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.allNotes),
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      drawer: AppDrawer(),
      body: Consumer<NoteNotifier>(
        builder: (context, noteNotifier, _) {
          print('rebuilding all notes');
          return noteNotifier.notes.isEmpty
              ? NoNoteInfo()
              : Container(
                  // margin: EdgeInsets.symmetric(horizontal: 15),
                  child: ListView.separated(
                    itemCount: noteNotifier.notes.length,
                    separatorBuilder: (context, index) => Divider(),
                    itemBuilder: (context, index) {
                      Note note = noteNotifier.notes[index];
                      Theme.of(context).textTheme.copyWith();
                      return NoteListTile(
                        note: note,
                        onNoteTapped: () {
                          _goToViewNoteScreen(note: note);
                        },
                      );
                    },
                  ),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).accentColor,
        onPressed: () {
          _goToViewNoteScreen(note: Note(), isNewNote: true);
        },
        tooltip: 'Add Note',
        child: Icon(Icons.add),
      ),
    );
  }

  void _goToViewNoteScreen({Note note, bool isNewNote = false}) {
    // print('entering note: $note');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return ViewNoteScreen(
          note: note,
          isNewNote: isNewNote,
        );
      }),
    );
  }
}
