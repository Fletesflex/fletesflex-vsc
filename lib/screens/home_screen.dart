import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/theme.dart';
import '../widgets/widgets.dart';

/// Home screen, implemented from the Figma "Home" design
/// (file neRKyJz313WM7CEdoZdgGl, node 2:50), reusing the tokens in
/// `lib/theme/`.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _handleMudanzaTap() {
    // TODO: navigate to the "Mudanza" request flow.
  }

  void _handleFleteTap() {
    // TODO: navigate to the "Flete" request flow.
  }

  void _handleMensajeriaTap() {
    // TODO: navigate to the "Mensajería" request flow.
  }

  void _handleNotificationsTap() {
    // TODO: navigate to notifications.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: AppSpacing.sectionGap),
                _Header(onNotificationsTap: _handleNotificationsTap),
                const SizedBox(height: AppSpacing.sectionGap),
                const _SectionIntro(),
                const SizedBox(height: AppSpacing.lg),
                CategoryCard(
                  iconAsset: 'assets/icons/home_house.svg',
                  title: 'Mudanza',
                  description: 'Servicio completo: camión grande con '
                      'peones/ayudantes incluidos para embalar y cargar.',
                  badgeLabel: 'Recomendado',
                  selected: true,
                  onTap: _handleMudanzaTap,
                ),
                const SizedBox(height: AppSpacing.md),
                CategoryCard(
                  iconAsset: 'assets/icons/home_truck.svg',
                  title: 'Flete',
                  description: 'Solo vehículo. Ideal para llevar muebles '
                      'grandes sueltos o compras de corralón.',
                  onTap: _handleFleteTap,
                ),
                const SizedBox(height: AppSpacing.md),
                CategoryCard(
                  iconAsset: 'assets/icons/home_package.svg',
                  title: 'Mensajería',
                  description: 'Para objetos chicos, llaves, papeles. '
                      'Tarifas súper económicas calculadas por km.',
                  onTap: _handleMensajeriaTap,
                ),
                const SizedBox(height: AppSpacing.lg),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.onNotificationsTap});

  final VoidCallback onNotificationsTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const CircleAvatar(
              radius: 20,
              backgroundImage:
                  AssetImage('assets/images/avatar_placeholder.png'),
            ),
            const SizedBox(width: AppSpacing.sm),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hola, bienvenido', style: AppTypography.greeting),
                Text('Mateo Silva', style: AppTypography.userName),
              ],
            ),
          ],
        ),
        _IconButton(
          iconAsset: 'assets/icons/bell_ring.svg',
          onTap: onNotificationsTap,
        ),
      ],
    );
  }
}

class _IconButton extends StatelessWidget {
  const _IconButton({required this.iconAsset, required this.onTap});

  final String iconAsset;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.sm),
      child: Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border.all(color: AppColors.border, width: 1.5),
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        child: SvgPicture.asset(iconAsset, width: 20, height: 20),
      ),
    );
  }
}

class _SectionIntro extends StatelessWidget {
  const _SectionIntro();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('¿Qué necesitás trasladar hoy?', style: AppTypography.sectionTitle),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'Elegí la opción que mejor se adapte a tu carga.',
          style: AppTypography.sectionSubtitle,
        ),
      ],
    );
  }
}
