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
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: NoteSearchDelegate(),
                );
              }),
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
                          goToViewNoteScreen(context: context, note: note);
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
          goToViewNoteScreen(context: context, note: Note(), isNewNote: true);
        },
        tooltip: 'Add Note',
        child: Icon(Icons.add),
      ),
    );
  }
}

class NoteSearchDelegate extends SearchDelegate {
  NoteSearchDelegate();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Results'),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // If search query is empty,
    // show suggestions based on previous searches or based on the current context

    // If search query is not empty, show suggestions that match the query

    return Consumer<NoteNotifier>(
      builder: (context, _noteNotifier, _) {
        List<Note> notes = [];

        // string.contains() returns values for an empty query. How??
        if (query.isNotEmpty) {
          notes = _noteNotifier.notes
              .where((note) => note.title.toLowerCase().contains(query))
              .toList();
        }

        bool hasNoResults = query.isNotEmpty && notes.isEmpty;

        return hasNoResults
            ? Center(child: Text("No results", style: TextStyle(fontSize: 18)))
            : ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  final note = notes[index];
                  return NoteListTile(
                      note: note,
                      onNoteTapped: () {
                        goToViewNoteScreen(context: context, note: note);
                      });
                },
              );
      },
    );
  }
}

void goToViewNoteScreen(
    {@required BuildContext context,
    @required Note note,
    bool isNewNote = false}) {
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
