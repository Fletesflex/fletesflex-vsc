import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/theme.dart';
import 'upload_drop_zone.dart';

/// Row of progress dots for a multi-step flow on a dark background:
/// completed steps are filled [AppColors.successBrightOnDark] circles with a
/// checkmark, the rest are plain translucent-white dots. Used by the carrier
/// identity-verification steps ("Paso X de 4").
class StepDotsRow extends StatelessWidget {
  const StepDotsRow({super.key, required this.completed, required this.total});

  /// Number of steps already completed (not the current step's index).
  final int completed;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < total; i++) ...[
          if (i > 0) const SizedBox(width: 6),
          if (i < completed)
            Container(
              width: 10,
              height: 10,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: AppColors.successBrightOnDark,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                'assets/icons/check_success_xs.svg',
                width: 6,
                height: 6,
                colorFilter: const ColorFilter.mode(
                  AppColors.surface,
                  BlendMode.srcIn,
                ),
              ),
            )
          else
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.25),
                shape: BoxShape.circle,
              ),
            ),
        ],
      ],
    );
  }
}

/// Small pill marking a finished sub-step ("✓ Frente completado") on a dark
/// background.
class StepCompletedChip extends StatelessWidget {
  const StepCompletedChip({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.successBrightOnDark.withValues(alpha: 0.1),
        border: Border.all(
          color: AppColors.successBrightOnDark.withValues(alpha: 0.25),
        ),
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Text(
        '✓ $label',
        style: AppTypography.smallAction.copyWith(
          color: AppColors.successBrightOnDark,
          fontSize: 12,
        ),
      ),
    );
  }
}

/// 40px translucent circular back button for dark full-screen chrome
/// (camera captures). The light-background equivalent is [CircleIconButton].
class DarkCircleBackButton extends StatelessWidget {
  const DarkCircleBackButton({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () => Navigator.of(context).maybePop(),
      customBorder: const CircleBorder(),
      child: Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
        ),
        child: SvgPicture.asset(
          'assets/icons/arrow_left.svg',
          width: 20,
          height: 20,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
      ),
    );
  }
}

/// Dark camera viewport with a dashed, corner-bracketed guide box and a
/// centered [watermark] + [badgeLabel] pill — the DNI capture frame shared
/// by the "captura-dni-frente" and "captura-dni-dorso" screens.
class DocumentViewfinder extends StatelessWidget {
  const DocumentViewfinder({
    super.key,
    required this.badgeLabel,
    required this.watermark,
    this.guideBorderAlpha = 0.2,
  });

  final String badgeLabel;
  final Widget watermark;

  /// Opacity of the dashed guide border (varies slightly between screens
  /// in the Figma file).
  final double guideBorderAlpha;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      width: double.infinity,
      alignment: Alignment.center,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.textPrimary,
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        borderRadius: BorderRadius.circular(28),
      ),
      child: SizedBox(
        width: 320,
        height: 200,
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            CustomPaint(
              painter: DashedBorderPainter(
                color: Colors.white.withValues(alpha: guideBorderAlpha),
                radius: 16,
              ),
            ),
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Opacity(opacity: 0.15, child: watermark),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.accent.withValues(alpha: 0.15),
                border: Border.all(color: AppColors.accent),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                badgeLabel.toUpperCase(),
                style: AppTypography.smallAction.copyWith(fontSize: 11),
              ),
            ),
            CustomPaint(
              size: const Size(320, 200),
              painter: const _GuideCornersPainter(),
            ),
          ],
        ),
      ),
    );
  }
}

/// Four accent-yellow L-shaped corner brackets around a capture guide box,
/// matching Figma's "Frame" corner decorations.
class _GuideCornersPainter extends CustomPainter {
  const _GuideCornersPainter();

  static const length = 20.0;
  static const thickness = 4.0;
  static const outset = 4.5;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.accent
      ..style = PaintingStyle.fill;
    final r = Radius.circular(thickness / 2);

    void corner(Offset origin, bool right, bool bottom) {
      final hx = right ? origin.dx - length : origin.dx;
      final vx = right ? origin.dx - thickness : origin.dx;
      final hy = bottom ? origin.dy - thickness : origin.dy;
      final vy = bottom ? origin.dy - length : origin.dy;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(hx, hy, length, thickness),
          r,
        ),
        paint,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(vx, vy, thickness, length), r),
        paint,
      );
    }

    corner(Offset(-outset, -outset), false, false);
    corner(Offset(size.width + outset, -outset), true, false);
    corner(Offset(-outset, size.height + outset), false, true);
    corner(Offset(size.width + outset, size.height + outset), true, true);
  }

  @override
  bool shouldRepaint(_GuideCornersPainter oldDelegate) => false;
}

/// Shutter button + "Subir desde galería" pill, shared by the DNI capture
/// screens.
class VerificationCaptureControls extends StatelessWidget {
  const VerificationCaptureControls({
    super.key,
    required this.onCapture,
    required this.onUpload,
  });

  final VoidCallback onCapture;
  final VoidCallback onUpload;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: onCapture,
          customBorder: const CircleBorder(),
          child: Container(
            width: 80,
            height: 80,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.textPrimary,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.surface, width: 4),
            ),
            child: Container(
              width: 64,
              height: 64,
              decoration: const BoxDecoration(
                color: AppColors.surface,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sectionGap),
        InkWell(
          onTap: onUpload,
          borderRadius: BorderRadius.circular(AppRadius.pill),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
              borderRadius: BorderRadius.circular(AppRadius.pill),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  'assets/icons/image.svg',
                  width: 16,
                  height: 16,
                ),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  'Subir desde galería',
                  style: AppTypography.itemTitle.copyWith(
                    color: AppColors.surface,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
