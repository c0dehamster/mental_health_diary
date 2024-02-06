import 'package:flutter/material.dart';

class NoteTile extends StatelessWidget {
  const NoteTile({
    super.key,
    required this.contents,
  });

  final String contents;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondary),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 24),
      child: Text(contents),
    );
  }
}
