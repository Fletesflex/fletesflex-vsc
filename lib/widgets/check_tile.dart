import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/theme.dart';

/// 22px rounded checkbox: dark fill + accent border + yellow check when
/// checked, muted outline otherwise.
class AppCheckbox extends StatelessWidget {
  const AppCheckbox({super.key, required this.value});

  final bool value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: 22,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: value ? AppColors.textPrimary : null,
        border: Border.all(
          color: value ? AppColors.accent : AppColors.textMuted,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: value
          ? SvgPicture.asset(
              'assets/icons/check_accent.svg',
              width: 14,
              height: 14,
            )
          : null,
    );
  }
}

/// Bordered row with an [AppCheckbox] and a label; tapping toggles it.
class CheckTile extends StatelessWidget {
  const CheckTile({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: AppColors.border, width: 1.5),
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: InkWell(
        onTap: () => onChanged(!value),
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              AppCheckbox(value: value),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  label,
                  style: AppTypography.checkLabel.copyWith(
                    color: value
                        ? AppColors.textPrimary
                        : AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
