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
}
