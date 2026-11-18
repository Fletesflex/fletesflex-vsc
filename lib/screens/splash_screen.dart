import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../routes.dart';
import '../theme/theme.dart';
import '../widgets/widgets.dart';

/// Splash screen, implemented from the Figma "splash" design (file
/// neRKyJz313WM7CEdoZdgGl, node 2071:2), reusing the tokens in
/// `lib/theme/`. Shows the brand mark for ~2s, then hands off to the
/// onboarding carousel.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 2), () {
      if (!mounted) return;
      // TODO: only show the bienvenida carousel the first time the app is
      // opened (persist a "seen onboarding" flag, e.g. with
      // shared_preferences) and go straight to login on later launches.
      Navigator.of(context).pushReplacementNamed(AppRoutes.bienvenida);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          const Positioned(
            left: -40,
            top: -40,
            child: _Blob(size: 260, color: AppColors.heroBlobYellow),
          ),
          Positioned(
            left: 240,
            top: size.height * 0.64,
            child: const _Blob(size: 180, color: AppColors.heroBlobGray),
          ),
          SafeArea(
            child: Column(
              children: [
                const Spacer(flex: 4),
                const _Logo(),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'Mudanzas y fletes, sin estrés',
                  style: AppTypography.subtitle.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(flex: 5),
                const LoadingDots(),
                const SizedBox(height: AppSpacing.lg),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Blob extends StatelessWidget {
  const _Blob({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 72,
          height: 72,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.textPrimary,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            boxShadow: AppShadows.soft,
          ),
          child: SvgPicture.asset(
            'assets/icons/truck.svg',
            width: 36,
            height: 36,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text('FletesFlex', style: AppTypography.logo),
      ],
    );
  }
}
