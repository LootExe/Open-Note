// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/material.dart';
import 'package:settings_provider/src/model/settings.dart';
import 'package:test/test.dart';

void main() {
  group('Settings tests', () {
    Settings createSubject({
      ThemeMode themeMode = ThemeMode.dark,
      bool useMaterialYou = true,
      NoteSortMode noteSortMode = NoteSortMode.manual,
      List<String> noteSortIds = const ['1'],
      String? language = 'en',
    }) {
      return Settings(
        themeMode: themeMode,
        useMaterialYou: useMaterialYou,
        noteSortMode: noteSortMode,
        noteSortIds: noteSortIds,
        language: language,
      );
    }

    group('constructor', () {
      test('works correctly', () {
        expect(
          createSubject,
          returnsNormally,
        );
      });
    });

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
          ThemeMode.dark, // themeMode
          true, // useMaterialYou
          NoteSortMode.manual, // noteSortMode
          const ['1'], // noteSortIds
          'en', // language
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
            themeMode: null,
            useMaterialYou: null,
            noteSortMode: null,
            noteSortIds: null,
            language: null,
          ),
          equals(createSubject()),
        );
      });

      test('replaces every non-null parameter', () {
        expect(
          createSubject().copyWith(
            themeMode: ThemeMode.light,
            useMaterialYou: false,
            noteSortMode: NoteSortMode.editDate,
            noteSortIds: const ['2', '3'],
            language: () => 'de',
          ),
          equals(
            createSubject(
              themeMode: ThemeMode.light,
              useMaterialYou: false,
              noteSortMode: NoteSortMode.editDate,
              noteSortIds: const ['2', '3'],
              language: 'de',
            ),
          ),
        );
      });
    });

    group('Json serialization', () {
      test('from Json works correctly', () {
        expect(
          Settings.fromJson(const <String, dynamic>{
            'themeMode': 'dark',
            'useMaterialYou': true,
            'noteSortMode': 'manual',
            'noteSortIds': ['1'],
            'language': 'en',
          }),
          equals(createSubject()),
        );
      });

      test('to Json works correctly', () {
        expect(
          createSubject().toJson(),
          equals(const <String, dynamic>{
            'themeMode': 'dark',
            'useMaterialYou': true,
            'noteSortMode': 'manual',
            'noteSortIds': ['1'],
            'language': 'en',
          }),
        );
      });
    });
  });
}
