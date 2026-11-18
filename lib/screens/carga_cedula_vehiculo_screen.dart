import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../routes.dart';
import '../theme/theme.dart';
import '../widgets/widgets.dart';

/// Upload screen for the vehicle's title document (cédula verde/azul),
/// shown with an already-uploaded example file. Implemented from the Figma
/// "carga-cedula-vehiculo" design (file neRKyJz313WM7CEdoZdgGl, node
/// 2069:434), mirroring [CargaSeguroVehiculoScreen]'s layout, reusing the
/// tokens in `lib/theme/` and [DocumentStatusChip].
class CargaCedulaVehiculoScreen extends StatelessWidget {
  const CargaCedulaVehiculoScreen({super.key});

  void _handleTakePhoto(BuildContext context) {
    // TODO: open the device camera to capture the cédula.
  }

  void _handlePickFromGallery(BuildContext context) {
    // TODO: open the gallery picker for the cédula.
  }

  void _handleReplace(BuildContext context) {
    // TODO: let the carrier replace the already-uploaded document.
  }

  void _handleSubmit(BuildContext context) {
    // TODO: persist the uploaded document before sending it to review.
    Navigator.of(context).pushReplacementNamed(AppRoutes.documentoEnRevision);
  }

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
              iconAsset: 'assets/icons/arrow_left_sm.svg',
              onTap: () => Navigator.of(context).maybePop(),
            ),
            Expanded(
              child: Text(
                'Cédula del vehículo',
                style: AppTypography.appBarTitle,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(width: 40),
          ],
        ),
      ),
      bottom: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PrimaryButton(
            label: 'Guardar y enviar a revisión',
            onPressed: () => _handleSubmit(context),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Nuestro equipo revisa los documentos en hasta 24 hs hábiles.',
            style: AppTypography.helper,
            textAlign: TextAlign.center,
          ),
        ],
      ),
      children: [
        Container(
          padding: const EdgeInsets.all(AppSpacing.sm),
          decoration: BoxDecoration(
            color: AppColors.iconSurface,
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          child: Row(
            children: [
              Text(
                'Estado del documento:',
                style: AppTypography.itemTitle.copyWith(
                  color: AppColors.warning,
                ),
              ),
              const Spacer(),
              const DocumentStatusChip(
                status: DocumentStatus.pending,
                uppercase: true,
                bordered: true,
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sectionGap),
        Text(
          'Subí una foto clara de la cédula verde o azul del vehículo. '
          'Asegurate de que se vean todos los datos y que esté vigente.',
          style: AppTypography.sectionSubtitle.copyWith(height: 1.5),
        ),
        const SizedBox(height: AppSpacing.sectionGap),
        _UploadDropzone(
          onTakePhoto: () => _handleTakePhoto(context),
          onPickFromGallery: () => _handlePickFromGallery(context),
        ),
        const SizedBox(height: AppSpacing.sectionGap),
        Text('Documento actual', style: AppTypography.groupTitle),
        const SizedBox(height: AppSpacing.xs),
        UploadedFileCard(
          fileName: 'cedula-vehiculo.jpg',
          metaLines: const ['2.3 MB · Subido hace 5 min'],
          badgeIconAsset: 'assets/icons/check_sm.svg',
          badgeColor: AppColors.success,
        ),
        const SizedBox(height: AppSpacing.xs),
        Align(
          alignment: Alignment.centerRight,
          child: InkWell(
            onTap: () => _handleReplace(context),
            borderRadius: BorderRadius.circular(AppRadius.chip),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.xxs),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    'assets/icons/refresh_cw.svg',
                    width: 16,
                    height: 16,
                  ),
                  const SizedBox(width: 4),
                  Text('Reemplazar', style: AppTypography.featureLabel),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _UploadDropzone extends StatelessWidget {
  const _UploadDropzone({
    required this.onTakePhoto,
    required this.onPickFromGallery,
  });

  final VoidCallback onTakePhoto;
  final VoidCallback onPickFromGallery;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: const DashedBorderPainter(
        color: AppColors.accent,
        radius: AppRadius.xl,
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          children: [
            Container(
              width: 64,
              height: 64,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.iconSurface,
                borderRadius: BorderRadius.circular(32),
              ),
              child: SvgPicture.asset(
                'assets/icons/camera.svg',
                width: 28,
                height: 28,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                Expanded(
                  child: _DropzoneButton(
                    label: 'Sacar foto',
                    iconAsset: 'assets/icons/camera.svg',
                    filled: true,
                    onTap: onTakePhoto,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: _DropzoneButton(
                    label: 'Elegir de galería',
                    iconAsset: 'assets/icons/image.svg',
                    filled: false,
                    onTap: onPickFromGallery,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'JPG, PNG o PDF — máx. 10 MB',
              style: AppTypography.helper,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _DropzoneButton extends StatelessWidget {
  const _DropzoneButton({
    required this.label,
    required this.iconAsset,
    required this.filled,
    required this.onTap,
  });

  final String label;
  final String iconAsset;
  final bool filled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.sm),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: filled ? AppColors.iconSurface : AppColors.surface,
          border: filled
              ? null
              : Border.all(color: AppColors.border, width: 1.5),
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(iconAsset, width: 16, height: 16),
            const SizedBox(width: AppSpacing.xs),
            Flexible(
              child: Text(
                label,
                style: AppTypography.featureLabel,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
