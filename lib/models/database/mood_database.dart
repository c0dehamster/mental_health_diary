import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:mental_health_diary/models/app_settings.dart';
import 'package:mental_health_diary/models/mood_record.dart';
import 'package:path_provider/path_provider.dart';

class MoodDatabase extends ChangeNotifier {
  static late Isar isar;

  /* SETUP */

  /* Initialize the database */
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [MoodRecordSchema, AppSettingsSchema],
      directory: dir.path,
    );
  }

  /* Save the first time a record was created */

  Future<void> saveFirstRecordDate() async {
    final existingSettings = await isar.appSettings.where().findFirst();

    // If no date has been retrieved, save the date of the first record
    if (existingSettings == null) {
      final firstRecord = await isar.moodRecords.where().findFirst();

      if (firstRecord != null) {
        final settings = AppSettings()
          ..firstRecordDate = DateTime(
            firstRecord.timestamp.year,
            firstRecord.timestamp.month,
            firstRecord.timestamp.day,
          );

        await isar.writeTxn(() => isar.appSettings.put(settings));
      }
    }
  }

  // Get the first record date (for the heatmap)

  Future<DateTime?> getFirstRecordDate() async {
    final settings = await isar.appSettings.where().findFirst();
    return settings?.firstRecordDate;
  }
}
