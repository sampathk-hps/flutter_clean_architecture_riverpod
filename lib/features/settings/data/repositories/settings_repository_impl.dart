import '../../domain/entities/app_setting.dart';
import '../../domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final Map<String, String> _memory = <String, String>{};

  @override
  Future<List<AppSetting>> getSettings() async {
    return _memory.entries
        .map((entry) => AppSetting(key: entry.key, value: entry.value))
        .toList();
  }

  @override
  Future<void> saveSetting(AppSetting setting) async {
    _memory[setting.key] = setting.value;
  }
}
