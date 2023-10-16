// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences_storage/shared_preferences_storage.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  group('SharedPreferencesStorage', () {
    late SharedPreferences preferences;

    const testKey = 'testKey';
    const testValue = 'testValue';

    setUp(() {
      preferences = MockSharedPreferences();
      when(() => preferences.getKeys()).thenReturn({testKey});
      when(() => preferences.getString(any())).thenReturn(testValue);
      when(() => preferences.setString(any(), any()))
          .thenAnswer((_) async => true);
      when(() => preferences.remove(any())).thenAnswer((_) async => true);
      when(() => preferences.clear()).thenAnswer((_) async => true);
    });

    SharedPreferencesStorage createSubject() =>
        SharedPreferencesStorage(preferences: preferences);

    group('constructor', () {
      test('works properly', () {
        expect(
          createSubject,
          returnsNormally,
        );
      });

      group('readKeys', () {
        test('with existing keys if present', () {
          expect(createSubject().readKeys(), completion({testKey}));
          verify(() => preferences.getKeys()).called(1);
        });

        test('with empty set if no keys are present', () {
          when(() => preferences.getKeys()).thenReturn({});

          expect(createSubject().readKeys(), completion(<String>{}));
          verify(() => preferences.getKeys()).called(1);
        });
      });

      group('read', () {
        test('with existing value if present', () {
          expect(createSubject().read(testKey), completion(testValue));
          verify(() => preferences.getString(testKey)).called(1);
        });

        test('with null value if nothing is saved', () {
          when(() => preferences.getString(any())).thenReturn(null);

          expect(createSubject().read(testKey), completion(isNull));
          verify(() => preferences.getString(testKey)).called(1);
        });
      });
    });

    group('write', () {
      test('write value completes normally', () {
        expect(createSubject().write(testKey, testValue), completes);
        verify(() => preferences.setString(testKey, testValue)).called(1);
      });
    });

    group('delete', () {
      test('delete value completes normally', () {
        expect(createSubject().delete(testKey), completes);
        verify(() => preferences.remove(testKey)).called(1);
      });
    });

    group('clear', () {
      test('clear preferences completes normally', () {
        expect(createSubject().clear(), completes);
        verify(() => preferences.clear()).called(1);
      });
    });

    group('close', () {
      test('completes normally', () {
        expect(createSubject().close(), completes);
      });
    });
  });
}
