import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../routes.dart';
import '../theme/theme.dart';
import '../widgets/widgets.dart';

/// "Mensajería published" confirmation, implemented from the Figma
/// "mensajeria-publicada" design (file neRKyJz313WM7CEdoZdgGl, node 44:100).
class MensajeriaPublicadaScreen extends StatelessWidget {
  const MensajeriaPublicadaScreen({super.key});

  void _handleGoHome(BuildContext context) {
    // TODO: navigate back to the requester home / root route.
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: 'Confirmación',
      topBarStyle: TopBarStyle.centered,
      showBack: false,
      bodyPadding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
      ),
      bottom: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PillButton(
            label: 'Ver mis solicitudes',
            onPressed: () =>
                Navigator.of(context).pushNamed(AppRoutes.listadoOfertas),
          ),
          const SizedBox(height: AppSpacing.md),
          TextLinkButton(
            label: 'Volver al inicio',
            color: AppColors.textPrimary,
            onPressed: () => _handleGoHome(context),
          ),
        ],
      ),
      children: [
        const SizedBox(height: AppSpacing.lg),
        const _PublishedPulseHero(),
        const SizedBox(height: AppSpacing.sectionGap),
        Text(
          '¡Envío publicado!',
          style: AppTypography.display,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Tu envío ya es visible para los mensajeros disponibles en tu '
          'zona. En breve vas a empezar a recibir cotizaciones.',
          style: AppTypography.body,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

/// Concentric soft-accent rings behind a solid yellow circle holding a check
/// mark, with a small white package badge overlapping its bottom-right edge.
class _PublishedPulseHero extends StatelessWidget {
  const _PublishedPulseHero();

  @override
  Widget build(BuildContext context) {
    Widget ring(double size, Color fill, Color border) => Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: fill,
            shape: BoxShape.circle,
            border: Border.all(color: border, width: 2),
          ),
        );

    return SizedBox(
      width: 260,
      height: 260,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ring(
            220,
            AppColors.accent.withValues(alpha: 0.03),
            AppColors.accent.withValues(alpha: 0.08),
          ),
          ring(
            160,
            AppColors.accent.withValues(alpha: 0.06),
            AppColors.accent.withValues(alpha: 0.18),
          ),
          Container(
            width: 100,
            height: 100,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: AppColors.accent,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color(0x33D95427),
                  offset: Offset(0, 8),
                  blurRadius: 8,
                ),
              ],
            ),
            child: SvgPicture.asset(
              'assets/icons/check_hero.svg',
              width: 36,
              height: 36,
            ),
          ),
          const Positioned(
            left: 130 + 60 - 23,
            top: 130 + 60 - 22,
            child: _PackageBadge(),
          ),
        ],
      ),
    );
  }
}

/// Small white bordered badge holding the package icon, overlapping the
/// pulse hero's bottom-right edge.
class _PackageBadge extends StatelessWidget {
  const _PackageBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46,
      height: 44,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.surface,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A1E1B18),
            offset: Offset(0, 4),
            blurRadius: 6,
          ),
        ],
      ),
      child: SvgPicture.asset(
        'assets/icons/package_badge.svg',
        width: 20,
        height: 20,
      ),
    );
  }
}
