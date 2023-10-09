// ignore_for_file: prefer_const_constructors, avoid_redundant_argument_values

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_note/settings/bloc/settings_bloc.dart';
import 'package:settings_repository/settings_repository.dart';

void main() {
  const mockSettings = Settings(
    themeMode: ThemeMode.light,
    useMaterialYou: true,
    noteSortMode: NoteSortMode.manual,
    noteSortIds: ['1'],
    language: 'en',
  );

  group('SettingsState', () {
    SettingsState createSubject({
      SettingsStatus status = SettingsStatus.loading,
      Settings settings = mockSettings,
    }) {
      return SettingsState(
        status: status,
        settings: settings,
      );
    }

    test('supports value equality', () {
      expect(
        createSubject(),
        equals(createSubject()),
      );
    });

    test('props are correct', () {
      expect(
        createSubject().props,
        equals([
          SettingsStatus.loading, // status
          mockSettings, // settings
        ]),
      );
    });

    group('copyWith', () {
      test('returns the same object if no arguments are provided', () {
        expect(
          createSubject().copyWith(),
          equals(createSubject()),
        );
      });

      test('retains the old value for every parameter if null is provided', () {
        expect(
          createSubject().copyWith(
            status: null,
            settings: null,
          ),
          equals(createSubject()),
        );
      });

      test('replaces every non-null parameter', () {
        expect(
          createSubject().copyWith(
            status: SettingsStatus.success,
            settings: const Settings(
              language: 'es',
              noteSortMode: NoteSortMode.alphabeticalDescending,
              themeMode: ThemeMode.light,
              useMaterialYou: false,
            ),
          ),
          equals(
            createSubject(
              status: SettingsStatus.success,
              settings: const Settings(
                language: 'es',
                noteSortMode: NoteSortMode.alphabeticalDescending,
                themeMode: ThemeMode.light,
                useMaterialYou: false,
              ),
            ),
          ),
        );
      });
    });
  });
}
