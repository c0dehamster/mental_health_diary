import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:mental_health_diary/models/database/notes_database.dart';
import 'package:mental_health_diary/models/note.dart';

class NoteInputForm extends StatefulWidget {
  const NoteInputForm({
    super.key,
    required this.closeForm,
    this.noteToEdit,
  });

  final void Function() closeForm;
  final Note? noteToEdit;

  @override
  State<NoteInputForm> createState() => _NoteInputFormState();
}

class _NoteInputFormState extends State<NoteInputForm> {
  final _noteController = TextEditingController();
  final _noteInputFormKey = GlobalKey<FormState>();
  final notesDatabase = NotesDatabase();

  late final Box notesBox;

  var isAddEnabled = false;

  void _toggleSubmitButton() {
    final text = _noteController.text;

    setState(() {
      isAddEnabled = text.isNotEmpty;
    });
  }

  void _onSubmit() {
    if (widget.noteToEdit == null) {
      notesDatabase.addNote(_noteController.text);
    } else {
      // _editNote can be called only if the noteToEdit is provided
      notesDatabase.editNote(
        widget.noteToEdit!.index,
        _noteController.text,
      );
    }

    _noteController.clear();
    widget.closeForm();
  }

  @override
  void initState() {
    super.initState();

    // Open the box
    notesBox = Hive.box<Note>("notes");

    // Set the text field value if provided
    _noteController.text = widget.noteToEdit?.contents ?? "";

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
    final buttonText = widget.noteToEdit != null ? "Confirm" : "Add";

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
              maxLength: 300,
              maxLengthEnforcement:
                  MaxLengthEnforcement.truncateAfterCompositionEnds,
              maxLines: null,
              scrollPadding: const EdgeInsets.all(96),
              decoration: const InputDecoration(
                hintText: "Add a note",
              ),
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
                      _onSubmit();
                    }
                  },
                  child: Text(buttonText),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
