import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mental_health_diary/components/note_input_form.dart';
import 'package:mental_health_diary/components/note_tile.dart';
import 'package:mental_health_diary/components/icon_button_naked.dart';
import 'package:mental_health_diary/utils/datetime_utils.dart';

import '../models/note.dart';

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

  bool isFormShown = false;

  void _toggleFormVisibility(bool value) {
    setState(() {
      isFormShown = value;
    });
  }

  void _showForm() {
    _toggleFormVisibility(true);
  }

  @override
  void initState() {
    super.initState();

    notesBox = Hive.box<Note>("notes");
  }

  @override
  Widget build(BuildContext context) {
    void editTile(BuildContext? tile) {}
    ;
    void deleteTile(BuildContext? tile) {}
    ;

    Widget notesList = ValueListenableBuilder(
      valueListenable: notesBox.listenable(),
      builder: (context, value, child) {
        List<Note> notes = notesBox.toMap().values.toList() as List<Note>;

        // Notes to display according to the date
        List<Note> currentDateNotes = [];

        for (final note in notes) {
          if (isCurrentDate(note.timestamp, widget.dateToDisplay)) {
            currentDateNotes.add(note);
          }
        }

        if (currentDateNotes.isEmpty) return Container();

        List<Widget> noteTiles = currentDateNotes.map((note) {
          return NoteTile(
              contents: note.contents,
              editTile: editTile,
              deleteTile: deleteTile);
        }).toList();

        return Column(
          children: noteTiles,
        );
      },
    );

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButtonNaked(
              onPressed: _showForm,
              label: "Add note",
              icon: Icons.add,
            ),
            IconButtonNaked(
              onPressed: () {},
              label: "View notes",
              icon: Icons.expand_more,
            ),
          ],
        ),

        // New note input, togglable
        isFormShown
            ? NoteInputForm(
                closeForm: () => _toggleFormVisibility(false),
              )
            : Container(),
        const SizedBox(height: 48),

        notesList,
      ],
    );
  }
}
