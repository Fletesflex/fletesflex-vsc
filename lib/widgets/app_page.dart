import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/theme.dart';

/// Layout of the [AppTopBar].
enum TopBarStyle {
  /// Plain back arrow + left-aligned title ("Paso 1: Direcciones").
  leading,

  /// Circular bordered back button + centered title
  /// ("Perfil del transportista").
  centered,
}

/// Standard screen layout shared by most Figma screens: an optional
/// [AppTopBar], a scrollable body with the 24px page margin, and an optional
/// bottom action area pinned to the bottom.
class AppPage extends StatelessWidget {
  const AppPage({
    super.key,
    this.title,
    this.topBarStyle = TopBarStyle.leading,
    this.showBack = true,
    this.onBack,
    this.trailing,
    this.header,
    required this.children,
    this.bottom,
    this.elevatedBottom = false,
    this.bodyPadding = const EdgeInsets.fromLTRB(
      AppSpacing.lg,
      AppSpacing.md,
      AppSpacing.lg,
      AppSpacing.lg,
    ),
    this.crossAxisAlignment = CrossAxisAlignment.stretch,
  });

  /// When null (and [header] is null), no top bar is shown.
  final String? title;
  final TopBarStyle topBarStyle;
  final bool showBack;
  final VoidCallback? onBack;
  final Widget? trailing;

  /// Custom non-scrolling header; replaces the [AppTopBar].
  final Widget? header;
  final List<Widget> children;

  /// Pinned below the scrollable body.
  final Widget? bottom;

  /// Renders [bottom] on a white sheet with a top border and upward shadow
  /// (sticky action bar) instead of directly on the background.
  final bool elevatedBottom;
  final EdgeInsetsGeometry bodyPadding;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: !elevatedBottom,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (header != null)
              header!
            else if (title != null) ...[
              SizedBox(
                height: topBarStyle == TopBarStyle.centered
                    ? AppSpacing.sm
                    : AppSpacing.md,
              ),
              AppTopBar(
                title: title!,
                style: topBarStyle,
                showBack: showBack,
                onBack: onBack,
                trailing: trailing,
              ),
              if (topBarStyle == TopBarStyle.centered)
                const SizedBox(height: AppSpacing.sm),
            ],
            Expanded(
              child: SingleChildScrollView(
                padding: bodyPadding,
                child: Column(
                  crossAxisAlignment: crossAxisAlignment,
                  children: children,
                ),
              ),
            ),
            if (bottom != null && !elevatedBottom)
              Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: bottom,
              ),
            if (bottom != null && elevatedBottom)
              Container(
                decoration: const BoxDecoration(
                  color: AppColors.surface,
                  border: Border(top: BorderSide(color: AppColors.border)),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x0F000000),
                      offset: Offset(0, -4),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: SafeArea(
                  top: false,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.lg,
                      AppSpacing.md,
                      AppSpacing.lg,
                      AppSpacing.lg,
                    ),
                    child: bottom,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Top bar with a back control, a title and an optional [trailing] widget.
class AppTopBar extends StatelessWidget {
  const AppTopBar({
    super.key,
    required this.title,
    this.style = TopBarStyle.leading,
    this.showBack = true,
    this.onBack,
    this.trailing,
  });

  final String title;
  final TopBarStyle style;
  final bool showBack;

  /// Defaults to popping the current route.
  final VoidCallback? onBack;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final back = onBack ?? () => Navigator.of(context).maybePop();

    if (style == TopBarStyle.centered) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        child: Row(
          children: [
            if (showBack)
              CircleIconButton(
                iconAsset: 'assets/icons/arrow_left_sm.svg',
                onTap: back,
              )
            else
              const SizedBox(width: 40),
            Expanded(
              child: Text(
                title,
                style: AppTypography.appBarTitle,
                textAlign: TextAlign.center,
              ),
            ),
            trailing ?? const SizedBox(width: 40),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Row(
        children: [
          if (showBack) ...[
            InkResponse(
              onTap: back,
              radius: 20,
              child: SvgPicture.asset(
                'assets/icons/arrow_left.svg',
                width: 24,
                height: 24,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
          ],
          Expanded(child: Text(title, style: AppTypography.appBarTitle)),
          ?trailing,
        ],
      ),
    );
  }
}

/// 40px white circle with a border holding an 18px icon.
class CircleIconButton extends StatelessWidget {
  const CircleIconButton({
    super.key,
    required this.iconAsset,
    required this.onTap,
  });

  final String iconAsset;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.surface,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.border, width: 1.5),
        ),
        child: SvgPicture.asset(iconAsset, width: 18, height: 18),
      ),
    );
  }
}

/// Visual treatment of a [StepIndicator].
enum StepIndicatorStyle {
  /// Reached steps are long accent bars, upcoming steps are short neutral
  /// dots (fixed widths, row shrink-wraps its content).
  dots,

  /// Every step is an equal-width bar stretched to fill the row.
  bars,
}

/// Row of pill segments showing progress through a multi-step flow.
class StepIndicator extends StatelessWidget {
  const StepIndicator({
    super.key,
    required this.current,
    required this.total,
    this.style = StepIndicatorStyle.dots,
  });

  /// Zero-based index of the active step.
  final int current;
  final int total;
  final StepIndicatorStyle style;

  @override
  Widget build(BuildContext context) {
    final bars = style == StepIndicatorStyle.bars;
    return Row(
      mainAxisSize: bars ? MainAxisSize.max : MainAxisSize.min,
      children: [
        for (var i = 0; i < total; i++) ...[
          if (i > 0) SizedBox(width: bars ? AppSpacing.xs : 6),
          if (bars)
            Expanded(
              child: Container(
                height: 4,
                decoration: BoxDecoration(
                  color: i <= current ? AppColors.accent : AppColors.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            )
          else
            Container(
              width: i <= current ? 32 : 8,
              height: 6,
              decoration: BoxDecoration(
                color: i <= current ? AppColors.accent : AppColors.border,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
        ],
      ],
    );
  }
}
