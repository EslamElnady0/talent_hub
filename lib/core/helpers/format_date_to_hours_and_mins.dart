String formatDateToHoursAndMins(DateTime dateTime) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitHours = twoDigits(dateTime.hour);
  String twoDigitMinutes = twoDigits(dateTime.minute);
  return [twoDigitHours, twoDigitMinutes].join(":");
}
