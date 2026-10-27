import 'package:flutter/material.dart';

import '../theme/theme.dart';
import '../widgets/widgets.dart';

class _Review {
  const _Review(this.initial, this.name, this.stars, this.when, this.text);

  final String initial;
  final String name;
  final int stars;
  final String when;
  final String text;
}

/// Carrier reviews list, implemented from the Figma "resenas-transportista"
/// design (file neRKyJz313WM7CEdoZdgGl, node 2065:185). Opened from "Ver
/// todas las reseñas" on the carrier's public profile. Visual only — sample
/// data mirrors Figma.
class ResenasTransportistaScreen extends StatelessWidget {
  const ResenasTransportistaScreen({super.key});

  static const _distribution = [0.74, 0.11, 0.04, 0.02, 0.02];
  static const _reviews = [
    _Review(
      'L',
      'Lucía R.',
      5,
      'hace 3 días',
      'Muy puntual y cuidadoso con los muebles. Lo recomiendo.',
    ),
    _Review(
      'M',
      'Martín P.',
      5,
      'hace 1 semana',
      'Llegó a horario, el precio fue el acordado y no hubo sorpresas.',
    ),
    _Review(
      'S',
      'Sofía G.',
      4,
      'hace 2 semanas',
      'Todo bien, solo tardó un poco en encontrar la dirección.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AppPage(
      header: const AppPageHeader(
        title: 'Reseñas',
        subtitle: 'Carlos M. · 126 viajes',
      ),
      children: [
        AppCard(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          radius: AppRadius.xl,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    '4.8',
                    style: AppTypography.priceAmount.copyWith(fontSize: 44),
                  ),
                  const SizedBox(height: AppSpacing.xxs),
                  const StarRow(value: 5, size: 14),
                  const SizedBox(height: AppSpacing.xxs),
                  Text(
                    '126 reseñas',
                    style: AppTypography.cardDescription.copyWith(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: AppSpacing.lg),
              Expanded(
                child: Column(
                  children: [
                    for (var i = 0; i < _distribution.length; i++) ...[
                      if (i > 0) const SizedBox(height: 6),
                      _DistributionBar(
                        stars: 5 - i,
                        fraction: _distribution[i],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        AppCard(
          padding: EdgeInsets.zero,
          radius: AppRadius.xl,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.xl),
            child: Column(
              children: [
                for (final (i, review) in _reviews.indexed) ...[
                  if (i > 0) const AppDivider(thin: true),
                  _ReviewRow(review: review),
                ],
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Center(
          child: TextLinkButton(
            label: 'Ver más reseñas',
            color: AppColors.textPrimary,
            onPressed: () {
              // TODO: load more reviews.
            },
          ),
        ),
      ],
    );
  }
}

class _DistributionBar extends StatelessWidget {
  const _DistributionBar({required this.stars, required this.fraction});

  final int stars;
  final double fraction;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$stars',
          style: AppTypography.cardDescription.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: AppSpacing.xs),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: SizedBox(
              height: 8,
              child: Stack(
                children: [
                  Container(color: AppColors.border),
                  FractionallySizedBox(
                    widthFactor: fraction,
                    child: Container(color: AppColors.accent),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ReviewRow extends StatelessWidget {
  const _ReviewRow({required this.review});

  final _Review review;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: 14,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: AppColors.iconSurface,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  review.initial,
                  style: AppTypography.cardTitle.copyWith(fontSize: 14),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(review.name, style: AppTypography.itemTitle),
                    const SizedBox(height: 2),
                    StarRow(value: review.stars, size: 12),
                  ],
                ),
              ),
              Text(review.when, style: AppTypography.itemSubtitle),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(review.text, style: AppTypography.cardDescription),
        ],
      ),
    );
  }
}
