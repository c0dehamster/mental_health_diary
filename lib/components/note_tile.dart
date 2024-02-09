import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class NoteTile extends StatelessWidget {
  const NoteTile({
    super.key,
    required this.contents,
    required this.editTile,
    required this.deleteTile,
  });

  final String contents;
  final void Function(BuildContext?) editTile;
  final void Function(BuildContext?) deleteTile;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            // Edit option
            SlidableAction(
              onPressed: editTile,
              backgroundColor: Theme.of(context).colorScheme.tertiary,
              icon: Icons.settings,
            ),

            // Delete option
            SlidableAction(
              onPressed: deleteTile,
              backgroundColor: Theme.of(context).colorScheme.secondary,
              icon: Icons.delete,
            )
          ],
        ),
        child: Container(
          decoration:
              BoxDecoration(color: Theme.of(context).colorScheme.secondary),
          padding: const EdgeInsets.all(16),
          child: Text(
            contents,
            style: const TextStyle(height: 2),
          ),
        ),
      ),
    );
  }
}
