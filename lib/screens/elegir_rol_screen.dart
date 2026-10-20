import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../routes.dart';
import '../theme/theme.dart';
import '../widgets/widgets.dart';

/// Which side of the app the signed-up account will use.
enum _UserRole { solicitante, transportista }

/// "Elegir rol" screen, implemented from the Figma "elegir-rol" design
/// (file neRKyJz313WM7CEdoZdgGl, node 2049:2), reusing the tokens in
/// `lib/theme/`.
class ElegirRolScreen extends StatefulWidget {
  const ElegirRolScreen({super.key});

  @override
  State<ElegirRolScreen> createState() => _ElegirRolScreenState();
}

class _ElegirRolScreenState extends State<ElegirRolScreen> {
  _UserRole _role = _UserRole.solicitante;

  void _handleContinue() {
    final target = _role == _UserRole.solicitante
        ? AppRoutes.home
        : AppRoutes.verificacionIntro;
    Navigator.of(context).pushNamedAndRemoveUntil(target, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.lg,
                  AppSpacing.lg,
                  AppSpacing.lg,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '¿Cómo vas a usar FletesFlex?',
                      style: AppTypography.headline,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'Elegí tu perfil y te mostramos lo que necesitás.',
                      style: AppTypography.subtitle,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    _RoleCard(
                      iconAsset: 'assets/icons/role_pin.svg',
                      title: 'Necesito un servicio',
                      description: 'Pedí mudanzas, fletes o mensajería y '
                          'recibí cotizaciones de transportistas.',
                      chipIcon: 'assets/icons/role_zap.svg',
                      chipLabel: 'Cotizaciones al instante',
                      selected: _role == _UserRole.solicitante,
                      onTap: () =>
                          setState(() => _role = _UserRole.solicitante),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    _RoleCard(
                      iconAsset: 'assets/icons/role_truck.svg',
                      title: 'Soy transportista',
                      description: 'Ofertá en los pedidos de tu zona y '
                          'generá ingresos con tu vehículo.',
                      chipIcon: 'assets/icons/role_shield_check.svg',
                      chipLabel: 'Requiere verificar tu identidad',
                      selected: _role == _UserRole.transportista,
                      onTap: () =>
                          setState(() => _role = _UserRole.transportista),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                children: [
                  PrimaryButton(label: 'Continuar', onPressed: _handleContinue),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Al continuar aceptás los Términos y la Política de '
                    'privacidad.',
                    textAlign: TextAlign.center,
                    style: AppTypography.caption,
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

class _RoleCard extends StatelessWidget {
  const _RoleCard({
    required this.iconAsset,
    required this.title,
    required this.description,
    required this.chipIcon,
    required this.chipLabel,
    required this.selected,
    required this.onTap,
  });

  final String iconAsset;
  final String title;
  final String description;
  final String chipIcon;
  final String chipLabel;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.xl),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.cardPadding),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.xl),
          border: Border.all(
            color: selected ? AppColors.accent : AppColors.border,
            width: selected ? 2 : 1.5,
          ),
          boxShadow: selected ? AppShadows.elevated : AppShadows.soft,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 48,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.iconSurface,
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              child: SvgPicture.asset(iconAsset, width: 26, height: 26),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(title, style: AppTypography.cardTitle),
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      _RoleRadio(selected: selected),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xxs),
                  Text(description, style: AppTypography.cardDescription),
                  const SizedBox(height: AppSpacing.sm),
                  AppTag(
                    chipLabel,
                    leading: SvgPicture.asset(
                      chipIcon,
                      width: 14,
                      height: 14,
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

/// 22px selection indicator: solid accent fill with a check when [selected],
/// plain outline otherwise.
class _RoleRadio extends StatelessWidget {
  const _RoleRadio({required this.selected});

  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: 22,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: selected ? AppColors.accent : AppColors.surface,
        border: Border.all(
          color: selected ? AppColors.accent : AppColors.border,
          width: 1.5,
        ),
      ),
      child: selected
          ? SvgPicture.asset(
              'assets/icons/check_sm.svg',
              width: 12,
              height: 12,
            )
          : null,
    );
  }
}
