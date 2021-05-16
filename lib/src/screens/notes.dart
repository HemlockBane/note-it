import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:note_it/src/constants/app_strings.dart';
import 'package:note_it/src/models/note.dart';
import 'package:note_it/src/notifiers/note_notifier.dart';
import 'package:note_it/src/screens/bookmarked_notes.dart';

import 'package:note_it/src/screens/view_note.dart';
import 'package:note_it/src/utils/utils.dart';
import 'package:note_it/src/widgets/bottom_app_bar.dart';
import 'package:note_it/src/widgets/drawer.dart';
import 'package:provider/provider.dart';

import 'all_notes.dart';


class NotesScreen extends StatefulWidget {
  static final String routeName = 'notes';
  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  int _currentTabIndex = 0;
  NoteNotifier _noteNotifier;
  final tabs = [
    AllNotesScreen(),
    BookmarkedNotesScreen(),
  ];

  //TODO: Load data before showing tabs?
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final notes = await _noteNotifier.getNotes();
      // for (var note in notes) {
      //   print(note);
      // }
      // setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    //  print('rebuilding home.dart');
    _noteNotifier = NoteNotifier.of(context);
    return SafeArea(
      child: Scaffold(
        // drawer: AppDrawer(),
        body: tabs[_currentTabIndex],
        bottomNavigationBar: AppBottomNavigationBar(
          onTabSelected: _changeTab,
          items: [
            AppBottomNavigationBarItem(
                iconData: LineIcons.home, text: AppStrings.all),
            AppBottomNavigationBarItem(
                iconData: LineIcons.star, text: AppStrings.bookmarks),
            // AppBottomNavigationBarItem(iconData: Icons.label, text: 'Tags')
          ],
        ),
      ),
    );
  }

  void _changeTab(int nextTabIndex) {
    setState(() {
      _currentTabIndex = nextTabIndex;
    });
  }
}
