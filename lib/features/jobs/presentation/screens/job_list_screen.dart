import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/connectivity/connectivity_service.dart';
import '../../../../core/di/connectivity_providers.dart';
import '../../../../core/theme/app_color_palettes.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/error_view.dart';
import '../../../../shared/widgets/loading_indicator.dart';
import '../controllers/jobs_controller.dart';
import '../widgets/job_card.dart';

class JobListScreen extends ConsumerWidget {
  const JobListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = AppColors.fromContext(context);
    final jobsState = ref.watch(jobsControllerProvider);
    final connectivity = ref.watch(connectivityStatusStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Jobs'),
        actions: [
          connectivity.when(
            data: (status) {
              final online = status == ConnectivityStatus.online;
              return Padding(
                padding: AppSpacing.paddingRightMd,
                child: Icon(
                  online ? Icons.wifi : Icons.wifi_off,
                  color: online ? colors.success : colors.warning,
                ),
              );
            },
            loading: () => const SizedBox.shrink(),
            error: (error, stackTrace) => const SizedBox.shrink(),
          ),
        ],
      ),
      body: jobsState.when(
        data: (jobs) {
          if (jobs.isEmpty) {
            return const Center(child: Text('No jobs found.'));
          }

          return RefreshIndicator(
            onRefresh: () =>
                ref.read(jobsControllerProvider.notifier).refresh(),
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: AppSpacing.paddingAllMd,
              itemCount: jobs.length,
              itemBuilder: (context, index) {
                final job = jobs[index];
                return JobCard(
                  job: job,
                  onTap: () => context.push('/jobs/${job.id}'),
                );
              },
            ),
          );
        },
        loading: LoadingIndicator.new,
        error: (error, _) => ErrorView(
          message: error.toString(),
          onRetry: () => ref.read(jobsControllerProvider.notifier).refresh(),
        ),
      ),
    );
  }
}
