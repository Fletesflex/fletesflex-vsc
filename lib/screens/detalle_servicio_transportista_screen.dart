import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/offer.dart';
import '../routes.dart';
import '../theme/theme.dart';
import '../widgets/widgets.dart';

/// Carrier-side completed-service detail, implemented from the Figma
/// "detalle-servicio-transportista" design (file neRKyJz313WM7CEdoZdgGl,
/// node 2071:128), reusing the tokens in `lib/theme/`. Visual only — no
/// backend wiring yet; shows sample data mirroring the carrier's history
/// list.
class DetalleServicioTransportistaScreen extends StatelessWidget {
  const DetalleServicioTransportistaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
      header: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.sm,
        ),
        child: CircleIconButton(
          iconAsset: 'assets/icons/arrow_left_sm.svg',
          onTap: () => Navigator.of(context).maybePop(),
        ),
      ),
      bottom: PrimaryButton(
        label: 'Ver mis cobros',
        onPressed: () => Navigator.of(context).pushNamed(AppRoutes.misCobros),
      ),
      children: [
        Text(
          'Detalle del servicio',
          style: AppTypography.headline.copyWith(fontSize: 28),
        ),
        const SizedBox(height: AppSpacing.sectionGap),
        AppCard(
          padding: const EdgeInsets.all(AppSpacing.md),
          radius: AppRadius.xl,
          elevatedShadow: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'MUDANZA LOCAL',
                          style: AppTypography.badgeLabel.copyWith(
                            color: AppColors.textMuted,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Palermo → Belgrano',
                          style: AppTypography.cardTitle.copyWith(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.successSurface,
                      borderRadius: BorderRadius.circular(AppRadius.chip),
                    ),
                    child: Text(
                      'Completado',
                      style: AppTypography.badgeLabel.copyWith(
                        color: AppColors.success,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              const AppDivider(thin: true),
              const SizedBox(height: AppSpacing.md),
              const _DetailRow(
                label: 'Fecha',
                value: '5 de sep, 2026 · 10:00–13:00',
              ),
              const SizedBox(height: AppSpacing.sm),
              const _DetailRow(
                label: 'Dirección de retiro',
                value: 'Av. Santa Fe 3200, Palermo',
              ),
              const SizedBox(height: AppSpacing.sm),
              const _DetailRow(
                label: 'Dirección de entrega',
                value: 'Av. Cabildo 2150, Belgrano',
              ),
              const SizedBox(height: AppSpacing.sm),
              const _DetailRow(label: 'Cobraste', value: '\$145.000'),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        AppCard(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: 14,
          ),
          radius: AppRadius.xl,
          elevatedShadow: true,
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: AppColors.iconSurface,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  'L',
                  style: AppTypography.cardTitle.copyWith(fontSize: 18),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Solicitante',
                      style: AppTypography.badgeLabel.copyWith(
                        color: AppColors.textMuted,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text('Lucía R.', style: AppTypography.userName),
                    const SizedBox(height: 2),
                    Text(
                      '4.9 · 12 servicios',
                      style: AppTypography.itemSubtitle.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        AppCard(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: 14,
          ),
          radius: AppRadius.xl,
          elevatedShadow: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tu calificación al solicitante',
                style: AppTypography.itemTitle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  for (var i = 0; i < 5; i++) ...[
                    if (i > 0) const SizedBox(width: 2),
                    SvgPicture.asset(
                      'assets/icons/star_filled_20.svg',
                      width: 16,
                      height: 16,
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sectionGap),
        Center(
          child: InkWell(
            onTap: () => Navigator.of(context).pushNamed(
              AppRoutes.comprobantePago,
              arguments: SampleOffers.andres,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  'assets/icons/download.svg',
                  width: 16,
                  height: 16,
                ),
                const SizedBox(width: 6),
                Text(
                  'Ver comprobante',
                  style: AppTypography.badgeLabel.copyWith(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.itemSubtitle.copyWith(
            color: AppColors.textSecondary,
            fontSize: 13,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: AppTypography.itemTitle.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }
}
