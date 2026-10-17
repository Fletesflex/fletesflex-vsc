import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../routes.dart';
import '../theme/theme.dart';

/// "Verifying your transfer" waiting screen, implemented from the Figma
/// "verificando-transferencia" design (file o7nkeARTqRUSPsNBaYg2nb,
/// node 33:76).
class VerificandoTransferenciaScreen extends StatelessWidget {
  const VerificandoTransferenciaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: AppSpacing.sectionGap,
                ),
                // TODO: drop the tap shortcut once the backend pushes the
                // verification result.
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pushReplacementNamed(
                    AppRoutes.transferenciaConfirmada,
                    arguments: ModalRoute.of(context)?.settings.arguments,
                  ),
                  child: Column(
                    children: [
                      const _Illustration(),
                      const SizedBox(height: 32),
                      Text(
                        'Estamos verificando tu transferencia',
                        style: AppTypography.display.copyWith(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          height: 1.25,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        'Nuestro equipo confirma la recepción del pago. Esto '
                        'puede demorar hasta algunas horas hábiles. Te '
                        'avisamos apenas esté listo.',
                        style: AppTypography.body,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      const _ReceiptTile(
                        name: 'comprobante_transferencia.pdf',
                        detail: 'PDF • 240 KB • Recibido',
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.md,
                AppSpacing.lg,
                AppSpacing.lg,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '¿Necesitás ayuda? ',
                    style: AppTypography.itemSubtitle,
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).pushNamed(
                      AppRoutes.reporteProblema,
                    ),
                    child: Text(
                      'Soporte de FletesFlex',
                      style: AppTypography.itemSubtitle.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
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

class _Illustration extends StatelessWidget {
  const _Illustration();

  @override
  Widget build(BuildContext context) {
    Widget glow(double left, double top, double size, Color color,
            double sigma) =>
        Positioned(
          left: left,
          top: top,
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
          ),
        );

    return ClipOval(
      child: Container(
        width: 220,
        height: 220,
        color: AppColors.iconSurface,
        child: Stack(
          alignment: Alignment.center,
          children: [
            glow(-30, 120, 140, AppColors.accent.withValues(alpha: 0.08), 15),
            glow(110, -20, 120,
                AppColors.successBright.withValues(alpha: 0.06), 10),
            Image.asset(
              'assets/images/verifying_illustration.png',
              width: 160,
              height: 160,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}

class _ReceiptTile extends StatelessWidget {
  const _ReceiptTile({required this.name, required this.detail});

  final String name;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.iconSurface,
              borderRadius: BorderRadius.circular(AppRadius.chip),
            ),
            child: SvgPicture.asset(
              'assets/icons/file.svg',
              width: 20,
              height: 20,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTypography.pickerValue,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(detail, style: AppTypography.micro),
              ],
            ),
          ),
          Container(
            width: 20,
            height: 20,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: AppColors.discountSurface,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              'assets/icons/check_success_xs.svg',
              width: 10,
              height: 10,
            ),
          ),
        ],
      ),
    );
  }
}
