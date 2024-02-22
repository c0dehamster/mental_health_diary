import 'package:flutter/material.dart';
import 'package:mental_health_diary/components/mood_chart.dart';
import 'package:mental_health_diary/utils/breakpoints.dart';

import '../models/database/mood_database.dart';
import '../models/database/notes_database.dart';

class InfoBlock extends StatelessWidget {
  const InfoBlock({
    super.key,
    required this.dateToDisplay,
  });

  final DateTime dateToDisplay;

  @override
  Widget build(BuildContext context) {
    final moodDatabase = MoodDatabase();
    final notesDatabase = NotesDatabase();
    final averageMood = moodDatabase.getAveragePerDate(dateToDisplay);
    final averageMoodFormatted = averageMood != null
        ? "Average mood: ${averageMood.toStringAsFixed(1)}"
        : "No data";

    List<Widget> notes =
        notesDatabase.getNotesByDate(dateToDisplay).map((note) {
      return Container(
        margin: const EdgeInsets.only(bottom: 32),
        width: double.infinity,
        decoration:
            BoxDecoration(color: Theme.of(context).colorScheme.secondary),
        padding: const EdgeInsets.all(16),
        child: Text(
          note.contents,
          style: TextStyle(
            height: 2,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      );
    }).toList();

    final layoutMobile = Container(
      constraints: const BoxConstraints(maxWidth: 480),
      child: Column(
        children: [
          MoodChart(dateToDisplay: dateToDisplay),
          const SizedBox(height: 72),
          Text(
            averageMoodFormatted,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 48),
          Column(
            children: notes,
          ),
        ],
      ),
    );

    final layoutDesktop = Row(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                averageMoodFormatted,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 72),
              ...notes
            ],
          ),
        ),
        const SizedBox(width: 64),
        Expanded(
          child: MoodChart(dateToDisplay: dateToDisplay),
        ),
      ],
    );

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth < Breakpoints.large) {
          return layoutMobile;
        } else {
          return layoutDesktop;
        }
      },
    );
  }
}
