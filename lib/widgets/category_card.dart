import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/theme.dart';
import 'app_badge.dart';

/// A selectable service card (e.g. "Mudanza", "Flete", "Mensajería") shown
/// on the Home screen's category list. Reusable for any other screen that
/// needs the same icon + title + description layout.
class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.iconAsset,
    required this.title,
    required this.description,
    this.badgeLabel,
    this.selected = false,
    this.onTap,
  });

  final String iconAsset;
  final String title;
  final String description;
  final String? badgeLabel;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.xl),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.cardPadding),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.xl),
          border: Border.all(
            color: selected ? AppColors.accent : AppColors.border,
            width: selected ? 2 : 1.5,
          ),
          boxShadow: selected ? AppShadows.elevated : AppShadows.soft,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 48,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.iconSurface,
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              child: SvgPicture.asset(iconAsset, width: 28, height: 28),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(title, style: AppTypography.cardTitle),
                      if (badgeLabel != null) AppBadge(badgeLabel!),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xxs),
                  Text(description, style: AppTypography.cardDescription),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
