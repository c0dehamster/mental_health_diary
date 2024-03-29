import 'package:flutter/material.dart';
import 'package:mental_health_diary/components/app_drawer.dart';
import 'package:mental_health_diary/components/calendar_page_components/calendar.dart';
import 'package:mental_health_diary/components/info_block.dart';
import 'package:mental_health_diary/components/toggle_theme_button.dart';
import 'package:mental_health_diary/models/database/first_launch_date.dart';
import 'package:mental_health_diary/models/database/mood_database.dart';
import 'package:mental_health_diary/utils/breakpoints.dart';
import 'package:mental_health_diary/utils/datetime_utils.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final moodDatabase = MoodDatabase();
  final firstLaunchDate = FirstLaunchDate();

  final today = DateTime.now();

  late DateTime displayedDate;

  var isDateInfoShown = false;

  void setDisplayedDate(DateTime date) {
    setState(() {
      displayedDate = date;
      isDateInfoShown = true;
    });
  }

  void hideDisplayedDate() {
    setState(() {
      isDateInfoShown = false;
    });
  }

  @override
  void initState() {
    super.initState();

    // By default, the current date is displayed
    displayedDate = today;
  }

  @override
  Widget build(BuildContext context) {
    final initDate = firstLaunchDate.firstLaunchDate ?? today;

    final pageTitle = "${months[displayedDate.month]} ${displayedDate.day}";

    // Display a particular date

    final Widget infoSection = Container(
      padding: const EdgeInsets.only(top: 16),
      margin: const EdgeInsets.only(top: 64),
      decoration: BoxDecoration(
        border: BorderDirectional(
          top: BorderSide(color: Theme.of(context).colorScheme.primary),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                pageTitle,
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              IconButton(
                color: Theme.of(context).colorScheme.primary,
                onPressed: hideDisplayedDate,
                icon: const Icon(Icons.close_sharp),
              ),
            ],
          ),
          const SizedBox(height: 48),
          InfoBlock(dateToDisplay: displayedDate),
        ],
      ),
    );

    final pageContents = [
      Calendar(
        initDate: initDate,
        datasets: moodDatabase.averageValuesAll,
        onDateSelect: setDisplayedDate,
      ),
      isDateInfoShown ? infoSection : Container(),
    ];

    final layoutMobile = ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      children: pageContents,
    );

    final layoutTablet = ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: 64,
        vertical: 48,
      ),
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: pageContents,
            ),
          ),
        ),
      ],
    );

    final layoutDesktop = ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: 64,
        vertical: 48,
      ),
      children: pageContents,
    );

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          backgroundColor: Theme.of(context).colorScheme.background,
          foregroundColor: Theme.of(context).colorScheme.primary,
          toolbarHeight: 72,
          leadingWidth: 64,
          centerTitle: true,
          titleSpacing: 0,

          // Date navigator
          title: const Text(
            "Your monthly report",
            style: TextStyle(fontSize: 14),
          ),
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 16),
                child: ToggleThemeButton(context: context)),
          ],
        ),
        drawer: const AppDrawer(),
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < Breakpoints.medium) {
              return layoutMobile;
            } else if (constraints.maxWidth < Breakpoints.large) {
              return layoutTablet;
            } else {
              return layoutDesktop;
            }
          },
        ),
      ),
    );
  }
}
