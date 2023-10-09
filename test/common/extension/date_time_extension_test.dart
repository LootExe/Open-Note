import 'package:open_note/common/extension/date_time_extension.dart';
import 'package:test/test.dart';

void main() {
  group('DateTimeExtension', () {
    test('date should return date with zero time', () {
      final now = DateTime(2023, 02, 22, 15, 39, 11);

      final result = now.date;

      expect(result, DateTime(2023, 02, 22));
    });

    test('isToday should return true if specified day is today', () {
      final now = DateTime.now();

      final result = now.isToday;

      expect(result, true);
    });

    test('isToday should return false for any other day that is not today', () {
      final someDay = DateTime(1997, 12, 24, 23, 59, 59);

      final result = someDay.isToday;

      expect(result, false);
    });

    test('isYesterday should return true if specified day is yesterday', () {
      final yesterday = DateTime.now().subtract(const Duration(days: 1));

      final result = yesterday.isYesterday;

      expect(result, true);
    });

    test('isYesterday should not be today', () {
      final now = DateTime.now();

      final result = now.isYesterday;

      expect(result, false);
    });

    test('isYesterday should not be any other day', () {
      final someDay = DateTime(1997, 12, 24, 23, 59, 59);

      final result = someDay.isYesterday;

      expect(result, false);
    });

    test('isPast30Days should any day in the last 30 days', () {
      final now = DateTime.now();

      final result = now.isPast30Days;

      expect(result, true);
    });

    test('isPast30Days should not be a day > 30 days', () {
      final pastDay = DateTime.now().subtract(const Duration(days: 31));

      final result = pastDay.isPast30Days;

      expect(result, false);
    });

    test('daySuffix should be "st" on the 1, 21, 31 day of a month', () {
      final date1 = DateTime(2023);
      final date2 = DateTime(2023, 01, 21);
      final date3 = DateTime(2023, 01, 31);

      final result1 = date1.daySuffix;
      final result2 = date2.daySuffix;
      final result3 = date3.daySuffix;

      expect(result1, 'st');
      expect(result2, 'st');
      expect(result3, 'st');
    });

    test('daySuffix should be "nd" on the 2, 22 day of a month', () {
      final date1 = DateTime(2023, 01, 02);
      final date2 = DateTime(2023, 01, 22);

      final result1 = date1.daySuffix;
      final result2 = date2.daySuffix;

      expect(result1, 'nd');
      expect(result2, 'nd');
    });

    test('daySuffix should be "rd" on the 3, 23 day of a month', () {
      final date1 = DateTime(2023, 01, 03);
      final date2 = DateTime(2023, 01, 23);

      final result1 = date1.daySuffix;
      final result2 = date2.daySuffix;

      expect(result1, 'rd');
      expect(result2, 'rd');
    });

    test('daySuffix should be "th" for all other days of a month', () {
      final days = List.generate(31, (index) => index)
        ..removeWhere(
          (day) =>
              day == 0 ||
              day == 1 ||
              day == 2 ||
              day == 3 ||
              day == 21 ||
              day == 22 ||
              day == 23 ||
              day == 31,
        );

      final result =
          days.any((day) => DateTime(2023, 01, day).daySuffix != 'th');

      expect(result, false);
    });
  });
}
