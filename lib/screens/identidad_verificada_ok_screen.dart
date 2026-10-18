import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../routes.dart';
import '../theme/theme.dart';
import '../widgets/widgets.dart';

/// Carrier identity-verification success screen, implemented from the
/// Figma "identidad-verificada-ok" design (file neRKyJz313WM7CEdoZdgGl,
/// node 17:132), reusing the tokens in `lib/theme/` and the [SuccessBurst]
/// illustration shared with the other result screens.
class IdentidadVerificadaOkScreen extends StatelessWidget {
  const IdentidadVerificadaOkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
      bodyPadding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.sectionGap,
      ),
      bottom: PrimaryButton(
        label: 'Continuar con los papeles del vehículo',
        // TODO: route to the vehicle-documents flow once it's built; for
        // now this just returns the carrier to their request list.
        onPressed: () => Navigator.of(
          context,
        ).pushReplacementNamed(AppRoutes.transportistaSolicitudes),
      ),
      children: [
        const SuccessBurst(),
        const SizedBox(height: 28),
        Text(
          '¡Identidad verificada!',
          style: AppTypography.display,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Tu identidad fue validada correctamente. Ahora necesitamos la '
          'documentación de tu vehículo para que puedas empezar a recibir '
          'solicitudes.',
          style: AppTypography.body,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 28),
        AppCard(
          borderWidth: 1.5,
          shadow: false,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _VerifiedDetailRow(label: 'DNI validado por RENAPER'),
              SizedBox(height: AppSpacing.md),
              AppDivider(thin: true),
              SizedBox(height: AppSpacing.md),
              _VerifiedDetailRow(label: 'Prueba de vida (Selfie) aprobada'),
            ],
          ),
        ),
      ],
    );
  }
}

/// Green check-in-circle + bold green label row, used only by the
/// verification-details card on this screen.
class _VerifiedDetailRow extends StatelessWidget {
  const _VerifiedDetailRow({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: AppColors.successSurface,
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset(
            'assets/icons/check_sm.svg',
            width: 12,
            height: 12,
            colorFilter: const ColorFilter.mode(
              AppColors.success,
              BlendMode.srcIn,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(
            label,
            style: AppTypography.itemTitle.copyWith(color: AppColors.success),
          ),
        ),
      ],
    );
  }
}
