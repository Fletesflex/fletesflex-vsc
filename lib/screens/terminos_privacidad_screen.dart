import 'package:flutter/material.dart';

import '../theme/theme.dart';
import '../widgets/widgets.dart';

/// Legal/privacy links screen, implemented from the Figma
/// "terminos-privacidad" design (file neRKyJz313WM7CEdoZdgGl, node 2065:114).
/// Visual only — each document link is a TODO.
class TerminosPrivacidadScreen extends StatelessWidget {
  const TerminosPrivacidadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
      header: const AppPageHeader(
        title: 'Términos y privacidad',
        subtitle: 'Lo que tenés que saber para usar FletesFlex.',
      ),
      children: [
        IconLinkCard(
          rows: [
            IconLinkRow(
              iconAsset: 'assets/icons/file_text.svg',
              title: 'Términos y condiciones',
              subtitle: 'Las reglas para usar la plataforma.',
              onTap: () {
                // TODO: open the terms & conditions document.
              },
            ),
            IconLinkRow(
              iconAsset: 'assets/icons/shield_check.svg',
              iconColor: AppColors.textPrimary,
              title: 'Política de privacidad',
              subtitle: 'Cómo cuidamos y usamos tus datos.',
              onTap: () {
                // TODO: open the privacy policy document.
              },
            ),
            IconLinkRow(
              iconAsset: 'assets/icons/calendar_x.svg',
              title: 'Cancelaciones y reembolsos',
              subtitle: 'Qué pasa si cancelás un servicio.',
              onTap: () {
                // TODO: open the cancellations & refunds document.
              },
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        const InfoBannerCard(
          iconAsset: 'assets/icons/lock.svg',
          title: 'Tus datos están protegidos',
          description: 'Usamos tu información solo para conectarte con '
              'transportistas verificados y gestionar tus servicios.',
        ),
        const SizedBox(height: AppSpacing.sectionGap),
        Center(
          child: Text(
            'FletesFlex · Versión 1.0.0',
            style: AppTypography.itemSubtitle,
          ),
        ),
      ],
    );
  }
}
