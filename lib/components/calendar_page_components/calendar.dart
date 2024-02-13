import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:mental_health_diary/theme/mood_spectre.dart';

class Calendar extends StatelessWidget {
  const Calendar({
    super.key,
    required this.initDate,
    required this.datasets,
  });

  final DateTime initDate;
  final Map<DateTime, int> datasets;

  @override
  Widget build(BuildContext context) {
    return HeatMapCalendar(
      datasets: datasets,
      colorsets: moodSpectreColorset,
      initDate: initDate,
      colorMode: ColorMode.color,
      defaultColor: Theme.of(context).colorScheme.onBackground,
      textColor: Theme.of(context).colorScheme.primary,
      borderRadius: 2,
      margin: const EdgeInsets.all(3),
      flexible: true,
    );
  }
}
