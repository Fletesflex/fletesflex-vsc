import 'package:flutter/material.dart';

import '../theme/theme.dart';

/// Visual weight of a [PrimaryButton].
enum ButtonVariant {
  /// Solid accent fill ("Siguiente", "Confirmar y publicar").
  filled,

  /// Soft-yellow fill ("Ver mis solicitudes").
  soft,

  /// White fill with a border ("Cancelar").
  outlined,

  /// Dark fill with white label.
  dark,
}

/// Full-width 48px call-to-action button.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = ButtonVariant.filled,
    this.leading,
  });

  final String label;
  final VoidCallback? onPressed;
  final ButtonVariant variant;

  /// Optional icon shown before the label.
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    final (background, foreground, side) = switch (variant) {
      ButtonVariant.filled => (AppColors.accent, AppColors.textPrimary, null),
      ButtonVariant.soft => (
          AppColors.iconSurface,
          AppColors.textPrimary,
          null,
        ),
      ButtonVariant.outlined => (
          AppColors.surface,
          AppColors.textPrimary,
          const BorderSide(color: AppColors.border, width: 1.5),
        ),
      ButtonVariant.dark => (AppColors.textPrimary, AppColors.surface, null),
    };

    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: background,
          foregroundColor: foreground,
          side: side,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (leading != null) ...[
              leading!,
              const SizedBox(width: AppSpacing.xs),
            ],
            Flexible(
              child: Text(
                label,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.button.copyWith(color: foreground),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Underlined text-only action ("Editar datos").
class TextLinkButton extends StatelessWidget {
  const TextLinkButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.color = AppColors.textSecondary,
  });

  final String label;
  final VoidCallback onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(AppRadius.chip),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xs,
          vertical: AppSpacing.xxs,
        ),
        child: Text(
          label,
          style: AppTypography.link.copyWith(
            color: color,
            decorationColor: color,
          ),
        ),
      ),
    );
  }
}

/// 54px fully rounded button used on payment screens: accent fill with a
/// soft shadow, or white with an accent border when [outlined].
class PillButton extends StatelessWidget {
  const PillButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.leading,
    this.outlined = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final Widget? leading;
  final bool outlined;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: onPressed == null ? 0.6 : 1,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(27),
          boxShadow: outlined || onPressed == null
              ? null
              : [
                  BoxShadow(
                    color: AppColors.accentDeep.withValues(alpha: 0.2),
                    offset: const Offset(0, 6),
                    blurRadius: 6,
                  ),
                ],
        ),
        child: Material(
          color: outlined ? AppColors.surface : AppColors.accent,
          shape: StadiumBorder(
            side: outlined
                ? const BorderSide(color: AppColors.accent, width: 1.5)
                : BorderSide.none,
          ),
          child: InkWell(
            onTap: onPressed,
            customBorder: const StadiumBorder(),
            child: SizedBox(
              height: 54,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (leading != null) ...[
                    leading!,
                    const SizedBox(width: 10),
                  ],
                  Flexible(
                    child: Text(
                      label,
                      style: AppTypography.buttonSmall.copyWith(fontSize: 15),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
