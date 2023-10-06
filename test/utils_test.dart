import 'package:open_note/common/utils.dart';
import 'package:test/test.dart';

void main() {
  test('getLocale returns null from null input', () {
    final result = parseLocale(null);

    expect(result, isNull);
  });

  test('getLocale returns Locale with languageCode', () {
    const localeString = 'en';

    final result = parseLocale(localeString);

    expect(result, isNotNull);
    expect(result!.languageCode, localeString);
  });

  test('getLocale returns Locale with languageCode, countryCode', () {
    const localeString = 'en_US';

    final result = parseLocale(localeString);

    expect(result, isNotNull);
    expect(result!.languageCode, 'en');
    expect(result.countryCode, 'US');
  });

  test('getLocale returns Locale with languageCode, scriptCode, countryCode',
      () {
    const localeString = 'zh_Hans_SG';

    final result = parseLocale(localeString);

    expect(result, isNotNull);
    expect(result!.languageCode, 'zh');
    expect(result.scriptCode, 'Hans');
    expect(result.countryCode, 'SG');
  });
}
