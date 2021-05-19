import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:note_it/src/constants/app_strings.dart';
import 'package:note_it/src/models/note.dart';
import 'package:note_it/src/notifiers/note_notifier.dart';
import 'package:note_it/src/screens/view_note.dart';
import 'package:note_it/src/widgets/drawer.dart';
import 'package:note_it/src/widgets/no_notes_info.dart';
import 'package:note_it/src/widgets/note_list_tile.dart';
import 'package:provider/provider.dart';

class AllNotesScreen extends StatefulWidget {
  @override
  _AllNotesScreenState createState() => _AllNotesScreenState();
}

class _AllNotesScreenState extends State<AllNotesScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(AppStrings.allNotes),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(LineIcons.bars),
          onPressed: () {
            _scaffoldKey.currentState.openDrawer();
          },
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(LineIcons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: NoteSearchDelegate(),
                );
              }),
          IconButton(icon: Icon(LineIcons.verticalEllipsis), onPressed: () {}),
        ],
      ),
      drawer: AppDrawer(
        selectedColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Consumer<NoteNotifier>(
        builder: (context, noteNotifier, _) {
          print('rebuilding all notes');
          return noteNotifier.notes.isEmpty
              ? NoNoteInfo()
              : Container(
                  color: Theme.of(context).colorScheme.background,
                  // margin: EdgeInsets.symmetric(horizontal: 15),
                  child: ListView.separated(
                    //TODO: We probably have to modify the theme of the listview
                    itemCount: noteNotifier.notes.length,
                    separatorBuilder: (context, index) => Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 24,
                      ),
                      child: Divider(
                        height: 3,
                      ),
                    ),
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
        backgroundColor: Theme.of(context).colorScheme.secondary,
        onPressed: () {
          goToViewNoteScreen(context: context, note: Note(), isNewNote: true);
        },
        tooltip: 'Add Note',
        child: Icon(LineIcons.plus),
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
      icon: Icon(LineIcons.arrowLeft),
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
    return Consumer<NoteNotifier>(
      builder: (context, _noteNotifier, _) {
        List<Note> notes = [];

        // string.contains() returns true for an empty query. How??
        if (query.isNotEmpty) {
          notes
              .where((note) => note.title.toLowerCase().contains(query))
              .toList();
        }

        bool queryHasNoResults = query.isNotEmpty && notes.isEmpty;

        return queryHasNoResults
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
