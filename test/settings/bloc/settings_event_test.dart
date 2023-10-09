// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_note/settings/bloc/settings_bloc.dart';
import 'package:settings_repository/settings_repository.dart';

void main() {
  group('SettingsEvent', () {
    const mockSettings = Settings(
      themeMode: ThemeMode.light,
      useMaterialYou: true,
      noteSortMode: NoteSortMode.manual,
      noteSortIds: ['1'],
      language: 'en',
    );

    group('SettingsLoaded', () {
      test('supports value equality', () {
        expect(
          SettingsLoaded(),
          equals(SettingsLoaded()),
        );
      });

      test('props are correct', () {
        expect(
          SettingsLoaded().props,
          equals(<Object?>[]),
        );
      });
    });

    group('SettingsChanged', () {
      test('supports value equality', () {
        expect(
          SettingsChanged(mockSettings),
          equals(SettingsChanged(mockSettings)),
        );
      });

      test('props are correct', () {
        expect(
          SettingsChanged(mockSettings).props,
          equals([
            mockSettings, // settings
          ]),
        );
      });

      test('settings are set correctly', () {
        final subject = SettingsChanged(mockSettings);

        expect(subject.settings, equals(mockSettings));
      });
    });
  });
}
