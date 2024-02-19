import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:mental_health_diary/models/database/mood_database.dart';
import 'package:mental_health_diary/models/mood_record.dart';
import 'package:mental_health_diary/pages/home_page.dart';
import 'package:mental_health_diary/utils/emoji_assets.dart';
import 'package:mental_health_diary/utils/mood_spectre.dart';
import 'package:provider/provider.dart';

import '../../theme/theme_provider.dart';

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
    // The mood picker colors depending on the theme

    final moodSpectre = getMoodSpectre(context);

    // The emoji row

    final emojiAssets =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode
            ? emojiAssetsOnDark
            : emojiAssetsOnLight;

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
        Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "How would you rate your mood?",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
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
        ),

        const SizedBox(height: 16),

        Container(
          padding: const EdgeInsets.only(top: 16),
          constraints: const BoxConstraints(maxWidth: 400),
          color: Theme.of(context).colorScheme.secondary,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: emojis,
              ),

              // Mood select checkbox group
              Row(
                mainAxisSize: MainAxisSize.min,
                children: List<Widget>.generate(moodSpectre.length, (index) {
                  return Expanded(
                    child: Transform.scale(
                      scale: 0.75,
                      child: Radio<int>(
                          toggleable: true,
                          fillColor:
                              MaterialStateProperty.all(moodSpectre[index]),
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
          ),
        )

        // Emoji labels
      ],
    );
  }
}
