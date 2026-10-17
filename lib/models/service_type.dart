import 'package:flutter/material.dart';

import '../theme/theme.dart';

/// The three request categories, with the label colors used by their
/// category badges.
enum ServiceType {
  mudanza('Mudanza', AppColors.iconSurface, AppColors.textPrimary),
  flete('Flete', AppColors.iconSurface, AppColors.accentDeep),
  mensajeria('Mensajería', AppColors.infoSurface, AppColors.info);

  const ServiceType(this.label, this.badgeColor, this.badgeTextColor);

  final String label;
  final Color badgeColor;
  final Color badgeTextColor;
}
