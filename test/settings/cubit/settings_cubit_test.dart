// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:open_note/settings/cubit/settings_cubit.dart';
import 'package:settings_repository/settings_repository.dart';

class MockSettingsRepository extends Mock implements SettingsRepository {}

class FakeSettings extends Fake implements Settings {}

void main() {
  const mockSettings = Settings(
    themeMode: ThemeMode.light,
    useMaterialYou: true,
    noteSortMode: NoteSortMode.manual,
    noteSortIds: ['1'],
    language: 'en',
  );

  group('SettingsCubit', () {
    late SettingsRepository repository;

    setUpAll(() {
      registerFallbackValue(FakeSettings());
    });

    setUp(() {
      repository = MockSettingsRepository();
      when(() => repository.settings).thenReturn(mockSettings);
      when(() => repository.readSettings())
          .thenAnswer((_) => Future.value(mockSettings));
      when(() => repository.writeSettings(any())).thenAnswer((_) async {});
    });

    SettingsCubit buildSubject() => SettingsCubit(repository: repository);

    group('constructor', () {
      test('works properly', () => expect(buildSubject, returnsNormally));

      test('has correct initial state', () {
        expect(
          buildSubject().state,
          equals(mockSettings),
        );
      });
    });

    group('save', () {
      blocTest<SettingsCubit, Settings>(
        'Repository writeSettings is called successfuly',
        build: buildSubject,
        act: (cubit) => cubit.save(const Settings()),
        verify: (_) {
          verify(() => repository.writeSettings(const Settings())).called(1);
        },
      );

      blocTest<SettingsCubit, Settings>(
        'emits state as changed settings',
        build: buildSubject,
        seed: () => mockSettings,
        act: (cubit) =>
            cubit.save(mockSettings.copyWith(themeMode: ThemeMode.dark)),
        expect: () => [mockSettings.copyWith(themeMode: ThemeMode.dark)],
      );
    });
  });
}
