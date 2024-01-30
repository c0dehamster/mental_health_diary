import 'package:flutter/material.dart';
import 'package:mental_health_diary/components/app_drawer.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        toolbarHeight: 72,
        leadingWidth: 64,
        centerTitle: true,
        titleSpacing: 0,

        // Date navigator
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.chevron_left),
            ),
            const Text(
              "January",
              style: TextStyle(fontSize: 14),
            ), // Replace later with the actual date
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.chevron_right),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.sunny),
            ),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: ListView(
        children: const [
          Center(
            child: Text("Calendar goes here"),
          )
        ],
      ),
    );
  }
}
