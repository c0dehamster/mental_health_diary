import 'package:flutter/material.dart';
import 'package:mental_health_diary/components/app_drawer.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              "Settings",
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
            child: Text("Settings"),
          )
        ],
      ),
    );
  }
}
