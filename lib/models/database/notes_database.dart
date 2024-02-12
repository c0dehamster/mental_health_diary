import 'package:hive_flutter/adapters.dart';

import '../../utils/datetime_utils.dart';
import '../note.dart';

class NotesDatabase {
  List<Note> notes = [];

  // Reference the box
  final _notesBox = Hive.box<Note>("notes");

  // Load the data from the database

  void loadData() {
    notes = _notesBox.toMap().values.toList();
  }

  // Read notes given a particular date

  List<Note> getNotesByDate(DateTime dateToDisplay) {
    loadData();

    List<Note> currentDateNotes = [];

    for (final note in notes) {
      if (isCurrentDate(note.timestamp, dateToDisplay)) {
        currentDateNotes.add(note);
      }
    }

    return currentDateNotes;
  }

  // Update the database

  void addNote(String contents) {
    final newIndex = _notesBox.length;

    _notesBox.add(
      Note(
        contents: contents,
        timestamp: DateTime.timestamp(),
        index: newIndex,
      ),
    );
  }

  void editNote(int index, String newContents) {
    _notesBox.deleteAt(index);

    _notesBox.put(
      index,
      Note(
        contents: newContents,
        timestamp: DateTime.timestamp(),
        index: index,
      ),
    );
  }

  void deleteNote(int index) {
    _notesBox.deleteAt(index);
  }
}
