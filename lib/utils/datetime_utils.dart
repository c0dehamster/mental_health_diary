bool isCurrentDate(DateTime date1, DateTime date2) {
  if (date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day) return true;

  return false;
}

double getTimeAsHours(DateTime datetime) {
  return datetime.hour + datetime.minute / 60;
}
