import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Typography tokens extracted from the Figma "Login" screen
/// (file neRKyJz313WM7CEdoZdgGl, node 2:10).
///
/// The design uses two type families: **Rubik** for headlines/buttons and
/// **Manrope** for body copy/labels.
abstract final class AppTypography {
  /// Rubik ExtraBold 28 — the "FletesFlex" logo wordmark.
  static TextStyle get logo => GoogleFonts.rubik(
        fontSize: 28,
        fontWeight: FontWeight.w800,
        color: AppColors.textPrimary,
      );

  /// Rubik Bold 24 — screen headline ("Mudate sin estrés").
  static TextStyle get headline => GoogleFonts.rubik(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      );

  /// Manrope Regular 15 — headline subtitle copy.
  static TextStyle get subtitle => GoogleFonts.manrope(
        fontSize: 15,
        fontWeight: FontWeight.normal,
        color: AppColors.textSecondary,
      );

  /// Manrope Bold 13 — field label ("Número de teléfono").
  static TextStyle get label => GoogleFonts.manrope(
        fontSize: 13,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      );

  /// Manrope SemiBold 16 — the dial-code chip ("+54 9").
  static TextStyle get inputEmphasis => GoogleFonts.manrope(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  /// Manrope Regular 16 — text field input/placeholder value.
  static TextStyle get inputValue => GoogleFonts.manrope(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: AppColors.textPrimary,
      );

  /// Rubik SemiBold 16 — primary & secondary button labels.
  static TextStyle get button => GoogleFonts.rubik(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  /// Manrope Regular 14 — "o continuar con" divider label.
  static TextStyle get caption => GoogleFonts.manrope(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: AppColors.textMuted,
      );

  /// Manrope Regular 14 — Home header greeting ("Hola, bienvenido").
  static TextStyle get greeting => GoogleFonts.manrope(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: AppColors.textSecondary,
      );

  /// Rubik Bold 16 — Home header user name ("Mateo Silva").
  static TextStyle get userName => GoogleFonts.rubik(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      );

  /// Rubik Bold 22 — Home screen section title.
  static TextStyle get sectionTitle => GoogleFonts.rubik(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      );

  /// Manrope Regular 14 — Home screen section subtitle.
  static TextStyle get sectionSubtitle => GoogleFonts.manrope(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: AppColors.textSecondary,
      );

  /// Rubik Bold 17 — category card title ("Mudanza", "Flete", "Mensajería").
  static TextStyle get cardTitle => GoogleFonts.rubik(
        fontSize: 17,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      );

  /// Manrope Regular 13 — category card description copy.
  static TextStyle get cardDescription => GoogleFonts.manrope(
        fontSize: 13,
        fontWeight: FontWeight.normal,
        color: AppColors.textSecondary,
        height: 1.4,
      );

  /// Manrope Bold 11 uppercase — small badge label ("Recomendado").
  static TextStyle get badgeLabel => GoogleFonts.manrope(
        fontSize: 11,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      );
}
