import 'package:flutter/material.dart';
import 'package:mental_health_diary/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class ToggleThemeButton extends StatelessWidget {
  const ToggleThemeButton({
    super.key,
    required this.context,
  });

  final BuildContext context;

  void toggleTheme() {
    Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: toggleTheme,
      icon: Provider.of<ThemeProvider>(context, listen: false).isDarkMode
          ? const Icon(Icons.wb_sunny_sharp)
          : const Icon(Icons.nightlight_sharp),
    );
  }
}
