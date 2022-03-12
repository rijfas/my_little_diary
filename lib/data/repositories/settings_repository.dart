import 'package:hive/hive.dart';
import 'package:my_little_diary/data/models/models.dart';

class SettingsRepository {
  Future<Settings> loadSettings() async {
    final box = await Hive.openBox('settings');
    final settings = box.get('settings', defaultValue: Settings());
    await box.close();
    return settings;
  }

  Future<void> changeSettings({required Settings settings}) async {
    final box = await Hive.openBox('settings');
    await box.put('settings', settings);
    await box.close();
  }
}
