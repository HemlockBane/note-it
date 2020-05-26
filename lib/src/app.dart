import 'package:flutter/material.dart';
import 'package:note_it/src/screens/home.dart';
import 'package:note_it/src/screens/view_note.dart';
import 'package:note_it/src/widgets/theme.dart';

import 'models/note.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme().lightTheme,
      home: MyHomeScreen(title: 'Note it'),
      routes: {
        // ViewNoteScreen.routeName: (BuildContext context) => ViewNoteScreen(note: Note(),)
      },
    );
  }
}
