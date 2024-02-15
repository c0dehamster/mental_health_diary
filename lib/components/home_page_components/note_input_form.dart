import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:mental_health_diary/models/database/notes_database.dart';
import 'package:mental_health_diary/models/note.dart';

class NoteInputForm extends StatefulWidget {
  const NoteInputForm({
    super.key,
    this.noteToEdit,
  });

  final Note? noteToEdit;

  @override
  State<NoteInputForm> createState() => _NoteInputFormState();
}

class _NoteInputFormState extends State<NoteInputForm> {
  final _noteController = TextEditingController();
  final _noteInputFormKey = GlobalKey<FormState>();
  final notesDatabase = NotesDatabase();

  late final Box notesBox;

  var isEditing = false;

  void _toggleSubmitButton() {
    final text = _noteController.text;

    setState(() {
      isEditing = text.isNotEmpty;
    });
  }

  void _onSubmit() {
    if (widget.noteToEdit != null) {
      // _editNote can be called only if the noteToEdit is provided
      notesDatabase.editNote(
        widget.noteToEdit!.index,
        _noteController.text,
      );
    } else {
      notesDatabase.addNote(_noteController.text);
    }

    _noteController.clear();
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

    Widget controlButtons = isEditing
        ? Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                onPressed: () {},
                child: const Text("Cancel"),
              ),
              const SizedBox(width: 24),
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                onPressed: _onSubmit,
                child: Text(buttonText),
              ),
            ],
          )
        : Container();

    return Form(
      key: _noteInputFormKey,
      child: Container(
        padding: const EdgeInsets.all(24),
        margin: const EdgeInsets.only(bottom: 72),
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

            const SizedBox(height: 8),

            // Control buttons

            controlButtons,
          ],
        ),
      ),
    );
  }
}
