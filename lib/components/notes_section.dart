import 'package:flutter/material.dart';
import 'package:mental_health_diary/components/note_tile.dart';
import 'package:mental_health_diary/components/icon_button_naked.dart';

class NotesSection extends StatelessWidget {
  const NotesSection({super.key});

  @override
  Widget build(BuildContext context) {
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
        const SizedBox(height: 64),
        const Column(
          children: [
            NoteTile(
                contents:
                    "Lorem ipsum dolor sit amet consectetur adipisicing elit."),
            NoteTile(
                contents:
                    "Lorem ipsum dolor sit amet consectetur adipisicing elit."),
            NoteTile(
                contents:
                    "Lorem ipsum dolor sit amet consectetur adipisicing elit."),
          ],
        )
      ],
    );
  }
}
