import 'package:flutter/material.dart';
import 'package:mental_health_diary/models/database/theme_settings.dart';
import 'dark_mode.dart';
import 'light_mode.dart';

class ThemeProvider extends ChangeNotifier {
  // Access the database

  final themeSettings = ThemeSettings();

  // Defaut theme is dark

  ThemeData _themeData = darkMode;

  // Get the current theme

  ThemeData get themeData => _themeData;

  // Is the current theme dark

  bool get isDarkMode => _themeData == darkMode;

  // Set theme

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  // Toggle theme

  void toggleTheme() {
    themeData = themeSettings.theme == darkMode ? lightMode : darkMode;
    themeSettings.toggleTheme();
  }
}
