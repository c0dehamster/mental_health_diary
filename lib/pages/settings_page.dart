import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mental_health_diary/components/app_drawer.dart';

import '../models/mood_record.dart';
import '../models/note.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  // For now, reset just clears all the mood entries

  @override
  Widget build(BuildContext context) {
    final recordsBox = Hive.box<MoodRecord>("records");
    final notesBox = Hive.box<Note>("notes");

    clearRecords() async {
      recordsBox.clear();
    }

    clearNotes() async {
      notesBox.clear();
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          foregroundColor: Theme.of(context).colorScheme.primary,
          toolbarHeight: 72,
          leadingWidth: 64,
          centerTitle: true,
          titleSpacing: 0,

          // Date navigator
          title: const Text(
            "Settings",
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: clearRecords,
                  child: const Text(
                    "Clear records",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                TextButton(
                  onPressed: clearNotes,
                  child: const Text(
                    "Clear notes",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
