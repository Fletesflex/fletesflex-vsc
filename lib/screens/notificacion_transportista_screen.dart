import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../routes.dart';
import '../theme/theme.dart';
import '../utils/format.dart';
import '../widgets/widgets.dart';

/// Push-style notification shown to the carrier when a requester assigns
/// them the job, implemented from the Figma "notificacion-transportista"
/// design (file neRKyJz313WM7CEdoZdgGl, node 30:105), reusing the tokens in
/// `lib/theme/`.
class NotificacionTransportistaScreen extends StatelessWidget {
  const NotificacionTransportistaScreen({super.key});

  void _handleGoToChat(BuildContext context) {
    // TODO: open the chat thread for this specific job.
    Navigator.of(context).pushNamed(AppRoutes.chat);
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
      bodyPadding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.sectionGap,
      ),
      bottom: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PillButton(
            label: 'Ir al Chat',
            onPressed: () => _handleGoToChat(context),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'El trabajo queda reservado en cuanto el solicitante complete '
            'el pago.',
            style: AppTypography.helper.copyWith(height: 1.4),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      children: [
        const SuccessBurst(
          iconAsset: 'assets/icons/package_open.svg',
          iconWidth: 36,
          iconHeight: 36,
          decorations: _badgeDecorations,
        ),
        const SizedBox(height: 28),
        // TODO: fill carrier/request data from the assignment notification.
        Text(
          '¡Te asignaron el trabajo!',
          style: AppTypography.display,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Carlos, tu propuesta para el flete fue seleccionada por la '
          'solicitante.',
          style: AppTypography.body.copyWith(fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 28),
        AppCard(
          borderWidth: 0,
          borderColor: Colors.transparent,
          radius: AppRadius.xl,
          elevatedShadow: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Resumen del servicio', style: AppTypography.cardHeading),
              const SizedBox(height: AppSpacing.md),
              const AppDivider(thin: true),
              const SizedBox(height: AppSpacing.md),
              const InfoRow(
                iconAsset: 'assets/icons/box_md.svg',
                label: 'Tipo',
                value: 'Mudanza chica',
              ),
              const SizedBox(height: 14),
              const InfoRow(
                iconAsset: 'assets/icons/map_pin.svg',
                label: 'Ruta',
                value: 'Palermo → Belgrano',
              ),
              const SizedBox(height: 14),
              const InfoRow(
                iconAsset: 'assets/icons/calendar_md.svg',
                label: 'Fecha',
                value: 'Sáb 12 Oct, 10:00–13:00',
              ),
              const SizedBox(height: 14),
              InfoRow(
                iconAsset: 'assets/icons/banknote.svg',
                label: 'Precio',
                value: formatArs(145000),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        const _RequesterCard(name: 'Lucía R.', subtitle: 'Solicitante • Palermo'),
        const SizedBox(height: AppSpacing.sm),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/icons/info.svg', width: 16, height: 16),
            const SizedBox(width: AppSpacing.xs),
            Flexible(
              child: Text(
                'También te lo confirmamos por mail y WhatsApp.',
                style: AppTypography.routeText.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Decorations around the [SuccessBurst] circle: the shared gold sparkle and
/// dark-ring accents plus this screen's warning triangle and check badge.
const _badgeDecorations = [
  OrbitDecoration('assets/icons/sparkle_gold.svg', -55, -35, 16),
  OrbitDecoration('assets/icons/circle_accent.svg', 50, -45, 12),
  OrbitDecoration('assets/icons/sparkle_gold_sm.svg', 55, 25, 14),
  OrbitDecoration('assets/icons/triangle_alert.svg', -45, 40, 10),
  OrbitDecoration('assets/icons/check_circle_badge.svg', 22, 22, 24),
];

/// White bordered row with the requester's avatar, name, a short caption and
/// a round chat button, shown below the service summary.
class _RequesterCard extends StatelessWidget {
  const _RequesterCard({required this.name, required this.subtitle});

  final String name;
  final String subtitle;

  void _handleChat(BuildContext context) {
    // TODO: open the chat thread with this requester.
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.sm),
      radius: AppRadius.md,
      child: Row(
        children: [
          const AppAvatar('assets/images/avatar_lucia.png', size: 40),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTypography.addressValue.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: AppTypography.itemSubtitle.copyWith(
                    color: AppColors.iconMuted,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () => _handleChat(context),
            customBorder: const CircleBorder(),
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.xs),
              decoration: const BoxDecoration(
                color: AppColors.background,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                'assets/icons/message_circle.svg',
                width: 16,
                height: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
