import 'package:flutter/material.dart';

import '../theme/theme.dart';

/// Small uppercase pill label (e.g. the "Recomendado" tag on a category
/// card). Reusable wherever a status/flag badge is needed.
class AppBadge extends StatelessWidget {
  const AppBadge(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xs,
        vertical: AppSpacing.badgeVertical,
      ),
      decoration: BoxDecoration(
        color: AppColors.accent,
        borderRadius: BorderRadius.circular(AppRadius.chip),
      ),
      child: Text(
        label.toUpperCase(),
        style: AppTypography.badgeLabel,
      ),
    );
  }
}
