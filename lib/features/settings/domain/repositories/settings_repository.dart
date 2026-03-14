import '../entities/app_setting.dart';

abstract class SettingsRepository {
  Future<List<AppSetting>> getSettings();
  Future<void> saveSetting(AppSetting setting);
}
