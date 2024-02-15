import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final _noteEditingController = TextEditingController();
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

    void editNote(Note note) {
      _noteEditingController.text = note.contents;

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.background,
          contentTextStyle: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.zero),
          ),
          content: TextField(
            controller: _noteEditingController,
            maxLength: 300,
            maxLengthEnforcement:
                MaxLengthEnforcement.truncateAfterCompositionEnds,
            maxLines: null,
            scrollPadding: const EdgeInsets.all(96),
            decoration: const InputDecoration(
              hintText: "Add a note",
            ),
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Pop the dialog box
                Navigator.pop(context);

                // Clear the controller
                _noteEditingController.clear();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                // Get the new note contents
                final newContents = _noteEditingController.text;

                // Edit the record in the database
                notesDatabase.editNote(note.index, newContents);

                Navigator.pop(context);
                _noteEditingController.clear();
              },
              child: const Text("Add"),
            ),
          ],
        ),
      );
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
                editTile: (context) => editNote(note),
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
