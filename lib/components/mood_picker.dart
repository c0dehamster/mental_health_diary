import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mental_health_diary/theme/mood_spectre.dart';

enum MoodValue { value1, value2 }

class MoodPicker extends StatefulWidget {
  const MoodPicker({super.key});

  @override
  State<MoodPicker> createState() => _MoodPickerState();
}

class _MoodPickerState extends State<MoodPicker> {
  int? _moodValue;

  @override
  Widget build(BuildContext context) {
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("How would you rate your mood?"),

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
