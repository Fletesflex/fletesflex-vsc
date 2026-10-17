import 'package:flutter/material.dart';

import '../models/offer.dart';
import '../theme/theme.dart';
import '../utils/format.dart';
import 'app_card.dart';
import 'app_tag.dart';
import 'rating.dart';

/// Carrier bid card: avatar, name, rating, price, vehicle tag, note and the
/// "Ver perfil completo" / "Elegir" actions.
class OfferCard extends StatelessWidget {
  const OfferCard({
    super.key,
    required this.offer,
    this.highlighted = false,
    this.onViewProfile,
    this.onChoose,
  });

  final Offer offer;

  /// Accent 2px border (best/featured offer).
  final bool highlighted;
  final VoidCallback? onViewProfile;
  final VoidCallback? onChoose;

  @override
  Widget build(BuildContext context) {
    final carrier = offer.carrier;
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      radius: AppRadius.xl,
      borderColor: highlighted ? AppColors.accent : AppColors.border,
      borderWidth: highlighted ? 2 : 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppAvatar(carrier.avatarAsset),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(carrier.name, style: AppTypography.userName),
                      const SizedBox(height: 2),
                      RatingRow(
                        rating: carrier.rating,
                        suffix: '(${carrier.completedJobs} mudanzas)',
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(formatArs(offer.price), style: AppTypography.priceMedium),
                  const SizedBox(height: 2),
                  Text('FINAL', style: AppTypography.micro),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),
          AppTag(
            offer.vehicle,
            color: AppColors.neutralSurface,
            textColor: AppColors.textSecondary,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(offer.note, style: AppTypography.cardDescription),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.only(top: AppSpacing.xs),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: AppColors.neutralSurface)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: onViewProfile,
                  child: Text(
                    'Ver perfil completo',
                    style: AppTypography.linkSmall,
                  ),
                ),
                CompactButton(label: 'Elegir', onPressed: onChoose),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Small accent button (px 20, py 8, radius 12) — "Elegir".
class CompactButton extends StatelessWidget {
  const CompactButton({
    super.key,
    required this.label,
    this.onPressed,
    this.color = AppColors.accent,
    this.textColor = AppColors.textPrimary,
  });

  final String label;
  final VoidCallback? onPressed;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(AppRadius.sm),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(AppRadius.sm),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sectionGap,
            vertical: AppSpacing.xs,
          ),
          child: Text(
            label,
            style: AppTypography.buttonSmall.copyWith(color: textColor),
          ),
        ),
      ),
    );
  }
}
