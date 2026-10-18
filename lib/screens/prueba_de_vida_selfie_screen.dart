import 'package:flutter/material.dart';

import '../routes.dart';
import '../theme/theme.dart';
import '../widgets/widgets.dart';

/// Step 3 of 4 in the carrier identity-verification flow: the liveness
/// selfie. Implemented from the Figma "prueba-de-vida-selfie" design (file
/// neRKyJz313WM7CEdoZdgGl, node 17:4), reusing the tokens in `lib/theme/`
/// and the camera chrome from the DNI capture steps.
class PruebaDeVidaSelfieScreen extends StatelessWidget {
  const PruebaDeVidaSelfieScreen({super.key});

  void _handleAutoCapture(BuildContext context) {
    // TODO: run on-device face detection and capture the selfie
    // automatically once a face is framed; this tap is a stand-in trigger.
    Navigator.of(context).pushNamed(AppRoutes.verificacionProcesando);
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
      backgroundColor: AppColors.textPrimary,
      header: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.xs,
          AppSpacing.lg,
          0,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const DarkCircleBackButton(),
                Row(
                  children: const [
                    StepCompletedChip(label: 'DNI frente'),
                    SizedBox(width: 6),
                    StepCompletedChip(label: 'DNI dorso'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const StepDotsRow(completed: 2, total: 4),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  'PASO 3 DE 4',
                  style: AppTypography.overline.copyWith(color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xxs),
            Text(
              'Ahora, una foto tuya',
              style: AppTypography.headline.copyWith(
                fontSize: 22,
                color: AppColors.surface,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
          child: GestureDetector(
            onTap: () => _handleAutoCapture(context),
            child: _SelfieViewfinder(),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
          child: Column(
            children: [
              Text(
                'Mirá al frente y parpadeá',
                style: AppTypography.cardHeading.copyWith(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xxs),
              Text(
                'La captura es automática al detectar tu rostro',
                style: AppTypography.chip.copyWith(
                  color: Colors.white.withValues(alpha: 0.7),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.sm),
              Container(
                width: 60,
                height: 1,
                color: Colors.white.withValues(alpha: 0.2),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Esto confirma que sos vos y que coincidís con la foto de tu '
                'DNI. No almacenamos datos biométricos.',
                style: AppTypography.caption.copyWith(
                  color: Colors.white.withValues(alpha: 0.7),
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Dark camera viewport with a soft glow and a dashed oval face guide, used
/// only by the liveness-selfie step.
class _SelfieViewfinder extends StatelessWidget {
  const _SelfieViewfinder();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 340,
      width: double.infinity,
      alignment: Alignment.center,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.textPrimary,
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 240,
            height: 310,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.elliptical(120, 155),
              ),
              gradient: RadialGradient(
                colors: [
                  AppColors.accent.withValues(alpha: 0.18),
                  AppColors.accent.withValues(alpha: 0),
                ],
              ),
            ),
          ),
          CustomPaint(
            size: const Size(210, 280),
            painter: const _DashedOvalPainter(
              color: AppColors.accent,
              strokeWidth: 2,
            ),
          ),
        ],
      ),
    );
  }
}

/// Dashed oval outline, the face-framing guide inside [_SelfieViewfinder].
class _DashedOvalPainter extends CustomPainter {
  const _DashedOvalPainter({required this.color, this.strokeWidth = 1.5});

  final Color color;
  final double strokeWidth;

  static const _dash = 8.0;
  static const _gap = 6.0;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    final path = Path()..addOval(Offset.zero & size);
    for (final metric in path.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        canvas.drawPath(
          metric.extractPath(distance, distance + _dash),
          paint,
        );
        distance += _dash + _gap;
      }
    }
  }

  @override
  bool shouldRepaint(_DashedOvalPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.strokeWidth != strokeWidth;
}
