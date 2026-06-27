extension DateExtensions on DateTime {
  DateTime get dateOnly => DateTime(year, month, day);

  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  bool isYesterday(DateTime other) {
    final yesterday = dateOnly.subtract(const Duration(days: 1));
    return yesterday.isSameDay(other.dateOnly);
  }

  int daysBetween(DateTime other) {
    return dateOnly.difference(other.dateOnly).inDays.abs();
  }
}
