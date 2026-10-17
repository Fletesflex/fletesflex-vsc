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

  /// Rubik Bold 18 — top bar title on form steps ("Paso 1: Direcciones").
  static TextStyle get appBarTitle => GoogleFonts.rubik(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      );

  /// Rubik Bold 15 — form group heading ("Origen de la Mudanza").
  static TextStyle get groupTitle => GoogleFonts.rubik(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      );

  /// Rubik Bold 12 — single-letter route marker ("A", "B").
  static TextStyle get marker => GoogleFonts.rubik(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      );

  /// Manrope Regular 14 — compact form field value / placeholder.
  static TextStyle get fieldValue => GoogleFonts.manrope(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: AppColors.textPrimary,
      );

  /// Manrope Regular 12 — small field label ("Piso", "Depto / Of").
  static TextStyle get fieldLabel => GoogleFonts.manrope(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: AppColors.textSecondary,
      );

  /// Manrope Regular 14 — unselected option chip ("Casa").
  static TextStyle get chip => GoogleFonts.manrope(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: AppColors.textSecondary,
      );

  /// Manrope Bold 14 — selected option chip.
  static TextStyle get chipSelected => GoogleFonts.manrope(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      );

  /// Rubik SemiBold 14 — inline text action ("Agregar parada intermedia").
  static TextStyle get textAction => GoogleFonts.rubik(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  /// Manrope SemiBold 14 — list item title ("Sillón de 3 cuerpos").
  static TextStyle get itemTitle => GoogleFonts.manrope(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  /// Manrope Regular 12 — list item secondary line ("Grande (aprox 2.1m)").
  static TextStyle get itemSubtitle => GoogleFonts.manrope(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: AppColors.textMuted,
      );

  /// Rubik SemiBold 13 — compact soft button label ("Agregar objeto").
  static TextStyle get smallAction => GoogleFonts.rubik(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  /// Manrope Regular 14 — label next to a toggle ("Elevación con sogas…").
  static TextStyle get toggleLabel => GoogleFonts.manrope(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: AppColors.textSecondary,
      );

  /// Manrope SemiBold 13 — picker field value ("Sáb, 24 de Oct").
  static TextStyle get pickerValue => GoogleFonts.manrope(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  /// Rubik Bold 13 — uppercase block heading inside cards
  /// ("INVENTARIO DE MUDANZA").
  static TextStyle get overline => GoogleFonts.rubik(
        fontSize: 13,
        fontWeight: FontWeight.bold,
        color: AppColors.textSecondary,
      );

  /// Manrope Regular 13 — address line in a route summary.
  static TextStyle get routeText => GoogleFonts.manrope(
        fontSize: 13,
        fontWeight: FontWeight.normal,
        color: AppColors.textSecondary,
      );

  /// Manrope Bold 12 — [AppTag] label.
  static TextStyle get tag => GoogleFonts.manrope(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      );

  /// Manrope Bold 13 uppercase — price box caption.
  static TextStyle get priceCaption => GoogleFonts.manrope(
        fontSize: 13,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      );

  /// Rubik ExtraBold 32 — large price amount ("$145.000").
  static TextStyle get priceAmount => GoogleFonts.rubik(
        fontSize: 32,
        fontWeight: FontWeight.w800,
        color: AppColors.textPrimary,
      );

  /// Manrope SemiBold 14 — currency suffix next to a price ("ARS").
  static TextStyle get priceCurrency => GoogleFonts.manrope(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  /// Manrope Regular 12 — small helper copy under a value.
  static TextStyle get helper => GoogleFonts.manrope(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: AppColors.textSecondary,
      );

  /// Rubik Bold 15 underlined — text link ("Editar datos").
  static TextStyle get link => GoogleFonts.rubik(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: AppColors.textSecondary,
        decoration: TextDecoration.underline,
      );

  /// Manrope Regular 15 / 1.5 — centered body copy on status screens.
  static TextStyle get body => GoogleFonts.manrope(
        fontSize: 15,
        fontWeight: FontWeight.normal,
        color: AppColors.textSecondary,
        height: 1.5,
      );

  /// Rubik Bold 20 — page title without a back arrow ("Ofertas recibidas").
  static TextStyle get pageTitle => GoogleFonts.rubik(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      );

  /// Rubik ExtraBold 20 — price on an offer card.
  static TextStyle get priceMedium => GoogleFonts.rubik(
        fontSize: 20,
        fontWeight: FontWeight.w800,
        color: AppColors.textPrimary,
      );

  /// Manrope Regular 11 — tiny muted caption ("FINAL").
  static TextStyle get micro => GoogleFonts.manrope(
        fontSize: 11,
        fontWeight: FontWeight.normal,
        color: AppColors.textMuted,
      );

  /// Rubik Bold 14 underlined — inline link ("Ver perfil completo").
  static TextStyle get linkSmall => GoogleFonts.rubik(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
        decoration: TextDecoration.underline,
      );

  /// Rubik Bold 14 — compact button label ("Elegir").
  static TextStyle get buttonSmall => GoogleFonts.rubik(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      );

  /// Manrope SemiBold 13 — outlined pill label ("Mudanzas grandes").
  static TextStyle get pill => GoogleFonts.manrope(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: AppColors.textSecondary,
      );

  /// Manrope Bold 13 — highlighted feature chip label ("2 Ayudantes").
  static TextStyle get featureLabel => GoogleFonts.manrope(
        fontSize: 13,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      );

  /// Manrope Medium 11 uppercase — caption above an [InfoRow] value.
  static TextStyle get infoLabel => GoogleFonts.manrope(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: AppColors.textMuted,
      );

  /// Manrope SemiBold 15 — [InfoRow] value.
  static TextStyle get infoValue => GoogleFonts.manrope(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  /// Rubik ExtraBold 32 / 1.2 — big centered headline on result screens
  /// ("¡Listo, confirmaste a Martín!").
  static TextStyle get display => GoogleFonts.rubik(
        fontSize: 32,
        fontWeight: FontWeight.w800,
        color: AppColors.textPrimary,
        height: 1.2,
      );

  /// Manrope Medium 13 — checklist row label.
  static TextStyle get checkLabel => GoogleFonts.manrope(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      );

  /// Manrope Medium 10 — bottom navigation label.
  static TextStyle get navLabel => GoogleFonts.manrope(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: AppColors.textMuted,
      );

  /// Rubik ExtraBold 22 — greeting headline ("Hola, Martín 👋").
  static TextStyle get greetingTitle => GoogleFonts.rubik(
        fontSize: 22,
        fontWeight: FontWeight.w800,
        color: AppColors.textPrimary,
      );

  /// Rubik Bold 17 — route title on a request card ("Palermo → Belgrano").
  static TextStyle get routeTitle => GoogleFonts.rubik(
        fontSize: 17,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      );

  /// Rubik ExtraBold 18 — compact price ("$45.000").
  static TextStyle get priceSmall => GoogleFonts.rubik(
        fontSize: 18,
        fontWeight: FontWeight.w800,
        color: AppColors.textPrimary,
      );

  /// Rubik Bold 15 — address line in a route timeline.
  static TextStyle get addressTitle => GoogleFonts.rubik(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      );

  /// Manrope Bold 12 uppercase — muted caption ("ORIGEN").
  static TextStyle get caps => GoogleFonts.manrope(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: AppColors.textMuted,
      );

  /// Manrope Regular 15 / 20px — chat bubble text.
  static TextStyle get chatMessage => GoogleFonts.manrope(
        fontSize: 15,
        fontWeight: FontWeight.normal,
        color: AppColors.textPrimary,
        height: 20 / 15,
      );

  /// Manrope Regular 10 — chat bubble timestamp.
  static TextStyle get chatTime => GoogleFonts.manrope(
        fontSize: 10,
        fontWeight: FontWeight.normal,
        color: AppColors.textMuted,
      );

  /// Manrope Bold 11 uppercase — small badge label ("Recomendado").
  static TextStyle get badgeLabel => GoogleFonts.manrope(
        fontSize: 11,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      );

  /// Rubik Bold 16 — card heading on the flete confirmation screen
  /// ("Recorrido y horario", "3 objetos cargados").
  static TextStyle get cardHeading => GoogleFonts.rubik(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      );

  /// Manrope Medium 15 — route/date value under a muted caption
  /// ("Av. Córdoba 1234, CABA").
  static TextStyle get addressValue => GoogleFonts.manrope(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      );

  /// Manrope Regular 13 — muted caption under a card heading
  /// ("Heladera, Sillón y caja de embalaje").
  static TextStyle get cardCaption => GoogleFonts.manrope(
        fontSize: 13,
        fontWeight: FontWeight.normal,
        color: AppColors.textMuted,
      );

  /// Manrope SemiBold 12 uppercase — label above the assigned-vehicle name
  /// ("Vehículo asignado para tu flete").
  static TextStyle get vehicleLabel => GoogleFonts.manrope(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  /// Rubik Bold 18 — assigned vehicle name ("Camioneta").
  static TextStyle get vehicleTitle => GoogleFonts.rubik(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      );

  /// Manrope SemiBold 14 — muted caption above a hero price ("Precio estimado").
  static TextStyle get priceEstimateLabel => GoogleFonts.manrope(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.textMuted,
      );

  /// Rubik ExtraBold 36 — hero price on the flete confirmation screen
  /// ("$130.000").
  static TextStyle get priceHero => GoogleFonts.rubik(
        fontSize: 36,
        fontWeight: FontWeight.w800,
        color: AppColors.textPrimary,
      );
}
