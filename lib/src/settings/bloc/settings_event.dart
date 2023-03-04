part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();
}

class SettingsUpdated extends SettingsEvent {
  final Settings settings;

  @override
  List<Object?> get props => [settings];

  const SettingsUpdated(this.settings);
}
