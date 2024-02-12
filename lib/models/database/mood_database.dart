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
