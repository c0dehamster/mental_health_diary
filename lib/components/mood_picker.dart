import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:mental_health_diary/models/mood_record.dart';
import 'package:mental_health_diary/theme/mood_spectre.dart';

enum AddButtonState { add, overwrite }

class MoodPicker extends StatefulWidget {
  const MoodPicker({super.key});

  @override
  State<MoodPicker> createState() => _MoodPickerState();
}

class _MoodPickerState extends State<MoodPicker> {
  late final Box box;

  int? _moodValue;

  var addButtonState = AddButtonState.add;

  // Create a new mood record entry
  // Ideally, it should also clear the radio group, but I am not sure how to implement this

  _addRecord() async {
    if (_moodValue != null) {
      // Only try to create a new record if a value is chosen
      var newRecord = MoodRecord(
        value: _moodValue!,
        timestamp: DateTime.timestamp(),
      );

      box.add(newRecord);
      setState(() {
        addButtonState = AddButtonState.overwrite;
        _moodValue = null;
      });

      // The timer determines which button should be displayed

      final timer = Timer(const Duration(minutes: 1), () {
        setState(() {
          addButtonState = AddButtonState.add;
        });
      });

      timer;
    }
  }

  // If less than 15 min has passed since the last record, it will be overwritten

  _overwriteRecord() async {
    if (_moodValue != null && box.isNotEmpty) {
      // Only try to create a new record if a value is chosen
      var newRecord = MoodRecord(
        value: _moodValue!,
        timestamp: DateTime.timestamp(),
      );

      setState(() {
        _moodValue = null;
      });

      box.deleteAt(box.length - 1);
      box.add(newRecord);
    }
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

    // Depending on how much time has elapsed, one or another button is displayed

    Widget addButton = TextButton(
      onPressed: () {
        _addRecord();
      },
      child: const Text("Add"),
    );

    Widget overwriteButton = TextButton(
      onPressed: () {
        _overwriteRecord();
      },
      child: const Text("Overwrite"),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("How would you rate your mood?"),
            // The button should be enabled only if a value is selected

            addButtonState == AddButtonState.add ? addButton : overwriteButton,
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
