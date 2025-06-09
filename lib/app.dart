import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_scroll/core/routes/route_generator.dart';
import 'package:study_scroll/presentation/auth/bloc/auth_cubit.dart';

import '/core/theme/AppTheme.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Study Scroll',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      routerConfig: createAppRouter(context.read<AuthCubit>()),
    );
  }
}
