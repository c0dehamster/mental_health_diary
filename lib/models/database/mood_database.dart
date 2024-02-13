import 'package:hive/hive.dart';
import 'package:mental_health_diary/models/mood_record.dart';

import '../../utils/datetime_utils.dart';

class MoodDatabase {
  List<MoodRecord> records = [];

  // Reference the box

  final _recordsBox = Hive.box<MoodRecord>("records");

  // Load the data from the database

  void loadData() {
    records = _recordsBox.toMap().values.toList();
  }

  // Get records given a particular date

  List<MoodRecord> getRecordsByDate(DateTime dateToDisplay) {
    loadData();

    List<MoodRecord> currentDateRecords = [];

    for (final record in records) {
      if (isCurrentDate(record.timestamp, dateToDisplay)) {
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

    // An absolutely horrendous way to round to a given precision

    final average =
        double.parse((areaUnderGraph / timeIntervalTotal).toStringAsFixed(1));

    return average;
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
