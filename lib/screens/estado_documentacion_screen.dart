import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../routes.dart';
import '../theme/theme.dart';
import '../widgets/widgets.dart';

/// Document-hub screen listing the carrier's four verification requirements
/// and their review status. Implemented from the Figma
/// "estado-documentacion" design (file neRKyJz313WM7CEdoZdgGl, node 23:4),
/// reusing the tokens in `lib/theme/` and [DocumentStatusCard].
class EstadoDocumentacionScreen extends StatelessWidget {
  const EstadoDocumentacionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
      header: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.sm,
        ),
        child: Row(
          children: [
            CircleIconButton(
              iconAsset: 'assets/icons/chevron_left_sm.svg',
              onTap: () => Navigator.of(context).maybePop(),
            ),
            Expanded(
              child: Text(
                'Verificación de cuenta',
                style: AppTypography.pageTitle,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(width: 40),
          ],
        ),
      ),
      bottom: const CarrierNavBar(current: CarrierTab.verificacion),
      elevatedBottom: false,
      bodyPadding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.xs,
        AppSpacing.lg,
        AppSpacing.lg,
      ),
      children: [
        Text('Tu verificación', style: AppTypography.display.copyWith(fontSize: 28)),
        const SizedBox(height: AppSpacing.xxs),
        Text(
          'Completá los requisitos para poder salir a la calle a hacer fletes.',
          style: AppTypography.sectionSubtitle,
        ),
        const SizedBox(height: AppSpacing.xs),
        const _ProgressBar(completed: 2, total: 4),
        const SizedBox(height: AppSpacing.lg),
        DocumentStatusCard(
          iconAsset: 'assets/icons/user_sm.svg',
          title: 'Identidad',
          subtitle: 'DNI + Selfie verificados',
          status: DocumentStatus.approved,
        ),
        const SizedBox(height: 14),
        DocumentStatusCard(
          iconAsset: 'assets/icons/shield_check.svg',
          title: 'Seguro del vehículo',
          subtitle: 'Póliza vigente obligatoria',
          status: DocumentStatus.pending,
          onTap: () => Navigator.of(
            context,
          ).pushNamed(AppRoutes.cargaSeguroVehiculo),
        ),
        const SizedBox(height: 14),
        DocumentStatusCard(
          iconAsset: 'assets/icons/truck.svg',
          title: 'VTV / RTO',
          subtitle: 'Verificación técnica vehicular',
          status: DocumentStatus.inReview,
          footnote: 'Subido hace 2 hs · Verificando con ente regulador',
        ),
        const SizedBox(height: 14),
        DocumentStatusCard(
          iconAsset: 'assets/icons/file_text.svg',
          title: 'Cédula verde o azul',
          subtitle: 'Titularidad del vehículo',
          status: DocumentStatus.pending,
          // TODO: open the cédula upload screen once it's built.
          onTap: () {},
        ),
        const SizedBox(height: AppSpacing.lg),
        Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.surface,
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 28,
                height: 28,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.iconSurface,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: SvgPicture.asset(
                  'assets/icons/clock.svg',
                  width: 16,
                  height: 16,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text.rich(
                  TextSpan(
                    style: AppTypography.cardDescription.copyWith(height: 1.5),
                    children: const [
                      TextSpan(
                        text: 'La revisión de los papeles del vehículo la '
                            'hace nuestro equipo y puede demorar hasta ',
                      ),
                      TextSpan(
                        text: '24 horas hábiles',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: '.'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: AppColors.iconSurface.withValues(alpha: 0.25),
            border: Border.all(color: AppColors.accent, width: 1.5),
            borderRadius: BorderRadius.circular(AppRadius.xl),
          ),
          child: Opacity(
            opacity: 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/rocket.svg',
                      width: 20,
                      height: 20,
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Expanded(
                      child: Text(
                        '¡Ya podés empezar a tomar solicitudes!',
                        style: AppTypography.cardHeading,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Completá todos los documentos para activar tu cuenta y '
                  'comenzar a recibir fletes en tu zona.',
                  style: AppTypography.cardDescription.copyWith(fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({required this.completed, required this.total});

  final int completed;
  final int total;

  @override
  Widget build(BuildContext context) {
    final fraction = completed / total;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Progreso: ${(fraction * 100).round()}%',
              style: AppTypography.caps.copyWith(color: AppColors.textPrimary),
            ),
            Text(
              '$completed de $total aprobados',
              style: AppTypography.micro.copyWith(fontSize: 12),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.pill),
          child: LinearProgressIndicator(
            value: fraction,
            minHeight: 6,
            backgroundColor: AppColors.border,
            valueColor: const AlwaysStoppedAnimation(AppColors.accent),
          ),
        ),
      ],
    );
  }
}
