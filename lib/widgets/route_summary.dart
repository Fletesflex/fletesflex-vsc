import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/theme.dart';

/// Soft-yellow rounded square/circle holding a route letter ("A", "B").
/// The origin letter is dark; the destination uses [AppColors.accentDeep].
class RouteMarker extends StatelessWidget {
  const RouteMarker(this.letter, {super.key, this.size = 24, this.color});

  final String letter;
  final double size;

  /// Defaults to dark for "A" and deep amber otherwise.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.iconSurface,
        borderRadius: BorderRadius.circular(size / 2),
      ),
      child: Text(
        letter,
        style: AppTypography.marker.copyWith(
          fontSize: size <= 20 ? 11 : 12,
          color: color ??
              (letter == 'A' ? AppColors.textPrimary : AppColors.accentDeep),
        ),
      ),
    );
  }
}

/// Compact origin → destination list: one [RouteMarker] + address per row,
/// joined by a short vertical connector.
class RouteSummary extends StatelessWidget {
  const RouteSummary({
    super.key,
    required this.origin,
    required this.destination,
    this.textStyle,
  });

  final String origin;
  final String destination;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final style = textStyle ?? AppTypography.routeText;
    Widget row(String letter, String text) => Row(
          children: [
            RouteMarker(letter, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Text(text, style: style, overflow: TextOverflow.ellipsis),
            ),
          ],
        );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        row('A', origin),
        // Vertical connector centered under the 20px marker.
        Padding(
          padding: const EdgeInsets.only(left: 9.25),
          child: RotatedBox(
            quarterTurns: 1,
            child: SvgPicture.asset(
              'assets/icons/line_connector.svg',
              width: 12,
              height: 1.5,
            ),
          ),
        ),
        row('B', destination),
      ],
    );
  }
}
