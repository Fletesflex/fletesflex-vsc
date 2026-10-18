import 'package:flutter/material.dart';

import '../theme/theme.dart';
import '../widgets/widgets.dart';

/// Step 2 of 4 in the carrier identity-verification flow: back side of the
/// DNI. Implemented from the Figma "captura-dni-dorso" design (file
/// neRKyJz313WM7CEdoZdgGl, node 13:4), reusing the tokens in `lib/theme/`.
class CapturaDniDorsoScreen extends StatelessWidget {
  const CapturaDniDorsoScreen({super.key});

  void _handleCapture(BuildContext context) {
    // TODO: open the device camera and capture the DNI back photo, then
    // continue to the "prueba de vida" selfie step.
  }

  void _handleUpload(BuildContext context) {
    // TODO: open the gallery picker for the DNI back photo.
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
              children: [
                const DarkCircleBackButton(),
                const Expanded(
                  child: Center(
                    child: StepCompletedChip(label: 'Frente completado'),
                  ),
                ),
                const SizedBox(width: 40),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            const StepDotsRow(completed: 1, total: 4),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'PASO 2 DE 4',
              style: AppTypography.overline.copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xxs),
            Text(
              'Ahora el dorso de tu DNI',
              style: AppTypography.headline.copyWith(
                fontSize: 22,
                color: AppColors.surface,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      bottom: VerificationCaptureControls(
        onCapture: () => _handleCapture(context),
        onUpload: () => _handleUpload(context),
      ),
      children: [
        DocumentViewfinder(
          badgeLabel: 'Dorso del DNI',
          guideBorderAlpha: 0.15,
          watermark: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _watermarkBar(width: double.infinity, height: 8),
                        const SizedBox(height: 6),
                        _watermarkBar(width: 130, height: 6),
                        const SizedBox(height: 6),
                        _watermarkBar(width: 80, height: 6),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 36,
                    height: 36,
                    decoration: const BoxDecoration(
                      color: AppColors.surface,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const _Barcode(),
              const SizedBox(height: 2),
              _watermarkBar(width: 140, height: 5),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Text(
            'Asegurate de que el código de barras se vea completo y nítido.',
            style: AppTypography.caption.copyWith(
              color: Colors.white.withValues(alpha: 0.7),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class _Barcode extends StatelessWidget {
  const _Barcode();

  // Narrow/wide bar widths, cycled to approximate the Figma barcode pattern.
  static const _widths = [3.0, 2.0, 2.0, 3.0, 2.0, 1.0];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      child: Row(
        children: [
          for (var i = 0; i < 24; i++) ...[
            if (i > 0) const SizedBox(width: 1),
            Container(width: _widths[i % _widths.length], color: AppColors.surface),
          ],
        ],
      ),
    );
  }
}

Widget _watermarkBar({required double width, required double height}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(2),
    ),
  );
}
