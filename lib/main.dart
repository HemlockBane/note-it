import 'package:flutter/material.dart';
import 'package:note_it/src/app.dart';
import 'package:note_it/src/services/db_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Will throw an exception if not called
  await NotesDBService.getInstance();
  runApp(App());
}
