import 'package:flutter/material.dart';

/// HydroGrow App Color Palette
/// Converted from oklch values (tweakcn template) to Flutter hex colors.
///
/// Light Mode:
///   background  oklch(0.9892 0.0054 117.92)  → ~#F5F7EC
///   foreground  oklch(0.2077 0.0398 265.75)  → ~#1E2747
///   card        oklch(1.0000 0 0)             → #FFFFFF
///   primary     oklch(0.8871 0.2122 128.50)  → ~#A8E63D  (Lime Green)
///   secondary   oklch(0.3717 0.0392 257.29)  → ~#364270
///   muted       oklch(0.9683 0.0069 247.90)  → ~#EEF0F5
///   muted-fg    oklch(0.5544 0.0407 257.42)  → ~#606A8A
///   accent      oklch(0.9819 0.0181 155.83)  → ~#E6FAF0
///   accent-fg   oklch(0.4479 0.1083 151.33)  → ~#2D7A56
///   destructive oklch(0.6368 0.2078 25.33)   → ~#E05235
///   border      oklch(0.9288 0.0126 255.51)  → ~#DDE2EE
///   ring        oklch(0.8871 0.2122 128.50)  → ~#A8E63D
///
/// Dark Mode:
///   background  oklch(0.1288 0.0406 264.70)  → ~#0D1428
///   foreground  oklch(0.9842 0.0034 247.86)  → ~#F4F5F8
///   card        oklch(0.2077 0.0398 265.75)  → ~#1E2747
///   primary     same → #A8E63D
///   secondary   oklch(0.2795 0.0368 260.03)  → ~#252F50
///   muted       oklch(0.2795 0.0368 260.03)  → ~#252F50
///   muted-fg    oklch(0.7107 0.0351 256.79)  → ~#9099B5
///   accent      oklch(0.3925 0.0896 152.54)  → ~#1E4D36
///   accent-fg   oklch(0.8871 0.2122 128.50)  → #A8E63D
///   destructive oklch(0.4437 0.1613 26.90)   → ~#8B3220
///   border      oklch(0.2795 0.0368 260.03)  → ~#252F50
abstract final class AppColors {
  // ─── Primary (Lime Green) ───────────────────────────────────────────────────
  static const Color primary = Color(0xFFA8E63D);
  static const Color primaryForeground = Color(0xFF000000);

  // ─── Light Mode ────────────────────────────────────────────────────────────
  static const Color backgroundLight = Color(0xFFF5F7EC);
  static const Color foregroundLight = Color(0xFF1E2747);
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color cardForegroundLight = Color(0xFF1E2747);
  static const Color secondaryLight = Color(0xFF364270);
  static const Color secondaryForegroundLight = Color(0xFFF4F5F8);
  static const Color mutedLight = Color(0xFFEEF0F5);
  static const Color mutedForegroundLight = Color(0xFF606A8A);
  static const Color accentLight = Color(0xFFE6FAF0);
  static const Color accentForegroundLight = Color(0xFF2D7A56);
  static const Color destructiveLight = Color(0xFFE05235);
  static const Color destructiveForegroundLight = Color(0xFFFFFFFF);
  static const Color borderLight = Color(0xFFDDE2EE);
  static const Color inputLight = Color(0xFFDDE2EE);

  // ─── Dark Mode ─────────────────────────────────────────────────────────────
  static const Color backgroundDark = Color(0xFF0D1428);
  static const Color foregroundDark = Color(0xFFF4F5F8);
  static const Color cardDark = Color(0xFF1E2747);
  static const Color cardForegroundDark = Color(0xFFF4F5F8);
  static const Color secondaryDark = Color(0xFF252F50);
  static const Color secondaryForegroundDark = Color(0xFFF4F5F8);
  static const Color mutedDark = Color(0xFF252F50);
  static const Color mutedForegroundDark = Color(0xFF9099B5);
  static const Color accentDark = Color(0xFF1E4D36);
  static const Color accentForegroundDark = Color(0xFFA8E63D);
  static const Color destructiveDark = Color(0xFF8B3220);
  static const Color destructiveForegroundDark = Color(0xFFFFFFFF);
  static const Color borderDark = Color(0xFF252F50);
  static const Color inputDark = Color(0xFF252F50);

  // ─── Google Brand ──────────────────────────────────────────────────────────
  static const Color googleBlue = Color(0xFF4285F4);
  static const Color googleRed = Color(0xFFEA4335);
  static const Color googleYellow = Color(0xFFFBBC05);
  static const Color googleGreen = Color(0xFF34A853);
}
