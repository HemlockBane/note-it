import 'package:flutter/material.dart';
import 'package:note_it/src/models/note.dart';
import 'package:note_it/src/services/utils.dart';

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
  FocusNode _titleFocusNode;
  FocusNode _contentFocusNode;

  @override
  void initState() {
    super.initState();
    note = widget.note;
    _titleController = TextEditingController(text: note.title);
    _contentController = TextEditingController(text: note.content);
    _titleFocusNode = FocusNode();
    _contentFocusNode = FocusNode();
    _pageMode = note.isNew ? PageMode.edit : PageMode.view;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print(note.isNew);
    print(_pageMode);
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Editing' : 'Viewing'),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
          )
        ],
      ),
      body: WillPopScope(
        onWillPop: () async {
          // print('title focus: ${_titleFocusNode.hasFocus}');
          // print('title primary focus: ${_titleFocusNode.hasPrimaryFocus}');
          // print('content focus: ${_contentFocusNode.hasFocus}');
          // print('content primary focus: ${_contentFocusNode.hasPrimaryFocus}');


          if(!_isEditing) {
            return true; // Pop screen if in view mode
          }

          if (_isEditing) {
            FocusScope.of(context).requestFocus(FocusNode()); // Unfocus from textfields
            setState(() {
              _pageMode = PageMode.view;
            });
          } 

          return false;
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _titleController,
                  autofocus: note.isNew,
                  focusNode: _titleFocusNode,
                  // onEditingComplete: (){},
                  // onSubmitted: (value){},
                  style: TextStyle(fontSize: 30),
                  decoration: InputDecoration(
                    hintText: 'Title',
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 8),
                    isDense: true, // Makes text field compact
                  ),
                ),
                Divider(),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Row(
                    // TODO: Maybe we should use a TextSpan instead?
                    children: <Widget>[
                      Text('${beautifyDate(note.dateCreated)}\t'),
                      // SizedBox(
                      //   width: 30,
                      // ),
                      Text('\t${beautifyTime(note.dateCreated)}')
                    ],
                  ),
                ),
                TextField(
                  onTap: () {},
                  controller: _contentController,
                  focusNode: _contentFocusNode,
                  maxLines: null, // Makes text to wrap to next line
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
      ),
    );
  }


  bool get _isEditing => _pageMode == PageMode.edit;
}

enum PageMode { edit, view }
