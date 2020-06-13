import 'package:flutter/material.dart';
import 'package:note_it/src/constants/app_strings.dart';
import 'package:note_it/src/models/note.dart';
import 'package:note_it/src/notifiers/note_notifier.dart';
import 'package:note_it/src/screens/view_note.dart';
import 'package:note_it/src/services/utils.dart';
import 'package:note_it/src/widgets/bottom_app_bar.dart';
import 'package:provider/provider.dart';

class MyHomeScreen extends StatefulWidget {
  MyHomeScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomeScreenState createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  int _currentTabIndex = 0;
  NoteNotifier _noteNotifier;

  //TODO: Load data before showing tabs?
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final notes = await _noteNotifier.getNotes();
      // for (var note in notes) {
      //   print(note);
      // }

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    //  print('rebuilding home.dart');
    _noteNotifier = NoteNotifier.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      // drawer: Drawer(),
      body: Consumer<NoteNotifier>(
        builder: (context, noteNotifier, _) {
          return noteNotifier.notes.isEmpty
              ? _noNotesInfo(context: context)
              : Container(
                  // margin: EdgeInsets.symmetric(horizontal: 15),
                  child: ListView.separated(
                    itemCount: noteNotifier.notes.length,
                    separatorBuilder: (context, index) => Divider(),
                    itemBuilder: (context, index) {
                      Note note = noteNotifier.notes[index];

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
      bottomNavigationBar: AppBottomNavigationBar(
        onTabSelected: _changeTab,
        items: [
          AppBottomNavigationBarItem(iconData: Icons.book, text: 'Notes'),
          AppBottomNavigationBarItem(iconData: Icons.star, text: 'Favourites'),
          AppBottomNavigationBarItem(iconData: Icons.label, text: 'Tags')
        ],
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

  Widget _noNotesInfo({BuildContext context}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            AppStrings.noNotes,
            style: Theme.of(context).textTheme.display1.copyWith(fontSize: 14),
          ),
        ],
      ),
    );
  }

  void _changeTab(int nextTabIndex) {
    setState(() {
      _currentTabIndex = nextTabIndex;
    });
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

class NoteListTile extends StatelessWidget {
  final Note note;
  final VoidCallback onNoteTapped;

  NoteListTile({this.note, this.onNoteTapped});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onNoteTapped();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 5),
              child: Text(
                note.title,
                style: TextStyle(fontSize: 18),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 5),
              child: Text(
                note.content,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 5),
              child: Text(
                '${beautifyDate(note.dateLastModified)} at ${beautifyTime(note.dateLastModified)}',
                style: TextStyle(fontSize: 11),
              ),
            ),
            if (note.tagName.isNotEmpty)
              Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 7, vertical: 1),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    child: Text(
                      note.tagName,
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              )
          ],
        ),
      ),
    );
  }
}
