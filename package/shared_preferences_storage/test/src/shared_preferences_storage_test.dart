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

      group('read', () {
        test('with existing value if present', () {
          final subject = createSubject();

          expect(subject.read(testKey), completion(equals(testValue)));
          verify(() => preferences.getString(testKey)).called(1);
        });

        test('with null value if nothing is saved', () {
          when(() => preferences.getString(any())).thenReturn(null);

          final subject = createSubject();

          expect(subject.read(testKey), completion(isNull));
          verify(() => preferences.getString(testKey)).called(1);
        });
      });
    });

    group('write', () {
      test('write value completes normally', () {
        final subject = createSubject();

        expect(subject.write(testKey, testValue), completes);
        verify(() => preferences.setString(testKey, testValue)).called(1);
      });
    });

    group('delete', () {
      test('delete value completes normally', () {
        final subject = createSubject();

        expect(subject.delete(testKey), completes);
        verify(() => preferences.remove(testKey)).called(1);
      });
    });

    group('clear', () {
      test('clear preferences completes normally', () {
        final subject = createSubject();

        expect(subject.clear(), completes);
        verify(() => preferences.clear()).called(1);
      });
    });

    group('close', () {
      test('completes normally', () {
        final subject = createSubject();

        expect(subject.close(), completes);
      });
    });
  });
}
