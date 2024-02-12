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

    // This is obviously wrong, just a way to check if the data is displayed

    final values = currentDateRecords.map((e) => e.value);

    final average = values.isNotEmpty
        ? values.reduce((value, element) => value + element) / values.length
        : null;

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
