import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_little_diary/data/models/models.dart';
import 'package:my_little_diary/data/repositories/settings_repository.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit({required this.settingsRepository}) : super(SettingsInitial());
  final SettingsRepository settingsRepository;
  void loadSettings() async {
    final settings = await settingsRepository.loadSettings();
    emit(SettingsLoaded(settings: settings));
  }

  void changeTheme(
      {required Settings currentSettings, required bool lightTheme}) async {
    await settingsRepository.changeSettings(
        settings: currentSettings.copyWith(lightTheme: lightTheme));
    loadSettings();
  }
}
