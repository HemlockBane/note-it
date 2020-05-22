import 'package:flutter/material.dart';
import 'package:note_it/src/constants/app_strings.dart';
import 'package:note_it/src/models/note.dart';
import 'package:note_it/src/widgets/bottom_app_bar.dart';

class MyHomeScreen extends StatefulWidget {
  MyHomeScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomeScreenState createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  int _currentTabIndex = 0;

  void _changeTab(int nextTabIndex) {
    setState(() {
      _currentTabIndex = nextTabIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(getDummyNotes().isNotEmpty);
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
      body: getDummyNotes().isEmpty
          ? _noNotesInfo(context: context)
          : Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: ListView.builder(
                itemCount: getDummyNotes().length,
                itemBuilder: (context, index) {
                  Note note = getDummyNotes()[index];
                  return NoteCard(
                    note: note,
                  );
                },
              ),
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
        onPressed: () {},
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
}

class NoteCard extends StatelessWidget {
  Note note;
  NoteCard({this.note});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(bottom: 5), child: Text(note.title)),
          Container(
            margin: EdgeInsets.only(bottom: 5),
            child: Text(note.content),
          ),
          Container(margin: EdgeInsets.only(bottom: 5), child: Text(note.date)),
          Row(
            children: <Widget>[
              Container(
                color: Colors.black,
                child: Text(
                  note.tagName,
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
