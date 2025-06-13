import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_scroll/core/routes/route_generator.dart';
import 'package:study_scroll/presentation/auth/bloc/auth_cubit.dart';
import 'package:study_scroll/presentation/home/bloc/ThemeCubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeData>(
      builder: (context, theme) {
        return MaterialApp.router(
          title: 'Study Scroll',
          theme: theme,
          debugShowCheckedModeBanner: false,
          routerConfig: createAppRouter(context.read<AuthCubit>()),
        );
      },
    );
  }
}
