import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mental_health_diary/models/theme_settings.dart';
import 'package:mental_health_diary/theme/dark_mode.dart';

class ThemeProvider extends ChangeNotifier {
  // Defaut theme is dark
  ThemeData _themeData = darkMode;

  // Get the current theme
  ThemeData get themeData => _themeData;

  // Set theme
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }
}
