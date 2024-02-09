import 'package:flutter/material.dart';
import 'package:mental_health_diary/components/note_tile.dart';
import 'package:mental_health_diary/components/icon_button_naked.dart';
import 'package:mental_health_diary/mock_data/mock_data_today.dart';

class NotesSection extends StatelessWidget {
  const NotesSection({super.key});

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
              onPressed: () {},
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
        const SizedBox(height: 48),
        Column(
          children: noteTiles,
        )
      ],
    );
  }
}
