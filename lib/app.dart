import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_scroll/presentation/auth/pages/register.dart';
import '/core/theme/AppTheme.dart';
import '/core/constants/images.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Study Scroll',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: RegisterPage(),
    );
  }
}
