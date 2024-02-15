import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mental_health_diary/components/info_block.dart';
import 'package:mental_health_diary/components/mood_chart.dart';
import 'package:mental_health_diary/components/home_page_components/notes_section.dart';
import 'package:mental_health_diary/components/toggle_theme_button.dart';
import 'package:mental_health_diary/utils/datetime_utils.dart';

import '../components/app_drawer.dart';
import '../components/home_page_components/mood_picker.dart';

enum InputMode { add, overwrite }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late DateTime displayedDate;

  final today = DateTime.now();

  var inputMode = InputMode.add;

  void incrementDate() {
    setState(() {
      displayedDate = displayedDate.add(const Duration(days: 1));
    });
  }

  void decrementDate() {
    setState(() {
      displayedDate = displayedDate.subtract(const Duration(days: 1));
    });
  }

  void setInputMode() {
    setState(() {
      inputMode = InputMode.overwrite;
    });

    Timer(const Duration(minutes: 15), () {
      setState(() {
        inputMode = InputMode.add;
      });
    });
  }

  @override
  void initState() {
    super.initState();

    // By default, the displayed date is the current date
    displayedDate = today;
  }

  @override
  Widget build(BuildContext context) {
    final dateFormatted = "${months[displayedDate.month]} ${displayedDate.day}";

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          backgroundColor: Theme.of(context).colorScheme.background,
          foregroundColor: Theme.of(context).colorScheme.primary,
          toolbarHeight: 72,
          leadingWidth: 64,
          centerTitle: true,
          titleSpacing: 0,

          // Date navigator
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: decrementDate,
                icon: const Icon(Icons.chevron_left),
              ),
              Text(
                dateFormatted,
                style: const TextStyle(fontSize: 14),
              ),

              // The forward button is only displayed if the date currently viewed is before the current date

              !DateUtils.isSameDay(displayedDate, today)
                  ? IconButton(
                      onPressed: incrementDate,
                      icon: const Icon(Icons.chevron_right),
                    )
                  : Container(width: 48),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: ToggleThemeButton(context: context),
            ),
          ],
        ),
        drawer: const AppDrawer(),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          children: DateUtils.isSameDay(displayedDate, today)
              ? [
                  MoodChart(
                    dateToDisplay: today,
                  ),
                  const SizedBox(height: 72),
                  MoodPicker(
                    inputMode: inputMode,
                    onAdd: setInputMode,
                  ),
                  const SizedBox(height: 72),
                  NotesSection(dateToDisplay: today),
                ]
              : [InfoBlock(dateToDisplay: displayedDate)],
        ),
      ),
    );
  }
}
