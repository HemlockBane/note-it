import 'package:flutter/material.dart';
import 'package:note_it/src/constants/app_strings.dart';
import 'package:note_it/src/models/note.dart';
import 'package:note_it/src/models/popup_menu_option.dart';
import 'package:note_it/src/notifiers/note_notifier.dart';
import 'package:note_it/src/utils/utils.dart';

enum PageMode { edit, view }

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

  final popUpMenuOptions = [
    PopupMenuOption(
        value: PopupMenuValue.delete, label: 'Delete', iconData: Icons.ac_unit),
  ];

  bool get _isInEditMode => _pageMode == PageMode.edit;

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
        title: Text(_isInEditMode ? AppStrings.editing : AppStrings.viewing),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: _onOptionSelected,
            itemBuilder: (context) => popUpMenuOptions
                .map(
                  (menuOption) => PopupMenuItem(
                    value: menuOption.value,
                    child: Text(menuOption.label),
                  ),
                )
                .toList(),
          ),
        ],
      ),
      body: WillPopScope(
        onWillPop: _onBackButtonPressed,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _buildTitleField(),
                Divider(),
                _buildDateAndTimeText(),
                _buildContentField(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleField() {
    return TextField(
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
    );
  }

  Widget _buildDateAndTimeText() {
    return Container(
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
    );
  }

  Widget _buildContentField() {
    return TextField(
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
    );
  }

  void _onOptionSelected(PopupMenuValue newValue) async {
    print('selected option: $newValue');

    if (newValue == PopupMenuValue.delete) {
      await _noteNotifier.deleteNote(_note);
      Navigator.of(context).pop();
    }
  }

  void _startEditingIfViewing() {
    if (!_isInEditMode) {
      setState(() {
        _pageMode = PageMode.edit;
      });
    }
  }

  /// Determines what to do when the back button is presses
  /// It pops the screen if it returns false, and doesn't pop
  /// the screen if it returns true
  Future<bool> _onBackButtonPressed() async {
    _bundleNote(_isNewNote);
    print('Is new note: $_isNewNote');

    // In view mode
    if (!_isInEditMode) {
      return true;
    }

    //In edit mode
    if (_isInEditMode) {
      FocusScope.of(context)
          .requestFocus(FocusNode()); // Unfocus from textfields

      setState(() {
        _pageMode = PageMode.view;
      });

      // Add note
      if (_isNewNote) {
        setState(() {
          _isNewNote = false;
        });
        print('Added note...');
        await _noteNotifier.addNote(_note);
        return false;
      }

      // Update note
      if (!_isNewNote) {
        // print('Updated note...');
        //TODO: Update note here if the note has changed

        await _noteNotifier.editNote(_note);

        print('saving note: $_note');
      }
    }

    return false; // Don't pop screen if in edit mode
  }

  void _bundleNote(bool isNewNote) {
    if (!isNewNote) {
      _note.dateLastModified = DateTime.now().toIso8601String();
    }

    _note.title = _titleController.text.isNotEmpty
        ? _titleController.text
        : 'Untitled Note';
    _note.content = _contentController.text;
  }
}
