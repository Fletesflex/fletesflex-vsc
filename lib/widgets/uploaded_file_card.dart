import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/theme.dart';
import 'app_card.dart';

/// White bordered card showing an already-submitted document: a 64px
/// thumbnail with a small status badge overlaid on its corner, the file
/// name, and one or more meta lines (size, upload date). Shared by the
/// document-review and document-rejected screens.
class UploadedFileCard extends StatelessWidget {
  const UploadedFileCard({
    super.key,
    required this.fileName,
    required this.metaLines,
    required this.badgeIconAsset,
    required this.badgeColor,
    this.thumbnailIconAsset,
    this.thumbnailColor = AppColors.border,
  });

  final String fileName;

  /// Secondary lines shown under the file name (e.g. size, upload date).
  /// The first line uses [AppTypography.helper]; the rest use a muted caption.
  final List<String> metaLines;

  /// Icon shown inside the corner status badge (e.g. a clock or an X).
  final String badgeIconAsset;
  final Color badgeColor;

  /// Icon centered on the thumbnail. Omit for a plain color placeholder.
  final String? thumbnailIconAsset;
  final Color thumbnailColor;

  @override
  Widget build(BuildContext context) {
    const badgeSize = 20.0;
    const badgeIconSize = 10.0;

    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      radius: AppRadius.xl,
      borderWidth: 1.5,
      shadow: false,
      child: Row(
        children: [
          SizedBox(
            width: 64,
            height: 64,
            child: Stack(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: thumbnailColor,
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  child: thumbnailIconAsset == null
                      ? null
                      : SvgPicture.asset(
                          thumbnailIconAsset!,
                          width: 28,
                          height: 28,
                        ),
                ),
                Positioned(
                  right: 4,
                  top: 4,
                  child: Container(
                    width: badgeSize,
                    height: badgeSize,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: badgeColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.surface,
                        width: 1.5,
                      ),
                    ),
                    child: SvgPicture.asset(
                      badgeIconAsset,
                      width: badgeIconSize,
                      height: badgeIconSize,
                      colorFilter: const ColorFilter.mode(
                        AppColors.surface,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fileName,
                  style: AppTypography.itemTitle.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                for (var i = 0; i < metaLines.length; i++)
                  Text(
                    metaLines[i],
                    style: i == 0
                        ? AppTypography.helper
                        : AppTypography.micro.copyWith(fontSize: 12),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
