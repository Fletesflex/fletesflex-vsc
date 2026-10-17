import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/theme.dart';
import 'app_card.dart';
import 'rating.dart';

/// Green "✓ Identidad verificada" label.
class VerifiedBadge extends StatelessWidget {
  const VerifiedBadge({super.key, this.label = '✓ Identidad verificada'});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xs,
        vertical: AppSpacing.xxs,
      ),
      decoration: BoxDecoration(
        color: AppColors.successSurface,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: AppTypography.badgeLabel.copyWith(color: AppColors.success),
      ),
    );
  }
}

/// Section with a soft-yellow icon tile, an 18px title (+ optional count)
/// and the section body below.
class ProfileSection extends StatelessWidget {
  const ProfileSection({
    super.key,
    required this.iconAsset,
    required this.title,
    required this.child,
    this.count,
  });

  final String iconAsset;
  final String title;
  final int? count;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 32,
              height: 32,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.iconSurface,
                borderRadius: BorderRadius.circular(AppRadius.chip),
              ),
              child: SvgPicture.asset(iconAsset, width: 18, height: 18),
            ),
            const SizedBox(width: 10),
            Text(title, style: AppTypography.appBarTitle),
            if (count != null) ...[
              const SizedBox(width: 6),
              Text(
                '($count)',
                style: AppTypography.fieldValue.copyWith(
                  color: AppColors.textMuted,
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        child,
      ],
    );
  }
}

/// Neutral outlined pill (specialties).
class OutlinedPill extends StatelessWidget {
  const OutlinedPill(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: AppColors.background,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Text(label, style: AppTypography.pill),
    );
  }
}

/// Soft-yellow chip with accent border, small icon and bold label.
class FeatureChip extends StatelessWidget {
  const FeatureChip({
    super.key,
    required this.iconAsset,
    required this.label,
    this.enabled = true,
  });

  final String iconAsset;
  final String label;

  /// Disabled chips are gray and faded (a service not requested).
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final chip = Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: enabled ? AppColors.iconSurface : AppColors.border,
        border: Border.all(
          color: enabled ? AppColors.accent : AppColors.border,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(iconAsset, width: 14, height: 14),
          const SizedBox(width: 6),
          Text(
            label,
            style: enabled
                ? AppTypography.featureLabel
                : AppTypography.checkLabel.copyWith(
                    color: AppColors.textMuted,
                  ),
          ),
        ],
      ),
    );
    return enabled ? chip : Opacity(opacity: 0.5, child: chip);
  }
}

/// A single review: avatar, author, relative date, stars and text.
class ReviewCard extends StatelessWidget {
  const ReviewCard({
    super.key,
    required this.author,
    required this.avatarAsset,
    required this.when,
    required this.stars,
    required this.text,
  });

  final String author;
  final String avatarAsset;
  final String when;
  final int stars;
  final String text;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      radius: AppRadius.xl,
      shadow: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AppAvatar(avatarAsset, size: 36),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      author,
                      style: AppTypography.userName.copyWith(fontSize: 15),
                    ),
                    const SizedBox(height: 2),
                    Text(when, style: AppTypography.itemSubtitle),
                  ],
                ),
              ),
              StarRow(value: stars),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(text, style: AppTypography.cardDescription),
        ],
      ),
    );
  }
}
