import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'core/config/app_config.dart';
import 'core/database/isar_service.dart';
import 'core/di/storage_providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppConfig.validate();

  final isarService = await IsarService.open();

  runApp(
    ProviderScope(
      overrides: [isarServiceProvider.overrideWithValue(isarService)],
      child: const JobManagementApp(),
    ),
  );
}
