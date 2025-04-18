// utils/themes.dart
import 'package:flutter/material.dart';
import 'package:my_desktop_app/core/constant/app_colors.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    colorScheme: ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.surface,
      background: AppColors.background,
      error: AppColors.error,
      onPrimary: AppColors.onPrimary,
      onSecondary: AppColors.onSecondary,
      onSurface: AppColors.onSurface,
      onBackground: AppColors.onBackground,
      onError: AppColors.onError,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.primaryVariant,
    colorScheme: ColorScheme.dark(
      primary: AppColors.primaryVariant,
      secondary: AppColors.secondaryVariant,
      surface: AppColors.darkGrey,
      background: AppColors.black,
      error: AppColors.error,
      onPrimary: AppColors.onPrimary,
      onSecondary: AppColors.onSecondary,
      onSurface: AppColors.onSurface,
      onBackground: AppColors.onBackground,
      onError: AppColors.onError,
    ),
  );
}
