import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mental_health_diary/components/home_page_components/note_input_form.dart';
import 'package:mental_health_diary/components/note_tile.dart';
import 'package:mental_health_diary/mock_data/mock_data_today.dart';

import '../../models/database/notes_database.dart';
import '../../models/note.dart';

class NotesSection extends StatefulWidget {
  const NotesSection({
    super.key,
    required this.dateToDisplay,
  });

  final DateTime dateToDisplay;

  @override
  State<NotesSection> createState() => _NotesSectionState();
}

class _NotesSectionState extends State<NotesSection> {
  late final Box notesBox;

  final notesDatabase = NotesDatabase();

  Note? noteToEdit;

  bool isFormShown = false;

  void _setNoteToEdit(Note note) {
    setState(() {
      noteToEdit = note;
    });
  }

  @override
  void initState() {
    super.initState();

    notesBox = Hive.box<Note>("notes");
  }

  @override
  Widget build(BuildContext context) {
    void deleteTile(Note note) {
      notesDatabase.deleteNote(note.index);
    }

    final noteTiles = ValueListenableBuilder(
      valueListenable: notesBox.listenable(),
      builder: (context, value, child) {
        // Notes to display according to the date

        final currentDateNotes = notesDatabase.getNotesByDate(today);

        if (currentDateNotes.isEmpty) return Container();

        List<Widget> noteTiles = currentDateNotes
            .map((note) {
              return NoteTile(
                contents: note.contents,
                editTile: (context) => _setNoteToEdit(note),
                deleteTile: (context) => deleteTile(note),
              );
            })
            .toList()
            .reversed
            .toList();

        return Column(
          children: noteTiles,
        );
      },
    );

    return Column(
      children: [
        // New note input, togglable
        NoteInputForm(
          noteToEdit: noteToEdit,
        ),

        noteTiles,
      ],
    );
  }
}
