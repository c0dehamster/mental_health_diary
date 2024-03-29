import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mental_health_diary/models/mood_record.dart';

class MoodDatabase {
  List<MoodRecord> _records = [];

  // Reference the box

  final _recordsBox = Hive.box<MoodRecord>("records");

  // Load the data from the database

  void loadData() {
    _records = _recordsBox.toMap().values.toList();
  }

  // Get records given a particular date

  List<MoodRecord> getRecordsByDate(DateTime dateToDisplay) {
    loadData();

    List<MoodRecord> currentDateRecords = [];

    // Timestamps are stored as UTC, therefore dateToDisplay is converted to UTC too

    for (final record in _records) {
      if (DateUtils.isSameDay(record.timestamp.toLocal(), dateToDisplay)) {
        currentDateRecords.add(record);
      }
    }

    return currentDateRecords;
  }

  // Get the average of the mood for a date

  num? getAveragePerDate(DateTime dateToDisplay) {
    final currentDateRecords = getRecordsByDate(dateToDisplay);

    if (currentDateRecords.isEmpty) return null;
    if (currentDateRecords.length == 1) return currentDateRecords[0].value;

    // Area under the graph divided by the timespan
    // between the first and the last record gives the average

    final timeIntervalTotal = currentDateRecords.last.timestamp
        .difference(currentDateRecords[0].timestamp)
        .inMinutes;

    num areaUnderGraph = 0;

    for (var i = 1; i < currentDateRecords.length; i++) {
      final timeInterval = currentDateRecords[i]
          .timestamp
          .difference(currentDateRecords[i - 1].timestamp)
          .inMinutes;

      final currentSectionArea =
          (currentDateRecords[i - 1].value + currentDateRecords[i].value) /
              2 *
              timeInterval;

      areaUnderGraph += currentSectionArea;
    }

    return areaUnderGraph / timeIntervalTotal;
  }

  // Get ALL the average mood values

  Map<DateTime, int> get averageValuesAll {
    Map<DateTime, int> averageMoodValues = {};

    loadData();

    final firstRecordDate =
        _records.isNotEmpty ? _records[0].timestamp : DateTime.now();

    // The heatmap requires the dataset to start from the 1st day of the monts

    final datasetStartDate =
        DateTime(firstRecordDate.year, firstRecordDate.month, 1);

    final datasetLength = DateTime.now().difference(datasetStartDate).inDays;

    for (var i = 0; i <= datasetLength; i++) {
      final date = datasetStartDate.add(Duration(days: i));
      final value = getAveragePerDate(date);

      // Since the heatmap displays 0 as an empty square,
      // the values are shifted by 1

      averageMoodValues[date] = value != null ? (value + 1).round() : 0;

/*       print("$date: $value");
 */
    }

    return averageMoodValues;
  }

  // Update the database

  void addRecord(int value) {
    _recordsBox.add(
      MoodRecord(
        value: value,
        timestamp: DateTime.timestamp(),
      ),
    );
  }

  // Overwrite the last record

  void overwriteRecord(int newValue) {
    _recordsBox.deleteAt(_recordsBox.length - 1);
    _recordsBox.add(
      MoodRecord(
        value: newValue,
        timestamp: DateTime.timestamp(),
      ),
    );
  }
}
