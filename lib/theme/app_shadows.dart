import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Shadow tokens extracted from Figma (file neRKyJz313WM7CEdoZdgGl).
abstract final class AppShadows {
  /// Soft ambient shadow used by resting surfaces (the logo mark, default
  /// category cards): 0px 1px 2px + 0px 4px 6px, both on [AppColors.textPrimary].
  static List<BoxShadow> get soft => [
        BoxShadow(
          color: AppColors.textPrimary.withValues(alpha: 0.02),
          offset: const Offset(0, 1),
          blurRadius: 2,
        ),
        BoxShadow(
          color: AppColors.textPrimary.withValues(alpha: 0.03),
          offset: const Offset(0, 4),
          blurRadius: 6,
        ),
      ];

  /// Elevated shadow used by the selected/recommended category card:
  /// 0px 8px 12px on [AppColors.textPrimary].
  static List<BoxShadow> get elevated => [
        BoxShadow(
          color: AppColors.textPrimary.withValues(alpha: 0.07),
          offset: const Offset(0, 8),
          blurRadius: 12,
        ),
      ];
}
