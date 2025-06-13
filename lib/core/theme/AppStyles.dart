import 'package:flutter/material.dart';

import 'AppColors.dart';

class AppStyles {
  static Color textColor(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return isDarkMode ? AppColors.lightDarkColor : AppColors.textColor;
  }

  static TextStyle title(BuildContext context) =>
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: textColor(context));

  static const TextStyle subtitle = TextStyle(fontSize: 18, color: AppColors.textLightColor);

  static const TextStyle subtitleBold = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.textLightColor,
  );

  static TextStyle body(BuildContext context) => TextStyle(fontSize: 16, color: textColor(context));

  static TextStyle bodyBold(BuildContext context) =>
      TextStyle(fontSize: 16, color: textColor(context), fontWeight: FontWeight.bold);

  static TextStyle button(BuildContext context) =>
      TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: textColor(context));

  static const TextStyle hint = TextStyle(fontSize: 12, color: AppColors.grey);

  static const EdgeInsets paddingScreen = EdgeInsets.only(left: 60.0, right: 60.0, top: 20.0, bottom: 20.0);

  static final ButtonStyle outlinedButtonStyle = OutlinedButton.styleFrom(
    side: BorderSide(color: Colors.grey),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
  );
}
