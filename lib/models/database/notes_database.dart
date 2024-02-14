import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mental_health_diary/mock_data/mock_data_today.dart';

import '../note.dart';

class NotesDatabase {
  List<Note> _notes = [];

  // Reference the box
  final _notesBox = Hive.box<Note>("notes");

  // Load the data from the database

  void loadData() {
    _notes = _notesBox.toMap().values.toList();
  }

  // Read notes given a particular date

  List<Note> getNotesByDate(DateTime dateToDisplay) {
    loadData();

    List<Note> currentDateNotes = [];

    for (final note in _notes) {
      if (DateUtils.isSameDay(note.timestamp, dateToDisplay)) {
        currentDateNotes.add(note);
      }
    }

    // If no notes is in the list, placeholder data is returned (temporary)

    return currentDateNotes.isNotEmpty ? currentDateNotes : mockDataNotes;
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
