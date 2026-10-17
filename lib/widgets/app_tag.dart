import 'package:flutter/material.dart';

import '../theme/theme.dart';

/// Small rounded label with a soft fill (e.g. "Necesita Ayudantes").
class AppTag extends StatelessWidget {
  const AppTag(
    this.label, {
    super.key,
    this.color = AppColors.iconSurface,
    this.textColor = AppColors.textPrimary,
    this.leading,
  });

  final String label;
  final Color color;
  final Color textColor;

  /// Optional icon before the label.
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: AppSpacing.xxs,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppRadius.chip),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leading != null) ...[leading!, const SizedBox(width: 4)],
          Text(label, style: AppTypography.tag.copyWith(color: textColor)),
        ],
      ),
    );
  }
}
