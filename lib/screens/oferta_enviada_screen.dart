import 'package:flutter/material.dart';

import '../models/service_type.dart';
import '../routes.dart';
import '../theme/theme.dart';
import '../utils/format.dart';
import '../widgets/widgets.dart';

/// Carrier-side "offer sent" confirmation, implemented from the Figma
/// "confirmacion-oferta-enviada" design (file o7nkeARTqRUSPsNBaYg2nb,
/// node 4:4).
class OfertaEnviadaScreen extends StatelessWidget {
  const OfertaEnviadaScreen({super.key});

  // TODO: show the offer the carrier just sent.
  static const _budget = 55000;

  @override
  Widget build(BuildContext context) {
    return AppPage(
      bodyPadding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        40,
        AppSpacing.lg,
        AppSpacing.lg,
      ),
      bottom: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 52,
            child: PrimaryButton(
              label: 'Ver mis ofertas',
              variant: ButtonVariant.soft,
              onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.misOfertas,
                (route) => false,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sectionGap),
          TextLinkButton(
            label: 'Volver a solicitudes',
            onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoutes.transportistaSolicitudes,
              (route) => false,
            ),
          ),
        ],
      ),
      children: [
        const Center(
          child: OrbitIllustration(
            size: 200,
            rings: [
              ('assets/icons/orbit_ring_lg.svg', 180, 1),
              ('assets/icons/orbit_ring_md.svg', 140, 1),
              ('assets/icons/burst_ring.svg', 100, 1),
            ],
            centerSize: 72,
            iconAsset: 'assets/icons/check_md.svg',
            decorations: [
              OrbitDecoration('assets/icons/dot_dark_8.svg', 30, 40, 8),
              OrbitDecoration('assets/icons/dot_accent_6.svg', 160, 50, 6),
              OrbitDecoration('assets/icons/dot_accent_6.svg', 25, 130, 6),
              OrbitDecoration('assets/icons/dot_dark_8.svg', 155, 145, 8),
              OrbitDecoration(
                'assets/icons/sparkle_polygon.svg',
                160,
                92,
                10,
                rotation: 45,
              ),
              OrbitDecoration(
                'assets/icons/sparkle_polygon_sm.svg',
                39,
                96,
                8,
                rotation: 15,
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        Text(
          '¡Oferta enviada!',
          style: AppTypography.sectionTitle.copyWith(fontSize: 26),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'El solicitante verá tu oferta junto a las demás y elegirá la que '
          'más le convenga. Te notificaremos cuando haya una respuesta.',
          style: AppTypography.body.copyWith(fontSize: 14),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        RequestSummaryCard(
          type: ServiceType.mudanza,
          reference: '#9482',
          route: 'Palermo → Belgrano',
          schedule: 'Sáb 12 Oct · 09:00',
          footer: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tu presupuesto',
                style: AppTypography.itemTitle.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                formatArs(_budget),
                style: AppTypography.pageTitle,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
