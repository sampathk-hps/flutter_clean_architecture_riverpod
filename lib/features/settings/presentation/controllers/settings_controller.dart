import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../di/settings_providers.dart';
import '../../domain/entities/app_setting.dart';

final settingsControllerProvider =
    AsyncNotifierProvider<SettingsController, List<AppSetting>>(
      SettingsController.new,
    );

class SettingsController extends AsyncNotifier<List<AppSetting>> {
  @override
  Future<List<AppSetting>> build() async {
    return ref.read(settingsRepositoryProvider).getSettings();
  }
}
