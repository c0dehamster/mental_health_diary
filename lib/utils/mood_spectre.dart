import 'package:flutter/material.dart';
import 'package:mental_health_diary/theme/theme_provider.dart';
import 'package:provider/provider.dart';

const List<Color> moodSpectreOnDark = [
  Color(0xFFBD3030),
  Color(0xFFC05E50),
  Color(0xFFC38D70),
  Color(0xFFC6BA8F),
  Color(0xFFC9E8AF),
  Color(0xFFC5FEC6),
  Color(0xFFBBFCD5),
  Color(0xFFB0FAE3),
  Color(0xFFA6F8F1),
  Color(0xFF9BF6FF),
];

const List<Color> moodSpectreOnLight = [
  Color(0xFFD21110),
  Color(0xFFB9451B),
  Color(0xFFA07B25),
  Color(0xFF87AF30),
  Color(0xFF6DE53B),
  Color(0xFF5CF355),
  Color(0xFF52DB80),
  Color(0xFF48C2AB),
  Color(0xFF3EAAD5),
  Color(0xFF3491FF),
];

List<Color> getMoodSpectre(BuildContext context) {
  return Provider.of<ThemeProvider>(context, listen: false).isDarkMode
      ? moodSpectreOnDark
      : moodSpectreOnLight;
}

Map<int, Color> getMoodSpectreAsMap(BuildContext context) {
  final moodSpectre = getMoodSpectre(context);
  final Map<int, Color> moodSpectreMap = {};

  for (var i = 0; i < moodSpectre.length; i++) {
    moodSpectreMap[i + 1] = moodSpectre[i];
  }

  return moodSpectreMap;
}
