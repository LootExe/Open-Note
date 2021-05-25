import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/settings_data.dart';
import '../repository/settings_repository.dart';

part 'settings_state.dart';
part 'settings_event.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc({required SettingsRepository repository})
      : this._repository = repository,
        super(SettingsInitial(repository.settings));

  final SettingsRepository _repository;

  SettingsData get settings => _repository.settings;

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    if (event is SettingsLoaded) {
      yield* _mapSettingsLoadedToState();
    }

    if (event is SettingsChanged) {
      yield* _mapSettingsChangedToState();
    }
  }

  Stream<SettingsState> _mapSettingsLoadedToState() async* {
    yield SettingsLoadSuccess(settings);
  }

  Stream<SettingsState> _mapSettingsChangedToState() async* {
    await _repository.writeSettings();

    yield SettingsChangeSuccess(settings);
  }
}
