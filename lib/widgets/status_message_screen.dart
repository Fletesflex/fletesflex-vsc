import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/theme.dart';
import 'primary_button.dart';
import 'service_status_widgets.dart';

/// Full-screen icon + title + message layout shared by the app's generic
/// status screens ("sin conexión", "algo salió mal", "cuenta suspendida",
/// camera/location permission primers), implemented from the Figma
/// "estado-*" / "permiso-*" designs (file neRKyJz313WM7CEdoZdgGl, nodes
/// 2069:287, 2069:314, 2069:339, 2069:363, 2069:387), which all share the
/// same icon-circle/title/body/actions layout.
class StatusMessageScreen extends StatelessWidget {
  const StatusMessageScreen({
    super.key,
    required this.iconAsset,
    this.iconBackground = AppColors.iconSurface,
    this.iconColor,
    required this.title,
    required this.message,
    required this.primaryLabel,
    required this.onPrimary,
    this.secondaryLabel,
    this.onSecondary,
    this.secondaryColor = AppColors.textPrimary,
  });

  final String iconAsset;
  final Color iconBackground;
  final Color? iconColor;
  final String title;
  final String message;
  final String primaryLabel;
  final VoidCallback onPrimary;

  /// Optional second action below the primary button ("Ahora no", "Volver
  /// al inicio", "Cerrar sesión").
  final String? secondaryLabel;
  final VoidCallback? onSecondary;
  final Color secondaryColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 104,
                        height: 104,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: iconBackground,
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          iconAsset,
                          width: 48,
                          height: 48,
                          colorFilter: iconColor == null
                              ? null
                              : ColorFilter.mode(iconColor!, BlendMode.srcIn),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        title,
                        style: AppTypography.headline.copyWith(fontSize: 24),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        message,
                        style: AppTypography.body,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                0,
                AppSpacing.lg,
                AppSpacing.md,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  PrimaryButton(label: primaryLabel, onPressed: onPrimary),
                  if (secondaryLabel != null) ...[
                    CenteredTextLink(
                      label: secondaryLabel!,
                      color: secondaryColor,
                      onTap: onSecondary ?? () {},
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
