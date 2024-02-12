import 'package:flutter/material.dart';

class IconButtonNaked extends StatelessWidget {
  const IconButtonNaked({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.label,
  });

  final VoidCallback onPressed;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Row(
        // This is how you compress a row/column to its intrinsic size

        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label),
          const SizedBox(width: 12),
          Icon(icon),
        ],
      ),
    );
  }
}
