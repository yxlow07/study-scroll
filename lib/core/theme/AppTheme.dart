import 'package:flutter/material.dart';
import '/core/theme/AppColors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primaryColor,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryColor,
      primary: AppColors.primaryColor,
      brightness: Brightness.light,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.primaryColor,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryColor,
      primary: AppColors.primaryColor,
      brightness: Brightness.dark,
    ),
  );
}
