import 'package:flutter/material.dart';

import '../theme/theme.dart';

/// Pill-shaped single-choice option (e.g. "Casa" / "Departamento").
/// Highlighted with the soft-yellow fill and accent border when [selected].
class OptionChip extends StatelessWidget {
  const OptionChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.pill),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        decoration: BoxDecoration(
          color: selected ? AppColors.iconSurface : AppColors.surface,
          border: Border.all(
            color: selected ? AppColors.accent : AppColors.border,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(AppRadius.pill),
        ),
        child: Text(
          label,
          style: selected ? AppTypography.chipSelected : AppTypography.chip,
        ),
      ),
    );
  }
}

/// A row of equally-wide [OptionChip]s where exactly one value is selected.
class OptionChipGroup<T> extends StatelessWidget {
  const OptionChipGroup({
    super.key,
    required this.options,
    required this.selected,
    required this.onChanged,
  });

  /// Value → label.
  final Map<T, String> options;
  final T? selected;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    final entries = options.entries.toList();
    return Row(
      children: [
        for (var i = 0; i < entries.length; i++) ...[
          if (i > 0) const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: OptionChip(
              label: entries[i].value,
              selected: entries[i].key == selected,
              onTap: () => onChanged(entries[i].key),
            ),
          ),
        ],
      ],
    );
  }
}

/// Row of equal-width rounded slots (e.g. arrival times); the selected one
/// is solid accent, the rest white with a border.
class SlotPicker extends StatelessWidget {
  const SlotPicker({
    super.key,
    required this.options,
    required this.selected,
    required this.onChanged,
  });

  final List<String> options;
  final String? selected;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (final (i, option) in options.indexed) ...[
          if (i > 0) const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: InkWell(
              onTap: () => onChanged(option),
              borderRadius: BorderRadius.circular(AppRadius.sm),
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: option == selected
                      ? AppColors.accent
                      : AppColors.surface,
                  border: option == selected
                      ? null
                      : Border.all(color: AppColors.border, width: 1.5),
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: Text(
                  option,
                  style: AppTypography.textAction.copyWith(
                    fontWeight: option == selected
                        ? FontWeight.bold
                        : FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
