import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../routes.dart';
import '../theme/theme.dart';
import '../widgets/widgets.dart';

/// Step 1 of 4 in the carrier identity-verification flow: front side of the
/// DNI. Implemented from the Figma "captura-dni-frente" design (file
/// neRKyJz313WM7CEdoZdgGl, node 11:4), reusing the tokens in `lib/theme/`.
class CapturaDniFrenteScreen extends StatelessWidget {
  const CapturaDniFrenteScreen({super.key});

  void _handleCapture(BuildContext context) {
    // TODO: open the device camera and capture the DNI front photo.
    Navigator.of(context).pushNamed(AppRoutes.capturaDniDorso);
  }

  void _handleUpload(BuildContext context) {
    // TODO: open the gallery picker for the DNI front photo.
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
                  child: Center(child: StepDotsRow(completed: 0, total: 4)),
                ),
                const SizedBox(width: 40),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'PASO 1 DE 4',
              style: AppTypography.overline.copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xxs),
            Text(
              'Foto del frente de tu DNI',
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
          badgeLabel: 'Frente del DNI',
          guideBorderAlpha: 0.25,
          watermark: Row(
            children: [
              Container(
                width: 64,
                height: 80,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SvgPicture.asset(
                  'assets/icons/user_sm.svg',
                  width: 32,
                  height: 32,
                  colorFilter: const ColorFilter.mode(
                    AppColors.textPrimary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _watermarkBar(width: double.infinity, height: 10),
                    const SizedBox(height: 8),
                    _watermarkBar(width: 90, height: 8),
                    const SizedBox(height: 8),
                    _watermarkBar(width: 100, height: 8),
                    const SizedBox(height: 8),
                    _watermarkBar(width: 70, height: 8),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Text(
            'Asegurate de que se lean bien todos los datos, sin reflejos ni '
            'sombras molestas.',
            style: AppTypography.caption.copyWith(
              color: Colors.white.withValues(alpha: 0.6),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
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
