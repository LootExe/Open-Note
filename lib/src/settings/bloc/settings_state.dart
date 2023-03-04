part of 'settings_bloc.dart';

class SettingsState extends Equatable {
  final Settings settings;

  @override
  List<Object?> get props => [settings];

  const SettingsState({
    this.settings = const Settings(),
  });

  SettingsState copyWith({Settings? settings}) {
    return SettingsState(settings: settings ?? this.settings);
  }
}
