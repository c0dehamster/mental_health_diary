import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mental_health_diary/utils/breakpoints.dart';

class NoteTile extends StatelessWidget {
  const NoteTile({
    super.key,
    required this.contents,
    required this.editTile,
    required this.deleteTile,
  });

  final String contents;
  final void Function(BuildContext) editTile;
  final void Function(BuildContext) deleteTile;

  @override
  Widget build(BuildContext context) {
    final noteTileMobile = Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            // Edit option
            SlidableAction(
              onPressed: editTile,
              backgroundColor: Theme.of(context).colorScheme.tertiary,
              foregroundColor: Theme.of(context).colorScheme.secondary,
              icon: Icons.settings,
            ),

            // Delete option
            SlidableAction(
              onPressed: deleteTile,
              backgroundColor: Theme.of(context).colorScheme.secondary,
              foregroundColor: Theme.of(context).colorScheme.tertiary,
              icon: Icons.delete,
            )
          ],
        ),
        child: Container(
          width: double.infinity,
          decoration:
              BoxDecoration(color: Theme.of(context).colorScheme.secondary),
          padding: const EdgeInsets.all(16),
          child: Text(
            contents,
            style: TextStyle(
              height: 2,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
    );

    final noteTileDesktop = Container(
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondary),
      width: 300,
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Text(
              contents,
              style: TextStyle(
                height: 2,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () => editTile(context),
                  icon: const Icon(Icons.settings),
                ),
                const SizedBox(width: 16),
                IconButton(
                  onPressed: () => deleteTile(context),
                  icon: const Icon(Icons.delete),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < Breakpoints.large) {
        return noteTileMobile;
      } else {
        return noteTileDesktop;
      }
    });
  }
}
