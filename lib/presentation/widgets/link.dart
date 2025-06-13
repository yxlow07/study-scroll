import 'package:flutter/material.dart';

class Link extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;

  const Link({super.key, required this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: onTap, child: child);
  }
}
