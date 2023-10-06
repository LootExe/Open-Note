part of 'settings_bloc.dart';

sealed class SettingsEvent extends Equatable {
  const SettingsEvent();
}

final class SettingsLoaded extends SettingsEvent {
  const SettingsLoaded();

  @override
  List<Object?> get props => [];
}

final class SettingsChanged extends SettingsEvent {
  const SettingsChanged(this.settings);

  final Settings settings;

  @override
  List<Object?> get props => [settings];
}
