import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'router/app_router.dart';
import '../core/di/connectivity_providers.dart';
import '../core/di/storage_providers.dart';
import '../core/theme/app_theme.dart';
import '../features/sync/di/sync_providers.dart';

class JobManagementApp extends ConsumerStatefulWidget {
  const JobManagementApp({super.key});

  @override
  ConsumerState<JobManagementApp> createState() => _JobManagementAppState();
}

class _JobManagementAppState extends ConsumerState<JobManagementApp> {
  @override
  void initState() {
    super.initState();

    unawaited(_initServices());
  }

  Future<void> _initServices() async {
    await ref.read(connectivityServiceProvider).initialize();
    ref.read(syncManagerProvider).start();
  }

  @override
  void dispose() {
    unawaited(ref.read(isarServiceProvider).close());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'Field Service',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
