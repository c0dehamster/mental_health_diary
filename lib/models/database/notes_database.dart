import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

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
      if (DateUtils.isSameDay(note.timestamp.toLocal(), dateToDisplay)) {
        currentDateNotes.add(note);
      }
    }

    return currentDateNotes;
  }

  // Update the database

  void addNote(String contents) {
    loadData();
    final newIndex = _notes.isEmpty ? 0 : _notes.last.index + 1;

    _notesBox.put(
      newIndex,
      Note(
        contents: contents,
        timestamp: DateTime.timestamp(),
        index: newIndex,
      ),
    );
  }

  void editNote(int index, String newContents) {
    _notesBox.delete(index);

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
    _notesBox.delete(index);
  }
}
