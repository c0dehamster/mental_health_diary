import 'package:hive/hive.dart';

class FirstLaunchDate {
  final _firstLaunchDateBox = Hive.box<DateTime>("firstLaunchDate");

  // Save the first time the app was launched (for the heatmap)

  void saveFirstLaunchDate() {
    final firstLaunchDate = _firstLaunchDateBox.getAt(0);

    // If the app has not been launched before, set the current date
    if (firstLaunchDate == null) {
      _firstLaunchDateBox.add(DateTime.now());
    }
  }

  // Get the first launch date

  DateTime? get firstLaunchDate {
    return _firstLaunchDateBox.getAt(0);
  }

  // Reset the first launch date

  void resetFirstLaunchDate() {
    _firstLaunchDateBox.clear();
  }
}
