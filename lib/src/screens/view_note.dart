import 'package:flutter/material.dart';
import 'package:note_it/src/models/note.dart';
import 'package:note_it/src/notifiers/note_notifier.dart';
import 'package:note_it/src/services/utils.dart';

class ViewNoteScreen extends StatefulWidget {
  static final String routeName = 'view_note';
  final Note note;
  final bool isNewNote;

  ViewNoteScreen({this.note, this.isNewNote = false});
  @override
  _ViewNoteScreenState createState() => _ViewNoteScreenState();
}

class _ViewNoteScreenState extends State<ViewNoteScreen> {
  Note _note;
  bool _isNewNote;
  PageMode _pageMode;

  TextEditingController _titleController;
  TextEditingController _contentController;
  FocusNode _titleFocusNode;
  FocusNode _contentFocusNode;

  NoteNotifier _noteNotifier;

  @override
  void initState() {
    super.initState();
    _note = Note.copyOf(widget.note);
    _isNewNote = widget.isNewNote;
    _titleController = TextEditingController(text: _note.title);
    _contentController = TextEditingController(text: _note.content);
    _titleFocusNode = FocusNode();
    _contentFocusNode = FocusNode();
    _pageMode = _isNewNote ? PageMode.edit : PageMode.view;

    // print(widget.note.title);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _noteNotifier = NoteNotifier.of(context);
    // print(note.isNew);
    // print(_pageMode);
    return Scaffold(
      appBar: AppBar(
        title: Text(_isInEditMode ? 'Editing' : 'Viewing'),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
          )
        ],
      ),
      body: WillPopScope(
        onWillPop: _handleWillPop,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _titleController,
                  autofocus: _isNewNote,
                  focusNode: _titleFocusNode,
                  onTap: () {
                    _startEditingIfViewing();
                  },
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
                      Text('${beautifyDate(_note.dateCreated)}\t'),
                      // SizedBox(
                      //   width: 30,
                      // ),
                      Text('\t${beautifyTime(_note.dateCreated)}')
                    ],
                  ),
                ),
                TextField(
                  onTap: () {
                    _startEditingIfViewing();
                  },
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

  void _startEditingIfViewing() {
    if (!_isInEditMode) {
      setState(() {
        _pageMode = PageMode.edit;
      });
    }
  }

  Future<bool> _handleWillPop() async {
    _bundleNote();
    print('Is new note: $_isNewNote');

    // In view mode
    if (!_isInEditMode) {
      return true; // Pop screen if in view mode
    }

    //In edit mode
    if (_isInEditMode) {
      FocusScope.of(context)
          .requestFocus(FocusNode()); // Unfocus from textfields

      // Add note
      if (_isNewNote) {
        print('Added note...');
        await _noteNotifier.addNote(_note);
      }

      // Update note
      if (!_isNewNote) {
        // print('Updated note...');
        // Update note here if there is any change
        // await _noteNotifier.editNote(_note);

        print('saving note: $_note');
      }

      setState(() {
        _pageMode = PageMode.view;
      });
    }

    return false; // Don't pop screen if in edit mode
  }

  void _bundleNote() {
    _note.title = _titleController.text.isNotEmpty
        ? _titleController.text
        : 'Untitled Note';
    _note.content = _contentController.text;
  }

  bool get _isInEditMode => _pageMode == PageMode.edit;
}

enum PageMode { edit, view }
