import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:note_it/src/constants/app_strings.dart';
import 'package:note_it/src/models/note.dart';
import 'package:note_it/src/notifiers/note_notifier.dart';
import 'package:note_it/src/screens/view_note.dart';
import 'package:note_it/src/widgets/drawer.dart';
import 'package:note_it/src/widgets/no_notes_info.dart';
import 'package:note_it/src/widgets/note_list.dart';
import 'package:provider/provider.dart';

class BookmarkedNotesScreen extends StatefulWidget {
  @override
  _BookmarkedNotesScreenState createState() => _BookmarkedNotesScreenState();
}

class _BookmarkedNotesScreenState extends State<BookmarkedNotesScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(AppStrings.bookmarkedNotes),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(LineIcons.bars),
          onPressed: () {
            _scaffoldKey.currentState.openDrawer();
          },
        ),
        actions: <Widget>[
          IconButton(icon: Icon(LineIcons.search), onPressed: () {}),
          IconButton(icon: Icon(LineIcons.verticalEllipsis), onPressed: () {}),
        ],
      ),
      drawer: AppDrawer(),
      body: Consumer<NoteNotifier>(
        builder: (context, noteNotifier, _) {
          print('rebuilding bookmarked notes');
          return noteNotifier.bookmarkedNotes.isEmpty
              ? NoNoteInfo()
              : Container(
                  // margin: EdgeInsets.symmetric(horizontal: 15),
                  child: ListView.separated(
                    itemCount: noteNotifier.bookmarkedNotes.length,
                    separatorBuilder: (context, index) => Divider(),
                    itemBuilder: (context, index) {
                      Note note = noteNotifier.bookmarkedNotes[index];

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
