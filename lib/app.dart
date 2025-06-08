import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:study_scroll/core/routes/app_routes.dart';
import 'package:study_scroll/core/routes/route_generator.dart';
import 'package:study_scroll/data/repositories/fb_auth_repo.dart';
import 'package:study_scroll/presentation/auth/bloc/auth_cubit.dart';
import 'package:study_scroll/presentation/auth/bloc/auth_states.dart';
import 'package:study_scroll/presentation/auth/pages/auth.dart';
import 'package:study_scroll/presentation/home/home.dart';
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
