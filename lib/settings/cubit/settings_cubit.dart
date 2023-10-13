import 'package:bloc/bloc.dart';
import 'package:settings_repository/settings_repository.dart';

class SettingsCubit extends Cubit<Settings> {
  SettingsCubit({required SettingsRepository repository})
      : _repository = repository,
        super(repository.settings);

  final SettingsRepository _repository;

  Future<void> save(Settings settings) async {
    await _repository.writeSettings(settings);
    emit(settings);
  }
}
