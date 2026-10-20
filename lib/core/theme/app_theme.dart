import 'package:flutter/material.dart';
import 'app_colors.dart';

/// HydroGrow [ThemeData] builder.
///
/// Usage:
/// ```dart
/// MaterialApp(
///   theme: AppTheme.light,
///   darkTheme: AppTheme.dark,
/// );
/// ```
abstract final class AppTheme {
  // ─── Shared ────────────────────────────────────────────────────────────────
  static const double _radiusLg = 16.0; // --radius: 1rem
  static const double _radiusMd = 14.0; // calc(1rem - 2px)

  static const BorderRadius _borderRadiusLg =
      BorderRadius.all(Radius.circular(_radiusLg));
  static const BorderRadius _borderRadiusMd =
      BorderRadius.all(Radius.circular(_radiusMd));

  static TextTheme _buildTextTheme(Color foreground, Color muted) {
    const base = TextStyle(fontFamily: 'Inter', letterSpacing: -0.01 * 16);
    return TextTheme(
      displayLarge: base.copyWith(
          fontSize: 57, fontWeight: FontWeight.w700, color: foreground),
      displayMedium: base.copyWith(
          fontSize: 45, fontWeight: FontWeight.w700, color: foreground),
      displaySmall: base.copyWith(
          fontSize: 36, fontWeight: FontWeight.w700, color: foreground),
      headlineLarge: base.copyWith(
          fontSize: 32, fontWeight: FontWeight.w700, color: foreground),
      headlineMedium: base.copyWith(
          fontSize: 28, fontWeight: FontWeight.w600, color: foreground),
      headlineSmall: base.copyWith(
          fontSize: 24, fontWeight: FontWeight.w600, color: foreground),
      titleLarge: base.copyWith(
          fontSize: 22, fontWeight: FontWeight.w600, color: foreground),
      titleMedium: base.copyWith(
          fontSize: 16, fontWeight: FontWeight.w600, color: foreground),
      titleSmall: base.copyWith(
          fontSize: 14, fontWeight: FontWeight.w500, color: foreground),
      bodyLarge: base.copyWith(fontSize: 16, color: foreground),
      bodyMedium: base.copyWith(fontSize: 14, color: foreground),
      bodySmall: base.copyWith(fontSize: 12, color: muted),
      labelLarge: base.copyWith(
          fontSize: 14, fontWeight: FontWeight.w600, color: foreground),
      labelMedium: base.copyWith(
          fontSize: 12, fontWeight: FontWeight.w500, color: foreground),
      labelSmall: base.copyWith(
          fontSize: 11, fontWeight: FontWeight.w500, color: muted),
    );
  }

  static InputDecorationTheme _buildInputTheme(
      Color border, Color fill, Color fg, Color muted) {
    final outlineBorder = OutlineInputBorder(
      borderRadius: _borderRadiusMd,
      borderSide: BorderSide(color: border, width: 1.5),
    );
    return InputDecorationTheme(
      filled: true,
      fillColor: fill,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: outlineBorder,
      enabledBorder: outlineBorder,
      focusedBorder: OutlineInputBorder(
        borderRadius: _borderRadiusMd,
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: _borderRadiusMd,
        borderSide: BorderSide(color: AppColors.destructiveLight, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: _borderRadiusMd,
        borderSide: BorderSide(color: AppColors.destructiveLight, width: 2),
      ),
      hintStyle: TextStyle(color: muted, fontSize: 14),
      labelStyle: TextStyle(color: muted, fontSize: 14),
    );
  }

  static ElevatedButtonThemeData _buildElevatedButtonTheme() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.primaryForeground,
        elevation: 0,
        shadowColor: Colors.transparent,
        minimumSize: const Size(double.infinity, 52),
        shape: const RoundedRectangleBorder(borderRadius: _borderRadiusLg),
        textStyle: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 15,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.01 * 15,
        ),
      ).copyWith(
        overlayColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.pressed)
              ? Colors.black.withValues(alpha: 0.08)
              : null,
        ),
      ),
    );
  }

  static OutlinedButtonThemeData _buildOutlinedButtonTheme(Color border) {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: BorderSide(color: border, width: 1.5),
        minimumSize: const Size(double.infinity, 52),
        shape: const RoundedRectangleBorder(borderRadius: _borderRadiusLg),
        textStyle: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // ─── Light Theme ───────────────────────────────────────────────────────────
  static ThemeData get light {
    const bg = AppColors.backgroundLight;
    const fg = AppColors.foregroundLight;
    const card = AppColors.cardLight;
    const border = AppColors.borderLight;
    const muted = AppColors.mutedForegroundLight;
    const mutedBg = AppColors.mutedLight;

    final colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primary,
      onPrimary: AppColors.primaryForeground,
      secondary: AppColors.secondaryLight,
      onSecondary: AppColors.secondaryForegroundLight,
      surface: card,
      onSurface: fg,
      error: AppColors.destructiveLight,
      onError: AppColors.destructiveForegroundLight,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: bg,
      fontFamily: 'Inter',
      textTheme: _buildTextTheme(fg, muted),
      inputDecorationTheme: _buildInputTheme(border, mutedBg, fg, muted),
      elevatedButtonTheme: _buildElevatedButtonTheme(),
      outlinedButtonTheme: _buildOutlinedButtonTheme(border),
      cardTheme: CardThemeData(
        color: card,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: _borderRadiusLg,
          side: BorderSide(color: border, width: 1),
        ),
        margin: EdgeInsets.zero,
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) =>
            states.contains(WidgetState.selected) ? AppColors.primary : null),
        checkColor: WidgetStateProperty.all(AppColors.primaryForeground),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        side: BorderSide(color: border, width: 1.5),
      ),
      dividerColor: border,
      dividerTheme: DividerThemeData(color: border, thickness: 1),
    );
  }

  // ─── Dark Theme ────────────────────────────────────────────────────────────
  static ThemeData get dark {
    const bg = AppColors.backgroundDark;
    const fg = AppColors.foregroundDark;
    const card = AppColors.cardDark;
    const border = AppColors.borderDark;
    const muted = AppColors.mutedForegroundDark;
    const mutedBg = AppColors.mutedDark;

    final colorScheme = ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.primary,
      onPrimary: AppColors.primaryForeground,
      secondary: AppColors.secondaryDark,
      onSecondary: AppColors.secondaryForegroundDark,
      surface: card,
      onSurface: fg,
      error: AppColors.destructiveDark,
      onError: AppColors.destructiveForegroundDark,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: bg,
      fontFamily: 'Inter',
      textTheme: _buildTextTheme(fg, muted),
      inputDecorationTheme: _buildInputTheme(border, mutedBg, fg, muted),
      elevatedButtonTheme: _buildElevatedButtonTheme(),
      outlinedButtonTheme: _buildOutlinedButtonTheme(border),
      cardTheme: CardThemeData(
        color: card,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: _borderRadiusLg,
          side: BorderSide(color: border, width: 1),
        ),
        margin: EdgeInsets.zero,
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) =>
            states.contains(WidgetState.selected) ? AppColors.primary : null),
        checkColor: WidgetStateProperty.all(AppColors.primaryForeground),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        side: const BorderSide(color: AppColors.borderDark, width: 1.5),
      ),
      dividerColor: border,
      dividerTheme: DividerThemeData(color: border, thickness: 1),
    );
  }
}
