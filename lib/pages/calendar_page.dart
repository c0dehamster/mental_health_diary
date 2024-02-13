import 'package:flutter/material.dart';
import 'package:mental_health_diary/components/app_drawer.dart';
import 'package:mental_health_diary/components/calendar_page_components/calendar.dart';
import 'package:mental_health_diary/models/database/first_launch_date.dart';
import 'package:mental_health_diary/models/database/mood_database.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final moodDatabase = MoodDatabase();
  final firstLaunchDate = FirstLaunchDate();

  final today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final initDate = firstLaunchDate.firstLaunchDate ?? today;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        toolbarHeight: 72,
        leadingWidth: 64,
        centerTitle: true,
        titleSpacing: 0,

        // Date navigator
        title: const Text(
          "Your monthly report",
          style: TextStyle(fontSize: 14),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.sunny),
            ),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        children: [
          Calendar(
            initDate: initDate,
            datasets: moodDatabase.averageValuesAll,
          ),
        ],
      ),
    );
  }
}
