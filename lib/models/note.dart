import 'package:hive/hive.dart';

part 'note.g.dart';

@HiveType(typeId: 2)
class Note {
  @HiveField(0)
  final String contents;

  @HiveField(1)
  final DateTime timestamp;

  @HiveField(2)
  final int index;

  Note({
    required this.contents,
    required this.timestamp,
    required this.index,
  });
}
