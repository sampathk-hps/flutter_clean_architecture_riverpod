import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_paths.dart';
import '../../../../core/di/storage_providers.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../features/sync/di/sync_providers.dart';
import '../../../../shared/widgets/primary_button.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Padding(
        padding: AppSpacing.paddingAllLg,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PrimaryButton(
              label: 'Run Sync Now',
              onPressed: () => ref.read(syncManagerProvider).syncNow(),
            ),
            const SizedBox(height: AppSpacing.md),
            OutlinedButton(
              onPressed: () async {
                await ref.read(secureStorageProvider).clearSession();
                if (context.mounted) {
                  context.go(RoutePaths.login);
                }
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
