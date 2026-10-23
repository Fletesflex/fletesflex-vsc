import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../routes.dart';
import '../theme/theme.dart';

/// Tabs of the carrier (transportista) side of the app.
enum CarrierTab {
  solicitudes(
    'Solicitudes',
    'assets/icons/nav_list.svg',
    AppRoutes.transportistaSolicitudes,
  ),
  ofertas('Mis ofertas', 'assets/icons/nav_tag.svg', AppRoutes.misOfertas),
  verificacion(
    'Verificación',
    'assets/icons/shield.svg',
    AppRoutes.estadoDocumentacion,
  ),
  avisos('Avisos', 'assets/icons/nav_bell.svg', AppRoutes.avisosTransportista),
  perfil(
    'Mi Perfil',
    'assets/icons/nav_user.svg',
    AppRoutes.miPerfilTransportista,
  );

  const CarrierTab(this.label, this.iconAsset, this.route);

  final String label;
  final String iconAsset;

  /// Null while the tab's screen isn't designed yet.
  final String? route;
}

/// Bottom navigation for the carrier side. The active tab is dark and bold,
/// the rest muted.
class CarrierNavBar extends StatelessWidget {
  const CarrierNavBar({super.key, required this.current});

  final CarrierTab current;

  void _go(BuildContext context, CarrierTab tab) {
    if (tab == current || tab.route == null) return;
    Navigator.of(context).pushReplacementNamed(tab.route!);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.sm,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (final tab in CarrierTab.values)
                InkWell(
                  onTap: () => _go(context, tab),
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                  child: SizedBox(
                    width: 68,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          tab.iconAsset,
                          width: 20,
                          height: 20,
                          colorFilter: ColorFilter.mode(
                            tab == current
                                ? AppColors.textPrimary
                                : AppColors.textMuted,
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xxs),
                        Text(
                          tab.label,
                          style: AppTypography.navLabel.copyWith(
                            color: tab == current
                                ? AppColors.textPrimary
                                : AppColors.textMuted,
                            fontWeight: tab == current
                                ? FontWeight.bold
                                : FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
