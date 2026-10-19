import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../routes.dart';
import '../theme/theme.dart';
import '../widgets/widgets.dart';

/// "In review" state of a submitted carrier document — reusable for any
/// document, defaulting to the vehicle insurance policy. Implemented from
/// the Figma "documento-en-revision" design (file neRKyJz313WM7CEdoZdgGl,
/// node 23:310), reusing the tokens in `lib/theme/`, [DocumentStatusChip]
/// and [UploadedFileCard].
class DocumentoEnRevisionScreen extends StatelessWidget {
  const DocumentoEnRevisionScreen({
    super.key,
    this.documentTitle = 'Seguro del vehículo',
    this.fileName = 'seguro-poliza-2024.jpg',
    this.fileSizeLabel = 'Tamaño: 2.3 MB',
    this.uploadedLabel = 'Subido hace 3 hs',
  });

  /// Shown on the header and used to title the reassurance copy.
  final String documentTitle;
  final String fileName;
  final String fileSizeLabel;
  final String uploadedLabel;

  void _handleGoHome(BuildContext context) {
    Navigator.of(
      context,
    ).pushNamedAndRemoveUntil(AppRoutes.transportistaSolicitudes, (_) => false);
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
                documentTitle,
                style: AppTypography.appBarTitle,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(width: 40),
          ],
        ),
      ),
      elevatedBottom: true,
      bottom: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PrimaryButton(
            label: 'Volver al inicio',
            variant: ButtonVariant.outlinedAccent,
            onPressed: () => _handleGoHome(context),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Podés ver el estado de tu cuenta desde tu perfil.',
            style: AppTypography.helper,
            textAlign: TextAlign.center,
          ),
        ],
      ),
      children: [
        const SizedBox(height: AppSpacing.xs),
        Center(
          child: DocumentStatusChip(
            status: DocumentStatus.inReview,
            uppercase: true,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        const _ReviewArtwork(),
        const SizedBox(height: AppSpacing.lg),
        Text(
          'Estamos revisando tu documento',
          style: AppTypography.headline.copyWith(fontSize: 22, height: 1.3),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Nuestro equipo está revisando este documento. Te vamos a avisar '
          'apenas esté listo.',
          style: AppTypography.body,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'La revisión puede demorar hasta 24 horas hábiles.',
          style: AppTypography.micro.copyWith(fontSize: 12),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.sectionGap),
        Text('Documento enviado', style: AppTypography.groupTitle),
        const SizedBox(height: AppSpacing.xs),
        UploadedFileCard(
          fileName: fileName,
          metaLines: [fileSizeLabel, uploadedLabel],
          thumbnailIconAsset: 'assets/icons/file_text.svg',
          badgeIconAsset: 'assets/icons/clock.svg',
          badgeColor: AppColors.textPrimary,
        ),
      ],
    );
  }
}

/// Document-with-magnifying-glass illustration for the "in review" state,
/// composed from plain containers to match the Figma "artwork" group (the
/// same structure as the identity-verification processing screen's
/// artwork, with a clock badge instead of a checkmark).
class _ReviewArtwork extends StatelessWidget {
  const _ReviewArtwork();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 240,
              height: 240,
              decoration: BoxDecoration(
                color: AppColors.iconSurface.withValues(alpha: 0.3),
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: 180,
              height: 180,
              decoration: const BoxDecoration(
                color: AppColors.iconSurface,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(
              width: 120,
              height: 120,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    left: 10,
                    top: 20,
                    child: Container(
                      width: 100,
                      height: 70,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        border: Border.all(color: AppColors.border, width: 2),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: AppShadows.soft,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: AppColors.iconSurface,
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: AppColors.border,
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  height: 6,
                                  width: 24,
                                  decoration: BoxDecoration(
                                    color: AppColors.border,
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  height: 6,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: AppColors.border,
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 55,
                    top: 45,
                    child: Container(
                      width: 54,
                      height: 54,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.accent, width: 3),
                        boxShadow: AppShadows.soft,
                      ),
                      child: SvgPicture.asset(
                        'assets/icons/clock.svg',
                        width: 20,
                        height: 20,
                        colorFilter: const ColorFilter.mode(
                          AppColors.textPrimary,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 95,
                    top: 95,
                    child: Transform.rotate(
                      angle: 0.78,
                      child: Container(
                        width: 18,
                        height: 3,
                        decoration: BoxDecoration(
                          color: AppColors.textPrimary,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
