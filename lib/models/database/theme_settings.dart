import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mental_health_diary/theme/dark_mode.dart';
import 'package:mental_health_diary/theme/light_mode.dart';

class ThemeSettings extends ChangeNotifier {
  final themeSettingsBox = Hive.box<String>("themeSettings");

  String? _theme;

  void loadData() {
    _theme = themeSettingsBox.get("theme");
  }

  ThemeData get theme {
    loadData();

    // The default setting is the dark theme

    if (_theme == null) return darkMode;

    return _theme == "dark" ? darkMode : lightMode;
  }

  void toggleTheme() {
    loadData();

    final newTheme = _theme == "dark" ? "light" : "dark";

    themeSettingsBox.put("theme", newTheme);
  }
}
