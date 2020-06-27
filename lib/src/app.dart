import 'package:flutter/material.dart';
import 'package:note_it/src/notifiers/note_notifier.dart';
import 'package:note_it/src/screens/archived_notes.dart';
import 'package:note_it/src/screens/deleted_notes.dart';
import 'package:note_it/src/screens/notes.dart';
import 'package:note_it/src/screens/view_note.dart';
import 'package:note_it/src/widgets/theme.dart';
import 'package:provider/provider.dart';

import 'models/note.dart';
import 'notifiers/drawer_notifier.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NoteNotifier()),
        ChangeNotifierProvider(create: (_) => DrawerNotifier()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: AppTheme().lightTheme,
        home: NotesScreen(),
        routes: {
          NotesScreen.routeName: (BuildContext context) => NotesScreen(),
          ArchivedNotesScreen.routeName: (BuildContext context) => ArchivedNotesScreen(),
          DeletedNotesScreen.routeName: (BuildContext context) => DeletedNotesScreen()
          // ViewNoteScreen.routeName: (BuildContext context) => ViewNoteScreen(note: Note(),)
        },
      ),
    );
  }
}
