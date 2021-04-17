import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/settings_repository.dart';
import '../model/settings_data.dart';

part 'settings_state.dart';
part 'settings_event.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository _repository;

  SettingsData get settings => _repository.settings;

  SettingsBloc(this._repository) : super(SettingsInitial(_repository.settings));

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
    _repository.writeSettings();

    yield SettingsChangeSuccess(settings);
  }
}
