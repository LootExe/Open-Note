import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:settings_repository/settings_repository.dart';

part 'settings_state.dart';
part 'settings_event.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository _repository;

  SettingsBloc({required SettingsRepository repository})
      : _repository = repository,
        super(SettingsState(settings: repository.settings)) {
    on<SettingsUpdated>(_onUpdated);
  }

  void _onUpdated(SettingsUpdated event, Emitter<SettingsState> emit) {
    _repository.saveSettings(event.settings);
    emit(state.copyWith(settings: event.settings));
  }
}
