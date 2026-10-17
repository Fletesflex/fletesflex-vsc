import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/theme.dart';

/// Decorative "broadcasting" hero: three nested soft-yellow pills behind a
/// dark 80px circle holding [iconAsset].
class PulseHero extends StatelessWidget {
  const PulseHero({
    super.key,
    required this.iconAsset,
    this.iconSize = 44,
    this.circleColor = AppColors.textPrimary,
  });

  final String iconAsset;
  final double iconSize;
  final Color circleColor;

  @override
  Widget build(BuildContext context) {
    Widget pill(double width, double radius, double alpha) => Container(
          width: width,
          height: 280,
          decoration: BoxDecoration(
            color: AppColors.iconSurface.withValues(alpha: alpha),
            borderRadius: BorderRadius.circular(radius),
          ),
        );

    return SizedBox(
      height: 360,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          pill(280, 140, 0.15),
          pill(200, 100, 0.3),
          pill(120, 60, 0.5),
          Container(
            width: 80,
            height: 80,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: circleColor,
              shape: BoxShape.circle,
              boxShadow: AppShadows.soft,
            ),
            child: SvgPicture.asset(
              iconAsset,
              width: iconSize,
              height: iconSize,
            ),
          ),
        ],
      ),
    );
  }
}

/// Three 8px dots fading out (100% / 60% / 30%).
class LoadingDots extends StatelessWidget {
  const LoadingDots({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (final (i, alpha) in [1.0, 0.6, 0.3].indexed) ...[
          if (i > 0) const SizedBox(width: AppSpacing.xxs),
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: AppColors.textPrimary.withValues(alpha: alpha),
              shape: BoxShape.circle,
            ),
          ),
        ],
      ],
    );
  }
}


/// A small decoration placed at an absolute offset inside an
/// [OrbitIllustration].
class OrbitDecoration {
  const OrbitDecoration(
    this.asset,
    this.left,
    this.top,
    this.size, {
    this.rotation = 0,
  });

  final String asset;
  final double left;
  final double top;
  final double size;

  /// Clockwise rotation in degrees.
  final double rotation;
}

/// Concentric soft rings behind a dark circle holding an icon, with small
/// dots/sparkles around it (offer sent, empty states).
class OrbitIllustration extends StatelessWidget {
  const OrbitIllustration({
    super.key,
    required this.size,
    required this.rings,
    required this.centerSize,
    required this.iconAsset,
    this.iconSize = 28,
    this.decorations = const [],
  });

  final double size;

  /// (asset, diameter, opacity) from outermost to innermost. PNG assets are
  /// drawn with [Image.asset], SVGs with [SvgPicture.asset].
  final List<(String, double, double)> rings;
  final double centerSize;
  final String iconAsset;
  final double iconSize;
  final List<OrbitDecoration> decorations;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          for (final (asset, diameter, opacity) in rings)
            Opacity(
              opacity: opacity,
              child: asset.endsWith('.svg')
                  ? SvgPicture.asset(asset, width: diameter, height: diameter)
                  : Image.asset(asset, width: diameter, height: diameter),
            ),
          Container(
            width: centerSize,
            height: centerSize,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.textPrimary,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.accentDeep.withValues(alpha: 0.25),
                  offset: const Offset(0, 6),
                  blurRadius: 8,
                ),
              ],
            ),
            child: SvgPicture.asset(
              iconAsset,
              width: iconSize,
              height: iconSize,
            ),
          ),
          for (final d in decorations)
            Positioned(
              left: d.left,
              top: d.top,
              child: Transform.rotate(
                angle: d.rotation * 3.1415926535 / 180,
                child: SvgPicture.asset(d.asset, width: d.size, height: d.size),
              ),
            ),
        ],
      ),
    );
  }
}

/// Result mark used on success / failure screens: a soft-yellow ring and
/// glow behind a dark rounded square holding [iconAsset], surrounded by
/// small sparkles. Decorations are positioned by their center, relative to
/// the center of the 140px canvas.
class SuccessBurst extends StatelessWidget {
  const SuccessBurst({
    super.key,
    this.iconAsset = 'assets/icons/check_bold.svg',
    this.iconWidth = 25.2,
    this.iconHeight = 23.4,
    this.glowAsset = 'assets/images/burst_glow.png',
    this.glowOpacity = 0.6,
    this.centerOffsetY = -5,
    this.decorations = defaultDecorations,
    this.ringAsset = 'assets/icons/burst_ring.svg',
  });

  /// Sparkles of the success variant.
  static const defaultDecorations = [
    OrbitDecoration('assets/icons/sparkle_gold.svg', -55, -35, 16),
    OrbitDecoration('assets/icons/circle_accent.svg', 50, -45, 12),
    OrbitDecoration('assets/icons/sparkle_dark.svg', 55, 25, 14),
    OrbitDecoration('assets/icons/check_circle_mini.svg', -45, 40, 16),
  ];

  /// Sparkles of the error variant (no check mark).
  static const errorDecorations = [
    OrbitDecoration('assets/icons/sparkle_gold.svg', -52, -30, 16),
    OrbitDecoration('assets/icons/circle_accent.svg', 48, -42, 12),
    OrbitDecoration('assets/icons/sparkle_dark.svg', 52, 28, 14),
  ];

  final String iconAsset;
  final double iconWidth;
  final double iconHeight;
  final String glowAsset;
  final double glowOpacity;
  final double centerOffsetY;
  final List<OrbitDecoration> decorations;
  final String ringAsset;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: Center(
        child: SizedBox(
          width: 140,
          height: 140,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset(ringAsset, width: 100, height: 100),
              Opacity(
                opacity: glowOpacity,
                child: Image.asset(glowAsset, width: 120, height: 120),
              ),
              Transform.translate(
                offset: Offset(0, centerOffsetY),
                child: Container(
                  width: 74,
                  height: 74,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.textPrimary,
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.accentDeep.withValues(alpha: 0.15),
                        offset: const Offset(0, 8),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: SvgPicture.asset(
                    iconAsset,
                    width: iconWidth,
                    height: iconHeight,
                  ),
                ),
              ),
              for (final d in decorations)
                Positioned(
                  left: 70 + d.left - d.size / 2,
                  top: 70 + d.top - d.size / 2,
                  child: SvgPicture.asset(
                    d.asset,
                    width: d.size,
                    height: d.size,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Circular progress illustration: soft glow, gray track with a dark arc
/// and a white badge holding [iconAsset] in the middle.
class SpinnerBadge extends StatefulWidget {
  const SpinnerBadge({super.key, required this.iconAsset});

  final String iconAsset;

  @override
  State<SpinnerBadge> createState() => _SpinnerBadgeState();
}

class _SpinnerBadgeState extends State<SpinnerBadge>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1200),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      height: 140,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/ambient_glow.svg',
            width: 120,
            height: 120,
          ),
          SvgPicture.asset(
            'assets/icons/spinner_track.svg',
            width: 96,
            height: 96,
          ),
          RotationTransition(
            turns: _controller,
            child: SvgPicture.asset(
              'assets/icons/spinner_active.svg',
              width: 96,
              height: 96,
            ),
          ),
          Container(
            width: 54,
            height: 54,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.surface,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.textPrimary.withValues(alpha: 0.05),
                  offset: const Offset(0, 6),
                  blurRadius: 8,
                ),
              ],
            ),
            child: SvgPicture.asset(widget.iconAsset, width: 24, height: 24),
          ),
        ],
      ),
    );
  }
}
