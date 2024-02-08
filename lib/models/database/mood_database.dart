import 'package:hive/hive.dart';
import 'package:mental_health_diary/models/mood_record.dart';

class MoodDatabase {
  /* SETUP */
  static late Box box;

  static void initialize() {
    box = Hive.box<MoodRecord>("records");
  }

  List<MoodRecord> records = box.toMap().values.toList() as List<MoodRecord>;

  /* CRUD OPERATIONS */

  // CREATE - save a new record

  // Will see if async is required
  void addRecord(int value) {}

  // READ - get all records for a given date

  // UPDATE

  // DELETE - clear all records
}
