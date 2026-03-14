import 'package:flutter/material.dart';

import '../../../../core/theme/app_color_palettes.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/extensions/date_extensions.dart';
import '../../domain/entities/job.dart';

class JobCard extends StatelessWidget {
  const JobCard({super.key, required this.job, required this.onTap});

  final Job job;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.fromContext(context);
    final textTheme = Theme.of(context).textTheme;

    return Card(
      child: ListTile(
        onTap: onTap,
        title: Text(job.title, style: textTheme.cardTitle(colors.primaryText)),
        subtitle: Text(
          '${job.status.toUpperCase()} • Updated ${job.updatedAt.toDisplayDate()}',
          style: textTheme.mutedMeta(colors.secondaryText),
        ),
        trailing: Icon(
          job.isSynced ? Icons.cloud_done : Icons.cloud_upload,
          color: job.isSynced ? colors.success : colors.warning,
        ),
      ),
    );
  }
}
