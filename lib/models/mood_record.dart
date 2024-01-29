import 'package:hive/hive.dart';

part 'mood_record.g.dart';

@HiveType(typeId: 1)
class MoodRecord {
  @HiveField(0)
  final int value;

  @HiveField(1)
  final DateTime timestamp;

  MoodRecord({
    required this.value,
    required this.timestamp,
  });
}
