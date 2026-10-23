import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../routes.dart';
import '../theme/theme.dart';

/// Tabs of the requester (solicitante) side of the app.
enum RequesterTab {
  inicio('Inicio', 'assets/icons/nav_home.svg', AppRoutes.home),
  misServicios(
    'Mis servicios',
    'assets/icons/nav_clipboard.svg',
    AppRoutes.historialSolicitante,
  ),
  avisos('Avisos', 'assets/icons/nav_bell.svg', AppRoutes.avisosSolicitante),
  perfil('Perfil', 'assets/icons/nav_user.svg', AppRoutes.perfilSolicitante);

  const RequesterTab(this.label, this.iconAsset, this.route);

  final String label;
  final String iconAsset;

  /// Null while the tab's screen isn't designed yet.
  final String? route;
}

/// Bottom navigation for the requester side, implemented from the Figma
/// "bottom-nav" design (file neRKyJz313WM7CEdoZdgGl, node 2054:245). The
/// active tab is dark and bold, the rest muted.
class RequesterNavBar extends StatelessWidget {
  const RequesterNavBar({super.key, required this.current});

  final RequesterTab current;

  void _go(BuildContext context, RequesterTab tab) {
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
              for (final tab in RequesterTab.values)
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
