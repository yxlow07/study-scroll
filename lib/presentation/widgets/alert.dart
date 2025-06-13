import 'package:flutter/material.dart';

class Alert {
  static void alert(BuildContext context, String alertMessage) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(alertMessage)));
  }
}
