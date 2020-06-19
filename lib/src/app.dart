import 'package:flutter/material.dart';
import 'package:note_it/src/notifiers/note_notifier.dart';
import 'package:note_it/src/screens/home.dart';
import 'package:note_it/src/screens/view_note.dart';
import 'package:note_it/src/widgets/theme.dart';
import 'package:provider/provider.dart';

import 'models/note.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NoteNotifier()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: AppTheme().lightTheme,
        home: MyHomeScreen(title: 'Note it'),
        routes: {
          // ViewNoteScreen.routeName: (BuildContext context) => ViewNoteScreen(note: Note(),)
        },
      ),
    );
  }
}
