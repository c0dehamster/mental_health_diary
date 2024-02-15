import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mental_health_diary/models/database/first_launch_date.dart';
import 'package:mental_health_diary/models/mood_record.dart';
import 'package:mental_health_diary/models/note.dart';
import 'package:mental_health_diary/pages/calendar_page.dart';
import 'package:mental_health_diary/pages/home_page.dart';
import 'package:mental_health_diary/pages/settings_page.dart';
import 'package:mental_health_diary/theme/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register adapters
  Hive.registerAdapter(MoodRecordAdapter());
  Hive.registerAdapter(NoteAdapter());

  // Open the boxes
  await Hive.openBox<String>("themeSettings");
  await Hive.openBox<DateTime>("firstLaunchDate");
  await Hive.openBox<MoodRecord>("records");
  await Hive.openBox<Note>("notes");

  // Save the first launch date
  FirstLaunchDate().saveFirstLaunchDate;

  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/": (context) => const HomePage(),
        "/calendarView": (context) => const CalendarPage(),
        "/settings": (context) => const SettingsPage(),
      },
      title: "Mental Health Diary",
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
