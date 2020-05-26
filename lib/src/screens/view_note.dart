import 'package:flutter/material.dart';
import 'package:note_it/src/models/note.dart';

class ViewNoteScreen extends StatefulWidget {
  static final String routeName = 'view_note';
  final Note note;

  ViewNoteScreen({this.note});
  @override
  _ViewNoteScreenState createState() => _ViewNoteScreenState();
}

class _ViewNoteScreenState extends State<ViewNoteScreen> {
  Note note;
  PageMode _pageMode;

  TextEditingController _titleController;
  TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    note = widget.note;
    _titleController = TextEditingController(text: note.title);
    _contentController = TextEditingController(text: note.content);
    _pageMode = note.isEmpty ? PageMode.edit : PageMode.view;
  }

  @override
  Widget build(BuildContext context) {
    print(note.isEmpty);
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextField(
                controller: _titleController,
                style: TextStyle(fontSize: 30),
                decoration: InputDecoration(
                  hintText: 'Title',
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 8),
                  fillColor: Colors.amber,
                  isDense: true, // Makes text field compact
                ),
              ),
              Divider(),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(note.date),
                    ),
                    // SizedBox(
                    //   width: 30,
                    // ),
                    Expanded(
                      child: Text(note.date),
                    )
                  ],
                ),
              ),
              TextField(
                controller: _contentController,
                maxLines: null,
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  hintText: 'Body',
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 8),
                  fillColor: Colors.amber,
                  isDense: true, // Makes text field compact
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum PageMode { edit, view }
