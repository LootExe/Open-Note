// ignore_for_file: prefer_const_constructors, avoid_redundant_argument_values

import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';
import 'package:settings_provider/settings_provider.dart';
import 'package:settings_repository/settings_repository.dart';
import 'package:test/test.dart';

class MockSettingsProvider extends Mock implements SettingsProvider {}

class FakeSettings extends Fake implements Settings {}

void main() {
  group('SettingsRepository', () {
    late SettingsProvider provider;

    final settings = Settings(
      themeMode: ThemeMode.light,
      useMaterialYou: true,
      noteSortMode: NoteSortMode.manual,
      noteSortIds: const ['1'],
      language: 'en',
    );

    setUpAll(() {
      registerFallbackValue(FakeSettings());
    });

    setUp(() {
      provider = MockSettingsProvider();
      when(() => provider.readSettings()).thenAnswer(
        (_) => Future.value(settings),
      );
      when(() => provider.saveSettings(any())).thenAnswer((_) async {});
    });

    SettingsRepository createSubject() =>
        SettingsRepository(provider: provider);

    group('constructor', () {
      test('works properly', () {
        expect(
          createSubject,
          returnsNormally,
        );
      });
    });

    group('readSettings', () {
      test('returns correct settings data', () {
        expect(
          createSubject().readSettings(),
          completion(equals(settings)),
        );

        verify(() => provider.readSettings()).called(1);
      });
    });

    group('saveSettings', () {
      test('makes correct provider request', () {
        final newSettings = Settings(
          themeMode: ThemeMode.dark,
          useMaterialYou: false,
          noteSortMode: NoteSortMode.alphabeticalAscending,
          noteSortIds: const ['2', '3'],
          language: 'de',
        );

        final subject = createSubject();

        expect(subject.saveSettings(newSettings), completes);

        verify(() => provider.saveSettings(newSettings)).called(1);
      });
    });
  });
}
