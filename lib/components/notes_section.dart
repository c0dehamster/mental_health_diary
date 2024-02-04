import 'package:flutter/material.dart';
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
        const Column(
          children: [
            Text("Empty"),
          ],
        )
      ],
    );
  }
}
