import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../routes.dart';
import '../theme/theme.dart';
import '../widgets/widgets.dart';

class _BienvenidaPage {
  const _BienvenidaPage({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final String icon;
  final String title;
  final String subtitle;
}

const _pages = [
  _BienvenidaPage(
    icon: 'assets/icons/truck.svg',
    title: 'Pedí tu mudanza o flete',
    subtitle:
        'Contanos qué necesitás trasladar y desde dónde. Es rápido y sin '
        'llamadas.',
  ),
  _BienvenidaPage(
    icon: 'assets/icons/tag_accent.svg',
    title: 'Elegí al transportista',
    subtitle:
        'Recibís ofertas de transportistas verificados y elegís con precio, '
        'reseñas y vehículo a la vista.',
  ),
  _BienvenidaPage(
    icon: 'assets/icons/shield_check.svg',
    title: 'Pagá seguro y calificá',
    subtitle:
        'El servicio queda reservado con tu pago. Cuando termina, calificás '
        'la experiencia.',
  ),
];

/// Onboarding carousel, implemented from the Figma "bienvenida-1" (2071:26),
/// "bienvenida-2" (2071:62) and "bienvenida-3" (2071:95) designs (file
/// neRKyJz313WM7CEdoZdgGl), reusing the tokens in `lib/theme/`. A single
/// swipeable [PageView] of 3 pages with an animated page indicator.
class BienvenidaScreen extends StatefulWidget {
  const BienvenidaScreen({super.key});

  @override
  State<BienvenidaScreen> createState() => _BienvenidaScreenState();
}

class _BienvenidaScreenState extends State<BienvenidaScreen> {
  final PageController _controller = PageController();
  int _page = 0;

  bool get _isLast => _page == _pages.length - 1;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _goToLogin() {
    Navigator.of(context).pushReplacementNamed(AppRoutes.login);
  }

  void _next() {
    if (_isLast) {
      _goToLogin();
      return;
    }
    _controller.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.xs,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Opacity(
                    opacity: _isLast ? 0 : 1,
                    child: IgnorePointer(
                      ignoring: _isLast,
                      child: InkWell(
                        onTap: _goToLogin,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.xxs,
                            vertical: AppSpacing.xxs,
                          ),
                          child: Text(
                            'Omitir',
                            style: AppTypography.caption.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (i) => setState(() => _page = i),
                children: [
                  for (final page in _pages) _BienvenidaPageView(page: page),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                0,
                AppSpacing.lg,
                AppSpacing.sm,
              ),
              child: PrimaryButton(
                label: _isLast ? 'Empezar' : 'Siguiente',
                onPressed: _next,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BienvenidaPageView extends StatelessWidget {
  const _BienvenidaPageView({required this.page});

  final _BienvenidaPage page;

  @override
  Widget build(BuildContext context) {
    final index = _pages.indexOf(page);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _Illustration(iconAsset: page.icon),
          const SizedBox(height: AppSpacing.sectionGap),
          Text(
            page.title,
            style: AppTypography.headline.copyWith(fontSize: 28),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.sectionGap),
          Text(
            page.subtitle,
            style: AppTypography.subtitle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.sectionGap),
          _PageDots(current: index),
        ],
      ),
    );
  }
}

/// Two soft blobs behind a dark rounded-square icon tile, with a small
/// accent dot and an outline ring orbiting it.
class _Illustration extends StatelessWidget {
  const _Illustration({required this.iconAsset});

  final String iconAsset;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 300,
      child: Stack(
        children: [
          Positioned(
            left: 20,
            top: 20,
            child: Container(
              width: 260,
              height: 260,
              decoration: const BoxDecoration(
                color: AppColors.heroBlobYellow,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            left: 190,
            top: 0,
            child: Container(
              width: 120,
              height: 120,
              decoration: const BoxDecoration(
                color: AppColors.heroBlobGray,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            left: 84,
            top: 84,
            child: Container(
              width: 132,
              height: 132,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.textPrimary,
                borderRadius: BorderRadius.circular(36),
                boxShadow: AppShadows.soft,
              ),
              child: SvgPicture.asset(iconAsset, width: 64, height: 64),
            ),
          ),
          Positioned(
            left: 36,
            top: 60,
            child: Container(
              width: 16,
              height: 16,
              decoration: const BoxDecoration(
                color: AppColors.accent,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            left: 250,
            top: 240,
            child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.textPrimary, width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Animated page indicator: the active page is a wide accent pill, the rest
/// are small neutral dots.
class _PageDots extends StatelessWidget {
  const _PageDots({required this.current});

  final int current;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < _pages.length; i++) ...[
          if (i > 0) const SizedBox(width: AppSpacing.xs),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            width: i == current ? 24 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: i == current ? AppColors.accent : AppColors.border,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ],
    );
  }
}
