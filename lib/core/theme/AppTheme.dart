import 'package:flutter/material.dart';

import '/core/theme/AppColors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primaryColor,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: AppColors.primaryColor,
      secondary: AppColors.secondaryColor,
      tertiary: AppColors.tertiaryColor,
      surface: AppColors.surface,
      inverseSurface: AppColors.darkColor,
    ),
    scaffoldBackgroundColor: AppColors.surface,
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.primaryDarkColor,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: AppColors.primaryDarkColor,
      secondary: AppColors.secondaryDarkColor,
      tertiary: AppColors.tertiaryDarkColor,
      surface: AppColors.surfaceDark,
      inverseSurface: AppColors.lightDarkColor,
    ),
    scaffoldBackgroundColor: AppColors.surfaceDark,
  );
}
