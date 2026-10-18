import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../routes.dart';
import '../theme/theme.dart';
import '../widgets/widgets.dart';

/// Carrier identity-verification rejection screen, implemented from the
/// Figma "verificacion-rechazada" design (file neRKyJz313WM7CEdoZdgGl,
/// node 17:183), reusing the tokens in `lib/theme/` and the [SuccessBurst]
/// illustration shared with the other result screens.
class VerificacionRechazadaScreen extends StatelessWidget {
  const VerificacionRechazadaScreen({super.key});

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
      bottom: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PrimaryButton(
            label: 'Intentar de nuevo',
            // TODO: re-run the real capture + RENAPER validation; for now
            // this just restarts the document-capture steps.
            onPressed: () => Navigator.of(
              context,
            ).pushReplacementNamed(AppRoutes.capturaDniFrente),
          ),
          const SizedBox(height: AppSpacing.sm),
          InkWell(
            onTap: () =>
                Navigator.of(context).pushNamed(AppRoutes.reporteProblema),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    'assets/icons/circle_question_mark.svg',
                    width: 18,
                    height: 18,
                    colorFilter: const ColorFilter.mode(
                      AppColors.textSecondary,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Text('Necesito ayuda', style: AppTypography.link),
                ],
              ),
            ),
          ),
        ],
      ),
      children: [
        const SuccessBurst(
          iconAsset: 'assets/icons/alert_circle.svg',
          iconWidth: 24,
          iconHeight: 24,
          glowAsset: 'assets/images/burst_glow_soft.png',
          glowOpacity: 0.5,
          centerOffsetY: -4,
          decorations: SuccessBurst.errorDecorations,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'No pudimos verificar tu identidad',
          style: AppTypography.display.copyWith(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            height: 1.3,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'No te preocupes, esto suele pasar por pequeños detalles en las '
          'imágenes. Vamos a intentar resolverlo juntos.',
          style: AppTypography.body,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.sectionGap),
        AppCard(
          borderWidth: 1.5,
          shadow: false,
          radius: AppRadius.xl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Qué puede haber pasado:', style: AppTypography.userName),
              const SizedBox(height: AppSpacing.md),
              const _DiagnosisRow(
                iconAsset: 'assets/icons/file_text.svg',
                text: 'La foto del DNI no se leyó correctamente o tenía '
                    'reflejos.',
              ),
              const SizedBox(height: AppSpacing.md),
              const AppDivider(thin: true),
              const SizedBox(height: AppSpacing.md),
              const _DiagnosisRow(
                iconAsset: 'assets/icons/user_sm.svg',
                text: 'Los datos escaneados no coincidieron con el registro '
                    'oficial de RENAPER.',
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Container(
          padding: const EdgeInsets.all(AppSpacing.sectionGap),
          decoration: BoxDecoration(
            color: AppColors.iconSurface.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(AppRadius.xl),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _TipsTitle(),
              SizedBox(height: AppSpacing.md),
              _TipRow(
                iconAsset: 'assets/icons/sun.svg',
                text: 'Buscá un lugar con buena iluminación natural.',
              ),
              SizedBox(height: AppSpacing.sm),
              _TipRow(
                iconAsset: 'assets/icons/eye_off.svg',
                text: 'Evitá reflejos directos y sombras sobre el documento.',
              ),
              SizedBox(height: AppSpacing.sm),
              _TipRow(
                iconAsset: 'assets/icons/maximize.svg',
                text: 'Asegurate de que el DNI entre completo en el marco '
                    'de la cámara.',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Icon tile + description row inside the "Qué puede haber pasado" card.
class _DiagnosisRow extends StatelessWidget {
  const _DiagnosisRow({required this.iconAsset, required this.text});

  final String iconAsset;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          child: SvgPicture.asset(iconAsset, width: 20, height: 20),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Text(
            text,
            style: AppTypography.cardCaption.copyWith(height: 1.4),
          ),
        ),
      ],
    );
  }
}

class _TipsTitle extends StatelessWidget {
  const _TipsTitle();

  @override
  Widget build(BuildContext context) {
    return Text('Para el próximo intento:', style: AppTypography.userName);
  }
}

/// Small icon + description row inside the tips card.
class _TipRow extends StatelessWidget {
  const _TipRow({required this.iconAsset, required this.text});

  final String iconAsset;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 1),
          child: SvgPicture.asset(iconAsset, width: 18, height: 18),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(
            text,
            style: AppTypography.checkLabel.copyWith(height: 1.4),
          ),
        ),
      ],
    );
  }
}
