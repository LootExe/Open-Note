import 'package:test/test.dart';
import 'package:open_note/src/common/utils.dart';

void main() {
  test('getLocale returns null from null input', () {
    final result = Utils.getLocale(null);

    expect(result, isNull);
  });

  test('getLocale returns Locale with languageCode', () {
    const localeString = 'en';

    final result = Utils.getLocale(localeString);

    expect(result, isNotNull);
    expect(result!.languageCode, localeString);
  });

  test('getLocale returns Locale with languageCode, countryCode', () {
    const localeString = 'en_US';

    final result = Utils.getLocale(localeString);

    expect(result, isNotNull);
    expect(result!.languageCode, 'en');
    expect(result.countryCode, 'US');
  });

  test('getLocale returns Locale with languageCode, scriptCode, countryCode',
      () {
    const localeString = 'zh_Hans_SG';

    final result = Utils.getLocale(localeString);

    expect(result, isNotNull);
    expect(result!.languageCode, 'zh');
    expect(result.scriptCode, 'Hans');
    expect(result.countryCode, 'SG');
  });
}
