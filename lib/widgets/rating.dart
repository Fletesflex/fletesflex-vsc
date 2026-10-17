import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/theme.dart';

/// Star + numeric rating + optional muted suffix ("★ 4.9 (184 mudanzas)").
class RatingRow extends StatelessWidget {
  const RatingRow({
    super.key,
    required this.rating,
    this.suffix,
    this.large = false,
  });

  final double rating;
  final String? suffix;

  /// Profile-header size (16px amber star, 15/14 text) instead of the
  /// compact card size (14px outline star, 12 text).
  final bool large;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          large ? 'assets/icons/star_accent.svg' : 'assets/icons/star_outline.svg',
          width: large ? 16 : 14,
          height: large ? 16 : 14,
        ),
        const SizedBox(width: 6),
        Text(
          rating.toStringAsFixed(1),
          style: large
              ? AppTypography.tag.copyWith(fontSize: 15)
              : AppTypography.tag,
        ),
        if (suffix != null) ...[
          const SizedBox(width: 6),
          Text(
            suffix!,
            style: large
                ? AppTypography.fieldValue.copyWith(
                    color: AppColors.textSecondary,
                  )
                : AppTypography.itemSubtitle,
          ),
        ],
      ],
    );
  }
}

/// Five small stars, [value] of them filled.
class StarRow extends StatelessWidget {
  const StarRow({super.key, required this.value, this.size = 12});

  final int value;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < 5; i++) ...[
          if (i > 0) const SizedBox(width: 2),
          SvgPicture.asset(
            i < value
                ? 'assets/icons/star_filled_sm.svg'
                : 'assets/icons/star_empty_sm.svg',
            width: size,
            height: size,
          ),
        ],
      ],
    );
  }
}

/// Circular avatar from a local asset.
class AppAvatar extends StatelessWidget {
  const AppAvatar(this.asset, {super.key, this.size = 48, this.ringColor});

  final String asset;
  final double size;

  /// Optional 3px ring (accent ring on the profile hero).
  final Color? ringColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: ringColor == null
            ? null
            : Border.all(color: ringColor!, width: 3),
        image: DecorationImage(image: AssetImage(asset), fit: BoxFit.cover),
      ),
    );
  }
}
