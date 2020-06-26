import 'package:flutter/material.dart';
import 'package:note_it/src/constants/app_strings.dart';
import 'package:note_it/src/widgets/drawer.dart';

class ArchivedNotesScreen extends StatefulWidget {
  static final String routeName = 'archived_notes';
  @override
  _ArchivedNotesScreenState createState() => _ArchivedNotesScreenState();
}

class _ArchivedNotesScreenState extends State<ArchivedNotesScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(AppStrings.archivedNotes),
          ),
          drawer: AppDrawer()),
    );
  }
}
