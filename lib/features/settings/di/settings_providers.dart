import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/repositories/settings_repository_impl.dart';
import '../domain/repositories/settings_repository.dart';

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  return SettingsRepositoryImpl();
});
