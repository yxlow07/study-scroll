import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:study_scroll/core/routes/app_routes.dart';
import 'package:study_scroll/presentation/auth/bloc/auth_cubit.dart';
import 'package:study_scroll/presentation/auth/bloc/auth_states.dart';
import 'package:study_scroll/presentation/auth/pages/auth.dart';
import 'package:study_scroll/presentation/home/home.dart';
import 'package:study_scroll/presentation/profile/profile.dart';

final goRouter = GoRouter(
  initialLocation: AppRoutes.home,
  redirect: (context, state) {
    final authCubit = context.read<AuthCubit>();
    final authState = authCubit.state;

    if (authState is AuthSignedOut || authState is AuthError || authState is AuthInitial) {
      return AppRoutes.auth;
    }

    // Allow authenticated users to proceed
    return null;
  },
  routes: [
    GoRoute(path: AppRoutes.auth, builder: (context, state) => AuthPage()),
    GoRoute(path: AppRoutes.home, builder: (context, state) => HomePage()),
    GoRoute(path: AppRoutes.profile, builder: (context, state) => const ProfilePage()),
    GoRoute(
      path: AppRoutes.leaderboard,
      builder: (context, state) => const Center(child: Text('Leaderboard Page (Route)')),
    ),
    GoRoute(path: AppRoutes.quiz, builder: (context, state) => const Center(child: Text('Quiz Page (Route)'))),
    // Add your other routes here
  ],
  errorBuilder: (context, state) => Scaffold(body: Center(child: CircularProgressIndicator())),
);
