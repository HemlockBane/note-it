import 'package:flutter/material.dart';
import 'package:note_it/src/constants/app_strings.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ThemeOption {
  light,
  dark,
  system,
  sepia,
}

ThemeOption getThemeOptionFromIndex(int index) {
  switch (index) {
    case 0:
      return ThemeOption.light;
    case 1:
      return ThemeOption.dark;
    default:
      return ThemeOption.light;
  }
}

class ThemeNotifier with ChangeNotifier {
  static ThemeNotifier of(BuildContext context) =>
      Provider.of<ThemeNotifier>(context, listen: false);

  ThemeOption _currentThemeOption;

  ThemeNotifier({ThemeOption themeOption})
      : this._currentThemeOption = themeOption ?? ThemeOption.light;

  ThemeMode getThemeMode() {
    if (_currentThemeOption == ThemeOption.light ||
        _currentThemeOption == ThemeOption.sepia) {
      return ThemeMode.light;
    }

    return ThemeMode.dark;

    // return ThemeMode.system;
  }

  void updateThemeOption(ThemeOption themeOption) {
    this._currentThemeOption = themeOption;
    notifyListeners();
  }
}
