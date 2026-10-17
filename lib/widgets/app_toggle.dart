import 'package:flutter/material.dart';

import '../theme/theme.dart';

/// On/off switch: 44×24 pill track (accent when on, border-gray when off)
/// with a 20px knob (dark when on, white when off).
class AppToggle extends StatelessWidget {
  const AppToggle({super.key, required this.value, required this.onChanged});

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: 44,
        height: 24,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: value ? AppColors.accent : AppColors.border,
          borderRadius: BorderRadius.circular(12),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 150),
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: value ? AppColors.textPrimary : AppColors.surface,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}

/// A label on the left and an [AppToggle] on the right.
class ToggleRow extends StatelessWidget {
  const ToggleRow({
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
    return Row(
      children: [
        Expanded(child: Text(label, style: AppTypography.toggleLabel)),
        const SizedBox(width: AppSpacing.xs),
        AppToggle(value: value, onChanged: onChanged),
      ],
    );
  }
}
