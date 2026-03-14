import 'package:flutter/material.dart';

import '../../core/theme/app_color_palettes.dart';
import '../../core/theme/app_sizes.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.fromContext(context);
    final textTheme = Theme.of(context).textTheme;

    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? const SizedBox(
              width: AppSizes.buttonLoadingIndicatorSize,
              height: AppSizes.buttonLoadingIndicatorSize,
              child: CircularProgressIndicator(strokeWidth: AppSpacing.xxs),
            )
          : Text(label, style: textTheme.buttonLabel(colors.primaryText)),
    );
  }
}
