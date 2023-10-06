part of 'settings_bloc.dart';

enum SettingsStatus { initial, loading, success, failure }

final class SettingsState extends Equatable {
  const SettingsState({
    this.status = SettingsStatus.initial,
    this.settings = const Settings(),
  });

  final SettingsStatus status;
  final Settings settings;

  SettingsState copyWith({SettingsStatus? status, Settings? settings}) {
    return SettingsState(
      status: status ?? this.status,
      settings: settings ?? this.settings,
    );
  }

  @override
  List<Object?> get props => [status, settings];
}
