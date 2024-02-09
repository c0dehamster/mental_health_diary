import 'package:mental_health_diary/models/mood_record.dart';
import 'package:mental_health_diary/models/note.dart';

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

// Arbitrary notes

final List<Note> mockDataNotes = [
  Note(
    contents:
        "Lorem, ipsum dolor sit amet consectetur adipisicing elit. Provident quo voluptates dicta tempore non, ratione velit ad illum fugiat aut alias laboriosam facilis animi consectetur distinctio quaerat, qui natus sunt possimus tempora?",
    timestamp: DateTime(today.year, today.month, today.day, 10),
  ),
  Note(
    contents:
        "Amet fuga commodi beatae ex quod quibusdam impedit mollitia iusto pariatur saepe. Ea debitis provident ipsam accusamus optio in, numquam veritatis similique ratione.",
    timestamp: DateTime(today.year, today.month, today.day, 16),
  ),
  Note(
    contents:
        "Aliquid facere atque porro laudantium hic vero sit quod maiores enim illum placeat assumenda quo quidem unde, earum dignissimos consequatur iure? Doloremque, dignissimos! Soluta quam quibusdam iusto facilis eveniet.",
    timestamp: DateTime(today.year, today.month, today.day, 20),
  ),
  Note(
    contents:
        "Reprehenderit ratione quasi perferendis sapiente in soluta totam ipsa velit, quo minus adipisci quisquam recusandae?",
    timestamp: DateTime(today.year, today.month, today.day, 22),
  ),
];
