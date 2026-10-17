import 'package:flutter/material.dart';

import '../theme/theme.dart';
import '../utils/format.dart';

/// Soft-yellow box highlighting a price ("$145.000 ARS").
class PriceBox extends StatelessWidget {
  const PriceBox({
    super.key,
    required this.caption,
    required this.amount,
    this.helper,
  });

  final String caption;
  final int amount;
  final String? helper;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.iconSurface,
        border: Border.all(color: AppColors.accent, width: 1.5),
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
      child: Column(
        children: [
          Text(caption.toUpperCase(), style: AppTypography.priceCaption),
          const SizedBox(height: AppSpacing.xxs),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(formatArs(amount), style: AppTypography.priceAmount),
              const SizedBox(width: AppSpacing.xxs),
              Text('ARS', style: AppTypography.priceCurrency),
            ],
          ),
          if (helper != null) ...[
            const SizedBox(height: AppSpacing.xxs),
            Text(
              helper!,
              style: AppTypography.helper,
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}
