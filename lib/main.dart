import 'package:flutter/material.dart';
import 'package:note_it/src/app.dart';
import 'package:note_it/src/constants/app_strings.dart';
import 'package:note_it/src/notifiers/theme_notifier.dart';
import 'package:note_it/src/services/db_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Will throw an exception if not called before initiasing SQLite
  await NotesDBService.getInstance();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  final themeIdx = prefs.getInt(AppStrings.themeIndex) ?? 0;
  final themeOption = getThemeOptionFromIndex(themeIdx);

  runApp(App(
    themeOption: themeOption,
  ));
}
