/// Spacing tokens extracted from the Figma "Login" screen
/// (file neRKyJz313WM7CEdoZdgGl, node 2:10).
///
/// These are the distinct gap/padding values actually used across the
/// screen's layout (status bar and home indicator chrome excluded).
abstract final class AppSpacing {
  /// 2 — vertical padding inside small badges (e.g. "Recomendado").
  static const double badgeVertical = 2;

  /// 4 — tight internal gaps (category card title/description stack).
  static const double xxs = 4;

  /// 8 — small internal gaps (headline/label stacks, icon-to-label gaps).
  static const double xs = 8;

  /// 12 — gaps between related controls (phone input row, divider row).
  static const double sm = 12;

  /// 14 — vertical padding inside primary/secondary buttons.
  static const double buttonVertical = 14;

  /// 16 — default control padding (text field content padding, gap between
  /// stacked category cards).
  static const double md = 16;

  /// 18 — internal padding inside a category card.
  static const double cardPadding = 18;

  /// 20 — gap between stacked sections on the Home screen.
  static const double sectionGap = 20;

  /// 24 — section spacing and the screen's horizontal page margin.
  static const double lg = 24;
}
