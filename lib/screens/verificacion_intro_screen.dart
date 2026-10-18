import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../routes.dart';
import '../theme/theme.dart';
import '../widgets/widgets.dart';

/// Entry point of the carrier identity-verification flow, implemented from
/// the Figma "verificacion-intro" design (file neRKyJz313WM7CEdoZdgGl,
/// node 8:4), reusing the tokens in `lib/theme/`.
class VerificacionIntroScreen extends StatelessWidget {
  const VerificacionIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
      header: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.sm,
          AppSpacing.lg,
          AppSpacing.sm,
        ),
        child: CircleIconButton(
          iconAsset: 'assets/icons/arrow_left_sm.svg',
          onTap: () => Navigator.of(context).maybePop(),
        ),
      ),
      bottom: PrimaryButton(
        label: 'Empezar verificación',
        // TODO: skip straight to the next pending step once some
        // requirements are already completed.
        onPressed: () =>
            Navigator.of(context).pushNamed(AppRoutes.capturaDniFrente),
      ),
      children: const [
        _Illustration(),
        SizedBox(height: 28),
        _Headlines(),
        SizedBox(height: 28),
        _RequirementsCard(),
        SizedBox(height: 28),
        _TimeEstimate(),
      ],
    );
  }
}

class _Illustration extends StatelessWidget {
  const _Illustration();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: Center(
        child: SizedBox(
          width: 160,
          height: 160,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  color: AppColors.iconSurface.withValues(alpha: 0.5),
                  shape: BoxShape.circle,
                ),
              ),
              Container(
                width: 110,
                height: 110,
                decoration: const BoxDecoration(
                  color: AppColors.iconSurface,
                  shape: BoxShape.circle,
                ),
              ),
              Container(
                width: 72,
                height: 72,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.textPrimary,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.accentDeep.withValues(alpha: 0.2),
                      offset: const Offset(0, 6),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: SvgPicture.asset(
                  'assets/icons/shield_check.svg',
                  width: 32,
                  height: 32,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Headlines extends StatelessWidget {
  const _Headlines();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Verifiquemos tu identidad',
          style: AppTypography.headline,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Es un paso obligatorio para operar en FletesFlex. Validamos tu '
          'identidad con RENAPER para la seguridad de todos. Tu información '
          'está protegida y no se comparte con terceros.',
          style: AppTypography.sectionSubtitle.copyWith(height: 1.5),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _RequirementsCard extends StatelessWidget {
  const _RequirementsCard();

  @override
  Widget build(BuildContext context) {
    return AppCard(
      borderWidth: 1.5,
      shadow: false,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _RequirementRow(
            iconAsset: 'assets/icons/id_card.svg',
            label: 'Tu DNI (frente y dorso)',
          ),
          SizedBox(height: AppSpacing.md),
          AppDivider(),
          SizedBox(height: AppSpacing.md),
          _RequirementRow(
            iconAsset: 'assets/icons/camera.svg',
            label: 'Una selfie o video corto',
          ),
          SizedBox(height: AppSpacing.md),
          AppDivider(),
          SizedBox(height: AppSpacing.md),
          _RequirementRow(
            iconAsset: 'assets/icons/file_text.svg',
            label: 'Los papeles de tu vehículo',
          ),
        ],
      ),
    );
  }
}

class _RequirementRow extends StatelessWidget {
  const _RequirementRow({required this.iconAsset, required this.label});

  final String iconAsset;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          child: SvgPicture.asset(
            iconAsset,
            width: 20,
            height: 20,
            colorFilter: const ColorFilter.mode(
              AppColors.textPrimary,
              BlendMode.srcIn,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(child: Text(label, style: AppTypography.infoValue)),
      ],
    );
  }
}

class _TimeEstimate extends StatelessWidget {
  const _TimeEstimate();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.iconSurface,
          borderRadius: BorderRadius.circular(AppRadius.pill),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset('assets/icons/clock.svg', width: 16, height: 16),
            const SizedBox(width: AppSpacing.xs),
            Text('Lleva unos 5 minutos', style: AppTypography.featureLabel),
          ],
        ),
      ),
    );
  }
}
