import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../routes.dart';
import '../theme/theme.dart';
import '../widgets/widgets.dart';

/// Upload screen for the vehicle's insurance policy document, shown with an
/// already-uploaded example file. Implemented from the Figma
/// "carga-seguro-vehiculo" design (file neRKyJz313WM7CEdoZdgGl, node
/// 23:156), reusing the tokens in `lib/theme/` and [DocumentStatusChip].
class CargaSeguroVehiculoScreen extends StatelessWidget {
  const CargaSeguroVehiculoScreen({super.key});

  void _handleTakePhoto(BuildContext context) {
    // TODO: open the device camera to capture the insurance document.
  }

  void _handlePickFromGallery(BuildContext context) {
    // TODO: open the gallery picker for the insurance document.
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
                'Seguro del vehículo',
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
          'Subí una foto clara de tu póliza de seguro vigente. Asegurate de '
          'que se vean bien los datos del vehículo y la fecha de '
          'vencimiento.',
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
        _UploadedDocumentCard(onReplace: () => _handleReplace(context)),
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

class _UploadedDocumentCard extends StatelessWidget {
  const _UploadedDocumentCard({required this.onReplace});

  final VoidCallback onReplace;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      borderWidth: 1.5,
      shadow: false,
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.border,
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        'poliza-seguro-2024.jpg',
                        style: AppTypography.itemTitle.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.success,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text('2.3 MB · Subido hace 5 min', style: AppTypography.helper),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          InkWell(
            onTap: onReplace,
            borderRadius: BorderRadius.circular(AppRadius.chip),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xxs,
                vertical: AppSpacing.xxs,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    'assets/icons/refresh_cw.svg',
                    width: 16,
                    height: 16,
                    colorFilter: const ColorFilter.mode(
                      AppColors.textPrimary,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text('Reemplazar', style: AppTypography.featureLabel),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
