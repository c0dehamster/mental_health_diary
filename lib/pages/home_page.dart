import 'package:flutter/material.dart';
import 'package:mental_health_diary/components/mood_chart.dart';
import 'package:mental_health_diary/components/mood_picker.dart';
import 'package:mental_health_diary/components/notes_section.dart';
import 'package:mental_health_diary/mock_data/mock_data_today.dart';

import '../components/app_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        toolbarHeight: 72,
        leadingWidth: 64,
        centerTitle: true,
        titleSpacing: 0,
        // Date navigator
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.chevron_left),
            ),
            const Text(
              "January 30th",
              style: TextStyle(fontSize: 14),
            ), // Replace later with the actual date
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.chevron_right),
            ),
          ],
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
          MoodChart(data: mockDataMoodValues),
          const SizedBox(height: 72),
          const MoodPicker(),
          const SizedBox(height: 72),
          const NotesSection(),
        ],
      ),
    );
  }
}
