import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_color_palettes.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/extensions/date_extensions.dart';
import '../../../../shared/widgets/error_view.dart';
import '../../../../shared/widgets/loading_indicator.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../../di/jobs_providers.dart';

class JobDetailScreen extends ConsumerWidget {
  const JobDetailScreen({super.key, required this.jobId});

  final String jobId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = AppColors.fromContext(context);
    final textTheme = Theme.of(context).textTheme;
    final jobState = ref.watch(jobByIdProvider(jobId));

    return Scaffold(
      appBar: AppBar(title: const Text('Job Details')),
      body: jobState.when(
        data: (job) {
          if (job == null) {
            return const Center(child: Text('Job not found.'));
          }

          return Padding(
            padding: AppSpacing.paddingAllLg,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(job.title, style: textTheme.cardTitle(colors.primaryText)),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'Status: ${job.status}',
                  style: textTheme.fieldLabel(colors.secondaryText),
                ),
                const SizedBox(height: AppSpacing.sm),
                if (job.scheduledAt != null)
                  Text(
                    'Scheduled: ${job.scheduledAt!.toDisplayDate()}',
                    style: textTheme.fieldLabel(colors.secondaryText),
                  ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'Last Updated: ${job.updatedAt.toDisplayDate()}',
                  style: textTheme.fieldLabel(colors.secondaryText),
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  job.description ?? 'No description available.',
                  style: textTheme.fieldValue(colors.primaryText),
                ),
                const Spacer(),
                PrimaryButton(
                  label: 'Update Job',
                  onPressed: () => context.push('/jobs/$jobId/update'),
                ),
              ],
            ),
          );
        },
        loading: LoadingIndicator.new,
        error: (error, _) => ErrorView(message: error.toString()),
      ),
    );
  }
}
