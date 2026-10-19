import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../routes.dart';
import '../theme/theme.dart';
import '../widgets/widgets.dart';

/// "Rejected" state of a submitted carrier document — reusable for any
/// document, defaulting to the VTV/RTO technical inspection. Implemented
/// from the Figma "documento-rechazado" design (file neRKyJz313WM7CEdoZdgGl,
/// node 23:221), reusing the tokens in `lib/theme/`, [DocumentStatusChip]
/// and [UploadedFileCard].
class DocumentoRechazadoScreen extends StatelessWidget {
  const DocumentoRechazadoScreen({
    super.key,
    this.documentTitle = 'VTV / RTO',
    this.sectionTitle = 'Verificación técnica',
    this.sectionSubtitle = 'Estado de tu documentación',
    this.rejectionReason = 'La VTV que subiste está vencida. Necesitamos '
        'una verificación técnica con fecha de vigencia actual.',
    this.fileName = 'vtv-2023.jpg',
    this.fileSizeLabel = 'Tamaño: 1.8 MB',
    this.uploadedLabel = 'Subido el 15 ago 2024',
    this.tips = const [
      'Asegurate de capturar el documento completo, sin recortar los '
          'bordes ni las firmas.',
      'Evitá que salgan reflejos de luces o flash sobre el plástico '
          'protector del papel.',
    ],
  });

  final String documentTitle;
  final String sectionTitle;
  final String sectionSubtitle;
  final String rejectionReason;
  final String fileName;
  final String fileSizeLabel;
  final String uploadedLabel;
  final List<String> tips;

  void _handleUploadAgain(BuildContext context) {
    // TODO: open the camera/gallery picker to resubmit this document.
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
              iconAsset: 'assets/icons/chevron_left_sm.svg',
              onTap: () => Navigator.of(context).maybePop(),
            ),
            Expanded(
              child: Text(
                documentTitle,
                style: AppTypography.pageTitle,
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
            label: 'Subir de nuevo',
            leading: SvgPicture.asset(
              'assets/icons/upload.svg',
              width: 18,
              height: 18,
            ),
            onPressed: () => _handleUploadAgain(context),
          ),
          const SizedBox(height: AppSpacing.sm),
          InkWell(
            onTap: () =>
                Navigator.of(context).pushNamed(AppRoutes.reporteProblema),
            borderRadius: BorderRadius.circular(AppRadius.chip),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxs),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    'assets/icons/message_square.svg',
                    width: 16,
                    height: 16,
                    colorFilter: const ColorFilter.mode(
                      AppColors.textPrimary,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '¿Necesitás ayuda?',
                    style: AppTypography.link.copyWith(
                      color: AppColors.textPrimary,
                      decorationColor: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xxs),
          Text(
            'Podés subir un nuevo documento en cualquier momento.',
            style: AppTypography.helper,
            textAlign: TextAlign.center,
          ),
        ],
      ),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(sectionTitle, style: AppTypography.greetingTitle),
                  const SizedBox(height: 2),
                  Text(sectionSubtitle, style: AppTypography.sectionSubtitle),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            const DocumentStatusChip(
              status: DocumentStatus.rejected,
              uppercase: true,
              bordered: true,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sectionGap),
        _RejectionReasonCard(reason: rejectionReason),
        const SizedBox(height: AppSpacing.sectionGap),
        Text('Documento enviado', style: AppTypography.groupTitle),
        const SizedBox(height: AppSpacing.sm),
        UploadedFileCard(
          fileName: fileName,
          metaLines: [fileSizeLabel, uploadedLabel],
          badgeIconAsset: 'assets/icons/x_sm.svg',
          badgeColor: AppColors.danger,
        ),
        const SizedBox(height: AppSpacing.sectionGap),
        _TipsBox(tips: tips),
      ],
    );
  }
}

/// White card with a red left accent bar, a warning icon and the rejection
/// reason copy — mirrors the left-accent treatment used by
/// [DocumentStatusCard] for its approved state.
class _RejectionReasonCard extends StatelessWidget {
  const _RejectionReasonCard({required this.reason});

  final String reason;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border, width: 1.5),
        borderRadius: BorderRadius.circular(AppRadius.xl),
        boxShadow: AppShadows.soft,
      ),
      clipBehavior: Clip.antiAlias,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(width: 4, color: AppColors.danger),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 28,
                          height: 28,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.dangerSurface,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: SvgPicture.asset(
                            'assets/icons/alert_circle.svg',
                            width: 14,
                            height: 14,
                            colorFilter: const ColorFilter.mode(
                              AppColors.danger,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Text('Motivo del rechazo', style: AppTypography.cardHeading),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      reason,
                      style: AppTypography.body.copyWith(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Soft-yellow box with a help icon, title and bullet tips, used for advice
/// on resubmitting a rejected document.
class _TipsBox extends StatelessWidget {
  const _TipsBox({required this.tips});

  final List<String> tips;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.iconSurface.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/circle_question_mark.svg',
                width: 16,
                height: 16,
                colorFilter: const ColorFilter.mode(
                  AppColors.textPrimary,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(
                'Consejos para la nueva carga',
                style: AppTypography.cardHeading.copyWith(fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          for (final tip in tips)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.xs),
              child: Text(
                '•  $tip',
                style: AppTypography.cardDescription,
              ),
            ),
        ],
      ),
    );
  }
}
