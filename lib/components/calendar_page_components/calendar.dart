import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:mental_health_diary/utils/mood_spectre.dart';

class Calendar extends StatelessWidget {
  const Calendar({
    super.key,
    required this.initDate,
    required this.datasets,
    required this.onDateSelect,
  });

  final DateTime initDate;
  final Map<DateTime, int> datasets;
  final void Function(DateTime) onDateSelect;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 480),
        child: HeatMapCalendar(
          datasets: datasets,
          colorsets: getMoodSpectreAsMap(context),
          initDate: initDate,
          colorMode: ColorMode.color,
          defaultColor: Theme.of(context).colorScheme.tertiary,
          textColor: Theme.of(context).colorScheme.secondary,
          borderRadius: 2,
          margin: const EdgeInsets.all(3),
          flexible: true,
          showColorTip: false,
          onClick: onDateSelect,
        ),
      ),
    );
  }
}
