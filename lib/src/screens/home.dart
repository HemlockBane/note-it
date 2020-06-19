import 'package:flutter/material.dart';
import 'package:note_it/src/constants/app_strings.dart';
import 'package:note_it/src/models/note.dart';
import 'package:note_it/src/notifiers/note_notifier.dart';

import 'package:note_it/src/screens/view_note.dart';
import 'package:note_it/src/utils/utils.dart';
import 'package:note_it/src/widgets/bottom_app_bar.dart';
import 'package:provider/provider.dart';

import 'all_notes.dart';
import 'favourite_notes.dart';

class MyHomeScreen extends StatefulWidget {
  @override
  _MyHomeScreenState createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  int _currentTabIndex = 0;
  final tabs = [
    AllNotesScreen(),
    FavouriteNotesScreen(),
  ];

  //TODO: Load data before showing tabs?
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // final notes = await _noteNotifier.getNotes();
      // for (var note in notes) {
      //   print(note);
      // }

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    //  print('rebuilding home.dart');
    return Scaffold(
      // drawer: Drawer(),
      body: tabs[_currentTabIndex],
      bottomNavigationBar: AppBottomNavigationBar(
        onTabSelected: _changeTab,
        items: [
          AppBottomNavigationBarItem(iconData: Icons.book, text: AppStrings.all),
          AppBottomNavigationBarItem(iconData: Icons.star, text: AppStrings.bookmarks),
          // AppBottomNavigationBarItem(iconData: Icons.label, text: 'Tags')
        ],
      ),
    );
  }

  void _changeTab(int nextTabIndex) {
    setState(() {
      _currentTabIndex = nextTabIndex;
    });
  }
}
