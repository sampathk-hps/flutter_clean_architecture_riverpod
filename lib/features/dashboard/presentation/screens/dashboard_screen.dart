import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_paths.dart';
import '../../../../core/theme/app_color_palettes.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_shadows.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: Padding(
        padding: AppSpacing.paddingAllLg,
        child: Column(
          children: [
            _DashboardTile(
              title: 'Jobs',
              subtitle: 'View and manage assigned jobs',
              onTap: () => context.go(RoutePaths.jobs),
            ),
            const SizedBox(height: AppSpacing.md),
            _DashboardTile(
              title: 'Settings',
              subtitle: 'Theme, sync and session controls',
              onTap: () => context.go(RoutePaths.settings),
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardTile extends StatelessWidget {
  const _DashboardTile({
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.fromContext(context);
    final textTheme = Theme.of(context).textTheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: AppRadius.card,
        boxShadow: AppShadows.card(colors.primaryText),
      ),
      child: Card(
        child: ListTile(
          title: Text(title, style: textTheme.cardTitle(colors.primaryText)),
          subtitle: Text(
            subtitle,
            style: textTheme.supportingLabel(colors.secondaryText),
          ),
          trailing: const Icon(Icons.chevron_right),
          onTap: onTap,
        ),
      ),
    );
  }
}
