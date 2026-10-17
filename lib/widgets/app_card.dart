import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/theme.dart';

/// White rounded surface with a hairline border and the soft shadow
/// (summary cards, offer cards, profile blocks).
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.sectionGap),
    this.radius = AppRadius.lg,
    this.borderColor = AppColors.border,
    this.borderWidth = 1.5,
    this.color = AppColors.surface,
    this.shadow = true,
    this.elevatedShadow = false,
    this.onTap,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final double radius;
  final Color borderColor;
  final double borderWidth;
  final Color color;
  final bool shadow;

  /// Uses [AppShadows.elevated] instead of [AppShadows.soft]. Ignored when
  /// [shadow] is false.
  final bool elevatedShadow;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final content = Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: borderColor, width: borderWidth),
        borderRadius: BorderRadius.circular(radius),
        boxShadow: shadow
            ? (elevatedShadow ? AppShadows.elevated : AppShadows.soft)
            : null,
      ),
      child: child,
    );
    if (onTap == null) return content;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(radius),
      child: content,
    );
  }
}

/// Horizontal hairline. [thin] uses the 1px variant used inside cards;
/// otherwise the 1.5px section separator.
class AppDivider extends StatelessWidget {
  const AppDivider({super.key, this.thin = false});

  final bool thin;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: thin ? 1 : 1.5,
      child: SvgPicture.asset(
        thin ? 'assets/icons/line_thin.svg' : 'assets/icons/line.svg',
        fit: BoxFit.fill,
      ),
    );
  }
}

/// Icon in a 38px soft-yellow circle + uppercase caption + value
/// ("SERVICIO / Mudanza chica · Palermo → Belgrano").
class InfoRow extends StatelessWidget {
  const InfoRow({
    super.key,
    required this.iconAsset,
    required this.label,
    required this.value,
  });

  final String iconAsset;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 38,
          height: 38,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: AppColors.iconSurface,
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset(iconAsset, width: 18, height: 18),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label.toUpperCase(), style: AppTypography.infoLabel),
              const SizedBox(height: 2),
              Text(value, style: AppTypography.infoValue),
            ],
          ),
        ),
      ],
    );
  }
}
