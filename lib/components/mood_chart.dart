import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mental_health_diary/models/mood_record.dart';

class MoodChart extends StatelessWidget {
  const MoodChart({
    super.key,
    required this.data,
  });

  final List<MoodRecord> data;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              spots: data
                  .map((moodRecord) => FlSpot(
                        moodRecord.timestamp.hour.toDouble(),
                        moodRecord.value.toDouble(),
                      ))
                  .toList(),
              isCurved: false,
              color: Theme.of(context).colorScheme.primary,
            ),
          ],

          // Displayed ranges of values (constant)
          minX: 0,
          maxX: 24,
          minY: 1,
          maxY: 9,

          // Grid styling
          backgroundColor: Theme.of(context).colorScheme.secondary,
          gridData: FlGridData(
            drawVerticalLine: false,
            getDrawingHorizontalLine: (value) {
              return FlLine(color: Theme.of(context).colorScheme.background);
            },
            horizontalInterval: 1,
          ),

          // The show prop defaults to false; by creating a SideTitle without arguments,
          // we make it not show up
          titlesData: const FlTitlesData(
            topTitles: AxisTitles(
              sideTitles: SideTitles(),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 3,
                reservedSize: 32,
              ),
            ),
          ),

          // Styled X-axis aka border-bottom
          borderData: FlBorderData(
            show: true,
            border: Border(
              bottom: BorderSide(color: Theme.of(context).colorScheme.primary),
            ),
          ),
        ),
      ),
    );
  }
}
