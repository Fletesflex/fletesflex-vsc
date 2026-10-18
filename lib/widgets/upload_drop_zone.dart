import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/theme.dart';

/// Dashed-border tap target for attaching a photo or file (receipt upload,
/// package photo).
class UploadDropZone extends StatelessWidget {
  UploadDropZone({
    super.key,
    required this.title,
    required this.onTap,
    this.subtitle,
    this.iconAsset = 'assets/icons/camera_md.svg',
    this.iconSize = 22,
    this.borderColor = AppColors.dashedBorder,
    TextStyle? titleStyle,
    this.padding = const EdgeInsets.symmetric(
      horizontal: AppSpacing.md,
      vertical: 28,
    ),
  }) : titleStyle = titleStyle ?? AppTypography.userName;

  final String title;
  final VoidCallback onTap;
  final String? subtitle;
  final String iconAsset;
  final double iconSize;
  final Color borderColor;
  final TextStyle titleStyle;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.xl),
      child: CustomPaint(
        painter: DashedBorderPainter(color: borderColor, radius: AppRadius.xl),
        child: Container(
          width: double.infinity,
          padding: padding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 48,
                height: 48,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: AppColors.iconSurface,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  iconAsset,
                  width: iconSize,
                  height: iconSize,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(title, style: titleStyle, textAlign: TextAlign.center),
              if (subtitle != null) ...[
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  subtitle!,
                  style: AppTypography.routeText.copyWith(
                    color: AppColors.textMuted,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Dashed rounded-rectangle outline, used by [UploadDropZone] and other
/// dashed-border tap targets (e.g. the DNI capture guide).
class DashedBorderPainter extends CustomPainter {
  const DashedBorderPainter({
    required this.color,
    required this.radius,
    this.strokeWidth = 1.5,
    this.dash = 6.0,
    this.gap = 4.0,
  });

  final Color color;
  final double radius;
  final double strokeWidth;
  final double dash;
  final double gap;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Offset.zero & size,
          Radius.circular(radius),
        ).deflate(strokeWidth / 2),
      );
    for (final metric in path.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        canvas.drawPath(metric.extractPath(distance, distance + dash), paint);
        distance += dash + gap;
      }
    }
  }

  @override
  bool shouldRepaint(DashedBorderPainter oldDelegate) =>
      oldDelegate.color != color ||
      oldDelegate.radius != radius ||
      oldDelegate.strokeWidth != strokeWidth;
}
