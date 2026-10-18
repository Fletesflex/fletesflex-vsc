import 'package:flutter/material.dart';

/// Color tokens extracted from the Figma "Login" screen
/// (file neRKyJz313WM7CEdoZdgGl, node 2:10).
abstract final class AppColors {
  /// App scaffold background.
  static const Color background = Color(0xFFFAFAFA);

  /// Surfaces that sit on top of [background] (inputs, cards).
  static const Color surface = Color(0xFFFFFFFF);

  /// Brand accent (primary CTA, focused states, truck icon stroke).
  static const Color accent = Color(0xFFFFD400);

  /// Logo mark background / highest-emphasis text & icons.
  static const Color textPrimary = Color(0xFF121212);

  /// Body copy / subtitles.
  static const Color textSecondary = Color(0xFF5C5C64);

  /// Low-emphasis text (divider label).
  static const Color textMuted = Color(0xFF9696A0);

  /// Default borders / hairlines (input border, divider line, outlined
  /// button border).
  static const Color border = Color(0xFFE5E5E5);

  /// Soft decorative blob behind the logo (rgba(255,244,204,0.6)).
  static const Color heroBlobYellow = Color(0x99FFF4CC);

  /// Soft decorative blob behind the logo (rgba(237,237,237,0.8)).
  static const Color heroBlobGray = Color(0xCCEDEDED);

  /// Solid soft-yellow surface behind category icons on the Home screen.
  static const Color iconSurface = Color(0xFFFFF4CC);

  /// Deep amber used for the destination ("B") marker and its map-pin icon
  /// on the request form.
  static const Color accentDeep = Color(0xFFE6A133);

  /// Success / confirmation (check-circle icon, verified states).
  static const Color success = Color(0xFF2E7D32);

  /// Soft green fill behind [success] labels ("3 nuevas").
  static const Color successSurface = Color(0xFFE8F5E9);

  /// Warm neutral fill for low-emphasis tags (vehicle model) and the
  /// divider above card actions.
  static const Color neutralSurface = Color(0xFFF3F2EC);

  /// Informational blue ("Mensajería" category label).
  static const Color info = Color(0xFF0288D1);

  /// Soft blue fill behind [info] labels.
  static const Color infoSurface = Color(0xFFE8F5FD);

  /// Bright emerald for payment-released status ("Liberado al transportista").
  static const Color successBright = Color(0xFF10B981);

  /// Soft fill behind [successBright] labels.
  static const Color successBrightSurface = Color(0xFFECFDF5);

  /// Mint fill behind the "10% OFF" discount label.
  static const Color discountSurface = Color(0xFFE6F7F0);

  /// Dashed border of upload drop zones.
  static const Color dashedBorder = Color(0xFFDCDAD2);

  /// Orange used for rating stars and sparkles.
  static const Color rating = Color(0xFFF59E0B);

  /// Dark green label on soft-green status badges ("Servicio Completado").
  static const Color successDark = Color(0xFF137333);

  /// Soft green fill behind [successDark] labels.
  static const Color successDarkSurface = Color(0xFFE6F4EA);

  /// Error / blocking text ("Pendiente de calificar — acción requerida").
  static const Color danger = Color(0xFFDC2626);

  /// Soft red fill behind [danger] labels.
  static const Color dangerSurface = Color(0xFFFEE2E2);

  /// Amber warning text ("Pendiente de calificar").
  static const Color warning = Color(0xFFD97706);

  /// Soft amber fill behind [warning] labels.
  static const Color warningSoft = Color(0xFFFEF3C7);

  /// Dark teal label on the gray "FINALIZADO" chat badge.
  static const Color archivedText = Color(0xFF2E5B51);

  /// Bottom-sheet drag handle.
  static const Color dragHandle = Color(0xFFD1CDC8);

  /// Scrim behind modal bottom sheets (rgba(18,18,18,0.6)).
  static const Color scrim = Color(0x99121212);

  /// Soft red-orange fill for warning tags ("Ascensor: No (Escaleras)").
  static const Color warningSurface = Color(0xFFFFF0ED);

  /// Muted brownish-gray for unselected icons (package-type picker).
  static const Color iconMuted = Color(0xFF918B86);

  /// Bright green for text, dots and checkmarks on dark surfaces (carrier
  /// identity-verification steps).
  static const Color successBrightOnDark = Color(0xFF34D399);
}
