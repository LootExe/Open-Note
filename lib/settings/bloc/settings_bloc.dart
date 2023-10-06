import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:settings_repository/settings_repository.dart';

part 'settings_state.dart';
part 'settings_event.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc({required SettingsRepository repository})
      : _repository = repository,
        super(const SettingsState()) {
    on<SettingsLoaded>(_onLoaded);
    on<SettingsChanged>(_onChanged);
  }

  final SettingsRepository _repository;

  Future<void> _onLoaded(
    SettingsLoaded event,
    Emitter<SettingsState> emit,
  ) async {
    emit(state.copyWith(status: SettingsStatus.loading));

    final settings = await _repository.readSettings();

    emit(state.copyWith(status: SettingsStatus.success, settings: settings));
  }

  Future<void> _onChanged(
    SettingsChanged event,
    Emitter<SettingsState> emit,
  ) async {
    await _repository.saveSettings(event.settings);
    emit(state.copyWith(settings: event.settings));
  }
}
