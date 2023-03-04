extension DateTimeExtension on DateTime {
  DateTime get date => DateTime(year, month, day);

  bool get isToday => date == DateTime.now().date;

  bool get isYesterday =>
      date == DateTime.now().subtract(const Duration(days: 1)).date;

  bool get isPast30Days =>
      isAfter(DateTime.now().subtract(const Duration(days: 30)).date);

  String get daySuffix {
    final digit = day % 10;
    var suffix = 'th';

    if ((digit > 0 && digit < 4) && (day < 11 || day > 13)) {
      suffix = ['st', 'nd', 'rd'][digit - 1];
    }

    return suffix;
  }
}
