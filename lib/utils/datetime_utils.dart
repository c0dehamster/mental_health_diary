double getTimeAsHours(DateTime datetime) {
  return datetime.hour + datetime.minute / 60;
}

// Months are represented as a map rather than an array to avoid dealing with 0-indexing

final months = {
  1: "January",
  2: "February",
  3: 'March',
  4: "April",
  5: "May",
  6: "June",
  7: "July",
  8: "August",
  9: "September",
  10: "October",
  11: "November",
  12: "December",
};
