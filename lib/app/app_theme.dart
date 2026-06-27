import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../design_system/tokens/colors.dart';

class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  final Color coinColor;
  final Color streakColor;
  final Color freezeColor;
  final Color promiseColor;

  AppThemeExtension({
    required this.coinColor,
    required this.streakColor,
    required this.freezeColor,
    required this.promiseColor,
  });

  @override
  AppThemeExtension copyWith({
    Color? coinColor,
    Color? streakColor,
    Color? freezeColor,
    Color? promiseColor,
  }) {
    return AppThemeExtension(
      coinColor: coinColor ?? this.coinColor,
      streakColor: streakColor ?? this.streakColor,
      freezeColor: freezeColor ?? this.freezeColor,
      promiseColor: promiseColor ?? this.promiseColor,
    );
  }

  @override
  AppThemeExtension lerp(ThemeExtension<AppThemeExtension>? other, double t) {
    if (other is! AppThemeExtension) return this;
    return AppThemeExtension(
      coinColor: Color.lerp(coinColor, other.coinColor, t)!,
      streakColor: Color.lerp(streakColor, other.streakColor, t)!,
      freezeColor: Color.lerp(freezeColor, other.freezeColor, t)!,
      promiseColor: Color.lerp(promiseColor, other.promiseColor, t)!,
    );
  }
}

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.lightBackground,
        surfaceContainerHighest: AppColors.lightSurface,
        error: AppColors.error,
        outline: AppColors.lightOutline,
      ),
      textTheme: GoogleFonts.outfitTextTheme(ThemeData.light().textTheme),
      extensions: [
        AppThemeExtension(
          coinColor: AppColors.coinGold,
          streakColor: AppColors.streakOrange,
          freezeColor: AppColors.freezeBlue,
          promiseColor: AppColors.promisePurple,
        ),
      ],
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.darkBackground,
        surfaceContainerHighest: AppColors.darkSurface,
        error: AppColors.error,
        outline: AppColors.darkOutline,
      ),
      textTheme: GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme),
      extensions: [
        AppThemeExtension(
          coinColor: AppColors.coinGold,
          streakColor: AppColors.streakOrange,
          freezeColor: AppColors.freezeBlue,
          promiseColor: AppColors.promisePurple,
        ),
      ],
    );
  }
}
