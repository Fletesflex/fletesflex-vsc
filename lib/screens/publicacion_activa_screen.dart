import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../routes.dart';
import '../theme/theme.dart';
import '../widgets/widgets.dart';

/// "Request published" confirmation, implemented from the Figma
/// "publicacion-activa" design (file o7nkeARTqRUSPsNBaYg2nb, node 2:287).
class PublicacionActivaScreen extends StatelessWidget {
  const PublicacionActivaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
      bodyPadding: EdgeInsets.zero,
      crossAxisAlignment: CrossAxisAlignment.center,
      bottom: PrimaryButton(
        label: 'Ver mis solicitudes',
        variant: ButtonVariant.soft,
        onPressed: () =>
            Navigator.of(context).pushNamed(AppRoutes.listadoOfertas),
      ),
      children: [
        const SizedBox(height: AppSpacing.lg),
        const PulseHero(iconAsset: 'assets/icons/wifi_high.svg'),
        const SizedBox(height: AppSpacing.lg),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/icons/check_circle.svg',
                    width: 20,
                    height: 20,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Text('¡Solicitud publicada!',
                      style: AppTypography.sectionTitle),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Tu mudanza ya es visible para los fleteros y transportistas '
                'disponibles en CABA. En instantes empezarás a recibir '
                'ofertas.',
                style: AppTypography.body,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        const LoadingDots(),
      ],
    );
  }
}

