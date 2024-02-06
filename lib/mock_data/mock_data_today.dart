import 'package:mental_health_diary/models/mood_record.dart';

final today = DateTime.now();

// Values and hours in the timestamp are arbitrary
final List<MoodRecord> mockDataMoodValues = [
  MoodRecord(
    value: 8,
    timestamp: DateTime(today.year, today.month, today.day, 10),
  ),
  MoodRecord(
    value: 6,
    timestamp: DateTime(today.year, today.month, today.day, 16),
  ),
  MoodRecord(
    value: 5,
    timestamp: DateTime(today.year, today.month, today.day, 22),
  ),
  MoodRecord(
    value: 3,
    timestamp: DateTime(today.year, today.month, today.day, 23),
  ),
];
