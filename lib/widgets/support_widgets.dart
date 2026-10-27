import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/theme.dart';
import 'app_card.dart';

/// A tappable row with a 40px soft-yellow icon tile, a bold title, a muted
/// subtitle and a trailing chevron, implemented from the Figma
/// "row-Escribinos por WhatsApp" / "row-Términos y condiciones" pattern
/// shared by "ayuda-soporte" and "terminos-privacidad" (file
/// neRKyJz313WM7CEdoZdgGl). Stack a few inside an [IconLinkCard].
class IconLinkRow extends StatelessWidget {
  const IconLinkRow({
    super.key,
    required this.iconAsset,
    required this.title,
    required this.subtitle,
    this.iconColor,
    this.onTap,
  });

  final String iconAsset;
  final String title;
  final String subtitle;

  /// Tints [iconAsset] (for icons authored in a color that doesn't read
  /// against the soft-yellow tile).
  final Color? iconColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: 14,
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.iconSurface,
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              child: SvgPicture.asset(
                iconAsset,
                width: 20,
                height: 20,
                colorFilter: iconColor == null
                    ? null
                    : ColorFilter.mode(iconColor!, BlendMode.srcIn),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.cardTitle.copyWith(fontSize: 15),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: AppTypography.cardDescription.copyWith(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            SvgPicture.asset(
              'assets/icons/chevron_right.svg',
              width: 18,
              height: 18,
            ),
          ],
        ),
      ),
    );
  }
}

/// White rounded card holding a vertical list of [IconLinkRow]s separated by
/// hairline dividers, with a configurable border (accent for the "Ayuda"
/// contact card, neutral for the "Términos" document list).
class IconLinkCard extends StatelessWidget {
  const IconLinkCard({
    super.key,
    required this.rows,
    this.borderColor = AppColors.border,
    this.borderWidth = 1.5,
  });

  final List<IconLinkRow> rows;
  final Color borderColor;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.zero,
      radius: AppRadius.xl,
      borderColor: borderColor,
      borderWidth: borderWidth,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (final (i, row) in rows.indexed) ...[
              if (i > 0) const AppDivider(thin: true),
              row,
            ],
          ],
        ),
      ),
    );
  }
}

/// Soft-yellow info banner with a leading icon, implemented from the Figma
/// "card-info" design ("Tus datos están protegidos").
class InfoBannerCard extends StatelessWidget {
  const InfoBannerCard({
    super.key,
    required this.iconAsset,
    required this.title,
    required this.description,
  });

  final String iconAsset;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: AppColors.iconSurface,
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(iconAsset, width: 22, height: 22),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.cardTitle.copyWith(fontSize: 14),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: AppTypography.cardDescription.copyWith(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// A single collapsible FAQ row, implemented from the Figma "faq" design.
/// Stateless — pass [expanded] and [onTap] from a parent that tracks which
/// question (if any) is currently open.
class FaqRow extends StatelessWidget {
  const FaqRow({
    super.key,
    required this.question,
    required this.answer,
    required this.expanded,
    required this.onTap,
  });

  final String question;
  final String answer;
  final bool expanded;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: double.infinity,
        color: expanded ? AppColors.unreadSurface : AppColors.surface,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: 14,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    question,
                    style: AppTypography.itemTitle.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
                AnimatedRotation(
                  turns: expanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 150),
                  child: SvgPicture.asset(
                    'assets/icons/chevron_down.svg',
                    width: 18,
                    height: 18,
                  ),
                ),
              ],
            ),
            if (expanded) ...[
              const SizedBox(height: AppSpacing.xs),
              Text(answer, style: AppTypography.cardDescription),
            ],
          ],
        ),
      ),
    );
  }
}

/// White rounded card holding a vertical list of [FaqRow]s separated by
/// hairline dividers.
class FaqCard extends StatelessWidget {
  const FaqCard({super.key, required this.rows});

  final List<FaqRow> rows;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.zero,
      radius: AppRadius.xl,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (final (i, row) in rows.indexed) ...[
              if (i > 0) const AppDivider(thin: true),
              row,
            ],
          ],
        ),
      ),
    );
  }
}
