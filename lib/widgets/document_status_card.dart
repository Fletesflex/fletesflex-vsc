import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/theme.dart';
import 'app_card.dart';

/// Review state of a verification document, shared by the document-hub list
/// (`estado-documentacion`) and the per-document upload/status screens.
enum DocumentStatus {
  /// Reviewed and accepted — green left accent bar + "Aprobada" chip.
  approved,

  /// Not yet submitted — amber chip, tappable to start the upload.
  pending,

  /// Submitted and awaiting manual review — neutral gray chip.
  inReview,

  /// Reviewed and declined — red chip.
  rejected;

  Color get chipBackground => switch (this) {
    DocumentStatus.approved => AppColors.successSurface,
    DocumentStatus.pending => AppColors.iconSurface,
    DocumentStatus.inReview => AppColors.border,
    DocumentStatus.rejected => AppColors.dangerSurface,
  };

  Color get chipForeground => switch (this) {
    DocumentStatus.approved => AppColors.success,
    DocumentStatus.pending => AppColors.warning,
    DocumentStatus.inReview => AppColors.textSecondary,
    DocumentStatus.rejected => AppColors.danger,
  };

  String get label => switch (this) {
    DocumentStatus.approved => 'Aprobada',
    DocumentStatus.pending => 'Pendiente',
    DocumentStatus.inReview => 'En revisión',
    DocumentStatus.rejected => 'Rechazada',
  };
}

/// Small pill showing a [DocumentStatus], with an optional leading check
/// (used on the "Aprobada" state).
class DocumentStatusChip extends StatelessWidget {
  const DocumentStatusChip({
    super.key,
    required this.status,
    this.uppercase = false,
    this.bordered = false,
  });

  final DocumentStatus status;

  /// Uppercases the label (used by the single-document upload screens).
  final bool uppercase;

  /// Adds a 1px border in the foreground color (used by the single-document
  /// upload screens).
  final bool bordered;

  @override
  Widget build(BuildContext context) {
    final label = uppercase ? status.label.toUpperCase() : status.label;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: status.chipBackground,
        border: bordered
            ? Border.all(color: status.chipForeground)
            : null,
        borderRadius: BorderRadius.circular(AppRadius.chip),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (status == DocumentStatus.approved) ...[
            SvgPicture.asset(
              'assets/icons/check_sm.svg',
              width: 12,
              height: 12,
              colorFilter: ColorFilter.mode(
                status.chipForeground,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: AppTypography.badgeLabel.copyWith(
              fontSize: 12,
              color: status.chipForeground,
            ),
          ),
        ],
      ),
    );
  }
}

/// A single document's review card on the "estado-documentacion" hub: icon,
/// title, subtitle, a [DocumentStatusChip], and an optional footnote line.
/// Reusable wherever a document's review status needs to be listed.
class DocumentStatusCard extends StatelessWidget {
  const DocumentStatusCard({
    super.key,
    required this.iconAsset,
    required this.title,
    required this.subtitle,
    required this.status,
    this.footnote,
    this.onTap,
  });

  final String iconAsset;
  final String title;
  final String subtitle;
  final DocumentStatus status;

  /// Extra line shown under a hairline separator (e.g. "Subido hace 2 hs…").
  final String? footnote;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final approved = status == DocumentStatus.approved;
    final clickable = onTap != null;

    final content = Container(
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
            if (approved)
              Container(width: 4, color: AppColors.success),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.background,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: SvgPicture.asset(
                            iconAsset,
                            width: 20,
                            height: 20,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(title, style: AppTypography.cardHeading),
                              const SizedBox(height: 2),
                              Text(
                                subtitle,
                                style: AppTypography.cardDescription,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        DocumentStatusChip(status: status),
                        if (clickable) ...[
                          const SizedBox(width: AppSpacing.xs),
                          SvgPicture.asset(
                            'assets/icons/chevron_right.svg',
                            width: 16,
                            height: 16,
                          ),
                        ],
                      ],
                    ),
                    if (footnote != null) ...[
                      const SizedBox(height: AppSpacing.xs),
                      const AppDivider(thin: true),
                      Padding(
                        padding: const EdgeInsets.only(top: AppSpacing.xs),
                        child: Text(
                          footnote!,
                          style: AppTypography.micro.copyWith(fontSize: 12),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

    if (!clickable) return content;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.xl),
      child: content,
    );
  }
}
