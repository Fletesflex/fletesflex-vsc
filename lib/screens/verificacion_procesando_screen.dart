import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../routes.dart';
import '../theme/theme.dart';

/// Step 4 of 4 in the carrier identity-verification flow: the RENAPER
/// processing wait screen. Implemented from the Figma
/// "verificacion-procesando" design (file neRKyJz313WM7CEdoZdgGl, node
/// 17:66), reusing the tokens in `lib/theme/`.
class VerificacionProcesandoScreen extends StatefulWidget {
  const VerificacionProcesandoScreen({super.key});

  @override
  State<VerificacionProcesandoScreen> createState() =>
      _VerificacionProcesandoScreenState();
}

class _VerificacionProcesandoScreenState
    extends State<VerificacionProcesandoScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // TODO: replace with the real RENAPER verification result; this always
    // routes to the approved outcome for now (see also
    // AppRoutes.verificacionRechazada for the rejected variant).
    _timer = Timer(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.of(
        context,
      ).pushReplacementNamed(AppRoutes.identidadVerificada);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.sectionGap,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const _ProcessingStepsRow(current: 4, total: 4),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  'PASO 4 DE 4',
                  style: AppTypography.overline.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppSpacing.sectionGap),
                const _ProcessingArtwork(),
                const SizedBox(height: AppSpacing.sectionGap),
                Text(
                  'Estamos verificando tus datos',
                  style: AppTypography.headline,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'Esto puede tardar unos segundos, por favor no cierres la '
                  'aplicación.',
                  style: AppTypography.body,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.sectionGap),
                Container(
                  width: 240,
                  height: 8,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                  alignment: Alignment.centerLeft,
                  child: FractionallySizedBox(
                    widthFactor: 0.65,
                    child: Container(
                      height: 8,
                      decoration: BoxDecoration(
                        color: AppColors.accent,
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.sectionGap),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.xs,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.iconSurface,
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/lock.svg',
                        width: 14,
                        height: 14,
                        colorFilter: const ColorFilter.mode(
                          AppColors.textPrimary,
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Text(
                        'Validación oficial con RENAPER',
                        style: AppTypography.featureLabel,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Row of numbered/checked step circles connected by thin lines, used only
/// by the processing screen's "Paso X de Y" header.
class _ProcessingStepsRow extends StatelessWidget {
  const _ProcessingStepsRow({required this.current, required this.total});

  /// 1-based index of the current step.
  final int current;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 1; i <= total; i++) ...[
          if (i > 1)
            Container(
              width: 12,
              height: 2,
              color: i <= current
                  ? AppColors.successSurface
                  : AppColors.border,
            ),
          if (i < current)
            Container(
              width: 24,
              height: 24,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: AppColors.successSurface,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                'assets/icons/check_sm.svg',
                width: 12,
                height: 12,
                colorFilter: const ColorFilter.mode(
                  AppColors.success,
                  BlendMode.srcIn,
                ),
              ),
            )
          else if (i == current)
            Container(
              width: 24,
              height: 24,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: AppColors.textPrimary,
                shape: BoxShape.circle,
              ),
              child: Text(
                '$i',
                style: AppTypography.smallAction.copyWith(
                  color: AppColors.accent,
                  fontSize: 11,
                ),
              ),
            )
          else
            Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(
                color: AppColors.border,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ],
    );
  }
}

/// Document-with-magnifying-glass illustration for the processing screen,
/// composed from plain containers to match the Figma "artwork" group.
class _ProcessingArtwork extends StatelessWidget {
  const _ProcessingArtwork();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
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
                        'assets/icons/check_sm.svg',
                        width: 20,
                        height: 20,
                        colorFilter: const ColorFilter.mode(
                          AppColors.success,
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
                          color: AppColors.accent,
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
