import 'package:hive/hive.dart';

part 'note.g.dart';

@HiveType(typeId: 2)
class Note {
  @HiveField(0)
  final String contents;

  @HiveField(1)
  final DateTime timestamp;

  Note({
    required this.contents,
    required this.timestamp,
  });
}
