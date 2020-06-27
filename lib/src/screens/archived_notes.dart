import 'package:flutter/material.dart';
import 'package:note_it/src/constants/app_strings.dart';
import 'package:note_it/src/models/note.dart';
import 'package:note_it/src/notifiers/note_notifier.dart';
import 'package:note_it/src/screens/view_note.dart';
import 'package:note_it/src/widgets/drawer.dart';
import 'package:note_it/src/widgets/no_notes_info.dart';
import 'package:note_it/src/widgets/note_list.dart';
import 'package:provider/provider.dart';

class ArchivedNotesScreen extends StatefulWidget {
  static final String routeName = 'archived_notes';
  @override
  _ArchivedNotesScreenState createState() => _ArchivedNotesScreenState();
}

class _ArchivedNotesScreenState extends State<ArchivedNotesScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.archivedNotes),
        ),
        drawer: AppDrawer(),
        body: Consumer<NoteNotifier>(
          builder: (context, noteNotifier, _) {
            print('rebuilding archived notes');
            return noteNotifier.archivedNotes.isEmpty
                ? NoNoteInfo()
                : Container(
                    // margin: EdgeInsets.symmetric(horizontal: 15),
                    child: ListView.separated(
                      itemCount: noteNotifier.archivedNotes.length,
                      separatorBuilder: (context, index) => Divider(),
                      itemBuilder: (context, index) {
                        Note note = noteNotifier.archivedNotes[index];

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
