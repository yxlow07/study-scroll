import 'package:flutter/material.dart';
import 'AppColors.dart';

class AppStyles {
  static const TextStyle title = TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textColor);

  static const TextStyle subtitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.textLightColor,
  );

  static const TextStyle body = TextStyle(fontSize: 16, color: AppColors.textColor);

  static const TextStyle bodyBold = TextStyle(fontSize: 16, color: AppColors.textColor, fontWeight: FontWeight.bold);

  static const TextStyle button = TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textColor);

  static const TextStyle hint = TextStyle(fontSize: 12, color: AppColors.grey);

  static const EdgeInsets paddingScreen = EdgeInsets.only(left: 60.0, right: 60.0, top: 20.0, bottom: 20.0);
}
