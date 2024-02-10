import 'package:flutter/material.dart';
import 'package:mental_health_diary/components/note_input_form.dart';
import 'package:mental_health_diary/components/note_tile.dart';
import 'package:mental_health_diary/components/icon_button_naked.dart';
import 'package:mental_health_diary/mock_data/mock_data_today.dart';

class NotesSection extends StatefulWidget {
  const NotesSection({super.key});

  @override
  State<NotesSection> createState() => _NotesSectionState();
}

class _NotesSectionState extends State<NotesSection> {
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
  Widget build(BuildContext context) {
    void editTile(BuildContext? tile) {}
    ;
    void deleteTile(BuildContext? tile) {}
    ;

    List<Widget> noteTiles = mockDataNotes.map((note) {
      return NoteTile(
          contents: note.contents, editTile: editTile, deleteTile: deleteTile);
    }).toList();

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

        // Existing notes
        Column(
          children: noteTiles,
        )
      ],
    );
  }
}
