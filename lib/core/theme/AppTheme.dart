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

  // TODO: Implement dark theme
  static ThemeData darkTheme = ThemeData(primaryColor: AppColors.primaryColor, brightness: Brightness.dark);
}
