import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/theme.dart';
import 'app_card.dart';
import 'rating.dart';
import 'status_hero.dart';

/// 130px illustration used by the "rate your service" prompts: soft ring
/// and glow behind a dark rounded square holding [iconAsset].
class RatingPromptBurst extends StatelessWidget {
  const RatingPromptBurst({super.key, required this.iconAsset});

  final String iconAsset;

  static const _decorations = [
    OrbitDecoration('assets/icons/sparkle_gold_2.svg', -46, -34, 16),
    OrbitDecoration('assets/icons/sparkle_dark_2.svg', 44, 30, 14),
    OrbitDecoration('assets/icons/dot_dark_10.svg', 46, -40, 10),
    OrbitDecoration('assets/icons/dot_orange_8.svg', -42, 36, 8),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      height: 130,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/prompt_ring.svg',
            width: 90,
            height: 90,
          ),
          Opacity(
            opacity: 0.4,
            child: Image.asset(
              'assets/images/prompt_glow.png',
              width: 114,
              height: 114,
            ),
          ),
          Container(
            width: 68,
            height: 68,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.textPrimary,
              borderRadius: BorderRadius.circular(AppRadius.xl),
              boxShadow: [
                BoxShadow(
                  color: AppColors.accentDeep.withValues(alpha: 0.15),
                  offset: const Offset(0, 6),
                  blurRadius: 6,
                ),
              ],
            ),
            child: SvgPicture.asset(iconAsset, width: 28, height: 28),
          ),
          for (final d in _decorations)
            Positioned(
              left: 65 + d.left - d.size / 2,
              top: 65 + d.top - d.size / 2,
              child: SvgPicture.asset(d.asset, width: d.size, height: d.size),
            ),
        ],
      ),
    );
  }
}

/// Small card describing the service waiting to be rated: category label,
/// date, and the other party's avatar + name.
class PendingServiceCard extends StatelessWidget {
  const PendingServiceCard({
    super.key,
    required this.category,
    required this.date,
    required this.personCaption,
    required this.personName,
    required this.avatarAsset,
    this.filled = true,
    this.avatarSize = 40,
  });

  final String category;
  final String date;
  final String personCaption;
  final String personName;
  final String avatarAsset;

  /// Gray fill inside dialogs; white card with soft shadow otherwise.
  final bool filled;
  final double avatarSize;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.all(filled ? AppSpacing.md : AppSpacing.cardPadding),
      radius: filled ? AppRadius.md : AppRadius.xl,
      borderWidth: 1,
      color: filled ? AppColors.background : AppColors.surface,
      shadow: !filled,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: AppSpacing.xxs,
                ),
                decoration: BoxDecoration(
                  color: AppColors.iconSurface,
                  borderRadius: BorderRadius.circular(AppRadius.chip),
                ),
                child: Text(
                  category.toUpperCase(),
                  style: AppTypography.badgeLabel.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Text(
                date,
                style: AppTypography.itemSubtitle.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: filled ? AppSpacing.sm : 14),
          const AppDivider(thin: true),
          SizedBox(height: filled ? AppSpacing.sm : 14),
          Row(
            children: [
              AppAvatar(avatarAsset, size: avatarSize),
              const SizedBox(width: AppSpacing.sm),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(personCaption, style: AppTypography.itemSubtitle),
                  const SizedBox(height: 2),
                  Text(
                    personName,
                    style: AppTypography.userName.copyWith(
                      fontSize: filled ? 15 : 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Five large tappable stars.
class StarRatingInput extends StatelessWidget {
  const StarRatingInput({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final int value;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 1; i <= 5; i++) ...[
          if (i > 1) const SizedBox(width: AppSpacing.sm),
          InkResponse(
            onTap: () => onChanged(i),
            radius: 24,
            child: SizedBox(
              width: 48,
              height: 48,
              child: Center(
                child: SvgPicture.asset(
                  i <= value
                      ? 'assets/icons/star_rate_full.svg'
                      : 'assets/icons/star_rate_off.svg',
                  width: 38,
                  height: 38,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

/// Selectable rounded tag: soft-yellow with accent border and a check when
/// selected, white with a gray border otherwise.
class SelectableTag extends StatelessWidget {
  const SelectableTag({
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
      borderRadius: BorderRadius.circular(AppRadius.xl),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: selected ? AppColors.iconSurface : AppColors.surface,
          border: Border.all(
            color: selected ? AppColors.accent : AppColors.border,
            width: selected ? 2 : 1.5,
          ),
          borderRadius: BorderRadius.circular(AppRadius.xl),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (selected) ...[
              SvgPicture.asset(
                'assets/icons/check_sm.svg',
                width: 14,
                height: 14,
              ),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: selected
                  ? AppTypography.featureLabel
                  : AppTypography.checkLabel.copyWith(
                      color: AppColors.textSecondary,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
