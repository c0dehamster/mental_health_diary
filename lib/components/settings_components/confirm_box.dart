import 'package:flutter/material.dart';

class ConfirmBox extends StatelessWidget {
  const ConfirmBox({
    super.key,
    required this.alertMessage,
    required this.onConfirm,
  });

  final String alertMessage;
  final void Function() onConfirm;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      contentTextStyle: TextStyle(
        color: Theme.of(context).colorScheme.primary,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.zero),
      ),
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Text(alertMessage),
      ),
      actions: [
        TextButton(
          onPressed: onConfirm,
          child: const Text("Confirm"),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancel"),
        ),
      ],
    );
  }
}
