import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:mental_health_diary/models/database/mood_database.dart';
import 'package:mental_health_diary/models/mood_record.dart';
import 'package:mental_health_diary/pages/home_page.dart';
import 'package:mental_health_diary/theme/mood_spectre.dart';

enum AddButtonState { add, overwrite }

class MoodPicker extends StatefulWidget {
  const MoodPicker({
    super.key,
    required this.inputMode,
    required this.onAdd,
  });

  final InputMode inputMode;
  final void Function() onAdd;

  @override
  State<MoodPicker> createState() => _MoodPickerState();
}

class _MoodPickerState extends State<MoodPicker> {
  final moodDatabase = MoodDatabase();

  late final Box box;

  int? _moodValue;

  // Create a new mood record entry
  // If less than 15 min has passed since the last record, it will be overwritten

  _onSubmit() {
    if (widget.inputMode == InputMode.add) {
      if (_moodValue != null) {
        // Only try to create a new record if a value is chosen
        moodDatabase.addRecord(_moodValue!);

        // The timer determines which button should be displayed

        widget.onAdd();
      }
    } else {
      if (_moodValue != null && box.isNotEmpty) {
        // Only try to overwrite if the previous value exists
        moodDatabase.overwriteRecord(_moodValue!);
      }
    }

    setState(() {
      _moodValue = null;
    });
  }

  @override
  void initState() {
    super.initState();

    // Get reference to the mood records box
    box = Hive.box<MoodRecord>("records");
  }

  @override
  Widget build(BuildContext context) {
    // The emoji row

    const List<String> emojiAssets = [
      "lib/images/emoji_colored_pain.svg",
      "lib/images/emoji_colored_sad.svg",
      "lib/images/emoji_colored_neutral.svg",
      "lib/images/emoji_colored_okay.svg",
      "lib/images/emoji_colored_happy.svg",
    ];

    final List<Widget> emojis = emojiAssets
        .map((emoji) => SvgPicture.asset(emoji, width: 24, height: 24))
        .toList();

    // Depending on how much time has elapsed, one or another button label is displayed

    final buttonLabel = widget.inputMode == InputMode.add ? "Add" : "Overwrite";

    final buttonColor = _moodValue != null
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.tertiary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("How would you rate your mood?"),
            // The button is displayed as enabled only if a value is selected

            TextButton(
              onPressed: _onSubmit,
              style: ButtonStyle(
                foregroundColor: MaterialStatePropertyAll(buttonColor),
              ),
              child: Text(
                buttonLabel,
              ),
            ),
          ],
        ),

        const SizedBox(height: 32),

        // Emoji labels
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: emojis,
        ),

        // Mood select checkbox group
        Row(
          children: List<Widget>.generate(moodSpectre.length, (index) {
            return Expanded(
              child: Transform.scale(
                scale: 0.75,
                child: Radio<int>(
                    toggleable: true,
                    fillColor: MaterialStateProperty.all(moodSpectre[index]),
                    value: index,
                    groupValue: _moodValue,
                    onChanged: (value) {
                      setState(() {
                        _moodValue = value;
                      });
                    }),
              ),
            );
          }),
        ),
      ],
    );
  }
}
