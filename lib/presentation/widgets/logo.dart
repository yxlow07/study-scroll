import 'package:flutter/material.dart';
import 'package:study_scroll/core/constants/images.dart';

class Logo extends StatelessWidget {
  final double size;

  const Logo({Key? key, this.size = 100}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100.0),
      child: Image(image: AssetImage(Images.logo), width: size, height: size),
    );
  }
}
