// ignore_for_file: prefer_const_constructors, avoid_redundant_argument_values

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:settings_repository/settings_repository.dart';
import 'package:storage_provider/storage_provider.dart';

class MockStorageProvider extends Mock implements StorageProvider {}

class FakeSettings extends Fake implements Settings {}

void main() {
  group('SettingsRepository', () {
    late StorageProvider provider;

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
      provider = MockStorageProvider();
      when(() => provider.read(any()))
          .thenAnswer((_) => Future.value(json.encode(settings)));
      when(() => provider.write(any(), any())).thenAnswer((_) async {});
      when(() => provider.delete(any())).thenAnswer((_) async {});
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
      test('returns correct settings if storage data is available', () {
        expect(
          createSubject().readSettings(),
          completion(settings),
        );

        verify(() => provider.read(any())).called(1);
      });

      test('returns default settings if no storage data is available', () {
        when(() => provider.read(any())).thenAnswer((_) => Future.value());
        expect(
          createSubject().readSettings(),
          completion(const Settings()),
        );

        verify(() => provider.read(any())).called(1);
      });

      test('returns default settings if storage data is corrupt', () {
        when(() => provider.read(any()))
            .thenAnswer((_) => Future.value('oops'));
        expect(
          createSubject().readSettings(),
          completion(const Settings()),
        );

        verify(() => provider.read(any())).called(1);
      });
    });

    group('writeSettings', () {
      test('makes correct provider request', () {
        final newSettings = Settings(
          themeMode: ThemeMode.dark,
          useMaterialYou: false,
          noteSortMode: NoteSortMode.alphabeticalAscending,
          noteSortIds: const ['2', '3'],
          language: 'de',
        );

        expect(createSubject().writeSettings(newSettings), completes);

        verify(() => provider.write(any(), json.encode(newSettings))).called(1);
      });
    });

    group('clearSettings', () {
      test('makes correct provider request', () {
        expect(createSubject().clearSettings(), completes);
        verify(() => provider.delete(any())).called(1);
      });
    });

    group('clearSettings', () {
      test('settings are set to default after clear', () {
        final subject = createSubject()..clearSettings();
        expect(subject.settings, const Settings());
      });
    });
  });
}
