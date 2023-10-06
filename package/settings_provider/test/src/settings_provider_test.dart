// ignore_for_file: prefer_const_constructors
import 'package:settings_provider/settings_provider.dart';
import 'package:test/test.dart';

class TestSettingsProvider implements SettingsProvider {
  TestSettingsProvider() : super();

  @override
  dynamic noSuchMethod(Invocation invocation) {
    return super.noSuchMethod(invocation);
  }
}

void main() {
  group('SettingsProvider', () {
    test('can be constructed', () {
      expect(TestSettingsProvider.new, returnsNormally);
    });
  });
}
