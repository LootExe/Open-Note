// ignore_for_file: prefer_const_constructors, avoid_redundant_argument_values

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_settings_provider/local_settings_provider.dart';
import 'package:mocktail/mocktail.dart';
import 'package:settings_provider/settings_provider.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  group('LocalSettingsProvider', () {
    late SharedPreferences plugin;

    final settings = Settings(
      themeMode: ThemeMode.light,
      useMaterialYou: true,
      noteSortMode: NoteSortMode.manual,
      noteSortIds: const ['1'],
      language: 'en',
    );

    setUp(() {
      plugin = MockSharedPreferences();
      when(() => plugin.getString(any())).thenReturn(json.encode(settings));
      when(() => plugin.setString(any(), any())).thenAnswer((_) async => true);
    });

    LocalSettingsProvider createSubject() {
      return LocalSettingsProvider(plugin: plugin);
    }

    group('constructor', () {
      test('works properly', () {
        expect(
          createSubject,
          returnsNormally,
        );
      });

      group('readSettings', () {
        test('with existing settings if present', () {
          final subject = createSubject();

          expect(subject.readSettings(), completion(equals(settings)));
          verify(
            () => plugin.getString(LocalSettingsProvider.kSettingsKey),
          ).called(1);
        });

        test('with default settings if nothing is saved', () {
          when(() => plugin.getString(any())).thenReturn(null);

          final subject = createSubject();

          expect(subject.readSettings(), completion(equals(const Settings())));
          verify(
            () => plugin.getString(LocalSettingsProvider.kSettingsKey),
          ).called(1);
        });

        test('with default settings if corrupted json', () {
          when(() => plugin.getString(any())).thenReturn('corrupted date');

          final subject = createSubject();

          expect(subject.readSettings(), completion(equals(const Settings())));
          verify(
            () => plugin.getString(LocalSettingsProvider.kSettingsKey),
          ).called(1);
        });
      });
    });

    group('saveSettings', () {
      test('saves settings', () {
        final newSettings = Settings(
          themeMode: ThemeMode.dark,
          useMaterialYou: false,
          noteSortMode: NoteSortMode.alphabeticalAscending,
          noteSortIds: const ['2', '3'],
          language: 'de',
        );

        final subject = createSubject();

        expect(subject.saveSettings(newSettings), completes);
        expect(subject.readSettings(), completion(equals(newSettings)));

        verify(
          () => plugin.setString(
            LocalSettingsProvider.kSettingsKey,
            json.encode(newSettings),
          ),
        ).called(1);
      });
    });
  });
}
