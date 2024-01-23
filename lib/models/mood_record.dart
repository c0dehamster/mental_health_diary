import 'package:isar/isar.dart';

part 'mood_record.g.dart';

@Collection()
class MoodRecord {
  Id id = Isar.autoIncrement;

  late int value;

  // The date-time when the record is created, down to hours
  late DateTime timestamp;
}
