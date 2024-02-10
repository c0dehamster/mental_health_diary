import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mental_health_diary/models/note.dart';

class NoteInputForm extends StatefulWidget {
  const NoteInputForm({
    super.key,
    required this.closeForm,
  });

  final void Function() closeForm;

  @override
  State<NoteInputForm> createState() => _NoteInputFormState();
}

class _NoteInputFormState extends State<NoteInputForm> {
  final _noteController = TextEditingController();
  final _noteInputFormKey = GlobalKey<FormState>();

  late final Box notesBox;

  var isAddEnabled = false;

  void _toggleSubmitButton() {
    final text = _noteController.text;

    setState(() {
      isAddEnabled = text.isNotEmpty;
    });
  }

  void _addNote() {
    final text = _noteController.text;

    notesBox.add(
      Note(
        contents: text,
        timestamp: DateTime.timestamp(),
      ),
    );

    _noteController.clear();
    widget.closeForm();
  }

  @override
  void initState() {
    super.initState();

    // Open the box
    notesBox = Hive.box<Note>("notes");

    // Start listening to changes
    _noteController.addListener(_toggleSubmitButton);
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final buttonColor = isAddEnabled
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.tertiary;

    return Form(
      key: _noteInputFormKey,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
        ),
        child: Column(
          children: [
            TextFormField(
              controller: _noteController,
            ),

            // Control buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: widget.closeForm,
                  child: const Text("Cancel"),
                ),
                const SizedBox(width: 24),
                TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStatePropertyAll(buttonColor),
                  ),
                  onPressed: () {
                    if (isAddEnabled) {
                      _addNote();
                    }
                  },
                  child: const Text("Add"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
