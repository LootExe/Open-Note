// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:open_note/settings/bloc/settings_bloc.dart';
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

  group('SettingsBloc', () {
    late SettingsRepository settingsRepository;

    setUpAll(() {
      registerFallbackValue(FakeSettings());
    });

    setUp(() {
      settingsRepository = MockSettingsRepository();
      when(() => settingsRepository.readSettings())
          .thenAnswer((_) async => Future.value(mockSettings));
      when(() => settingsRepository.saveSettings(any()))
          .thenAnswer((_) async {});
    });

    SettingsBloc buildBloc() {
      return SettingsBloc(repository: settingsRepository);
    }

    group('constructor', () {
      test('works properly', () => expect(buildBloc, returnsNormally));

      test('has correct initial state', () {
        expect(
          buildBloc().state,
          equals(const SettingsState()),
        );
      });
    });

    group('SettingsLoaded', () {
      blocTest<SettingsBloc, SettingsState>(
        'Repository readSettings is called successfuly',
        build: buildBloc,
        act: (bloc) => bloc.add(const SettingsLoaded()),
        verify: (_) {
          verify(() => settingsRepository.readSettings()).called(1);
        },
      );

      blocTest<SettingsBloc, SettingsState>(
        'emits State with updated status and settings',
        build: buildBloc,
        act: (bloc) => bloc.add(const SettingsLoaded()),
        expect: () => [
          const SettingsState(status: SettingsStatus.loading),
          const SettingsState(
            status: SettingsStatus.success,
            settings: mockSettings,
          ),
        ],
      );
    });

    group('SettingsChanged', () {
      blocTest<SettingsBloc, SettingsState>(
        'Repository saveSettings is called successfuly',
        build: buildBloc,
        act: (bloc) => bloc.add(SettingsChanged(Settings())),
        verify: (_) {
          verify(() => settingsRepository.saveSettings(any())).called(1);
        },
      );

      blocTest<SettingsBloc, SettingsState>(
        'emits state with changed settings',
        build: buildBloc,
        seed: () => SettingsState(settings: mockSettings),
        act: (bloc) => bloc.add(
          SettingsChanged(mockSettings.copyWith(themeMode: ThemeMode.dark)),
        ),
        expect: () => [
          SettingsState(
            settings: mockSettings.copyWith(themeMode: ThemeMode.dark),
          ),
        ],
      );
    });
  });
}
