import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:study_scroll/core/routes/app_routes.dart';
import 'package:study_scroll/presentation/auth/bloc/auth_cubit.dart';
import 'package:study_scroll/presentation/auth/bloc/auth_states.dart';
import 'package:study_scroll/presentation/auth/pages/auth.dart';
import 'package:study_scroll/presentation/home/home.dart';
import 'package:study_scroll/presentation/profile/profile.dart';

GoRouter createAppRouter(AuthCubit authCubit) {
  return GoRouter(
    initialLocation: AppRoutes.home,
    refreshListenable: GoRouterRefreshStream(authCubit.stream),
    redirect: (BuildContext context, GoRouterState state) {
      final currentState = authCubit.state; // Get the current state directly from the cubit instance
      final onAuthFlow = state.matchedLocation == AppRoutes.auth;

      // If the user is signed out, or in an error state, or initial state
      if (currentState is AuthSignedOut || currentState is AuthError || currentState is AuthInitial) {
        // If they are not already on an authentication page, redirect them to the auth page
        if (!onAuthFlow) {
          return AppRoutes.auth;
        }
      }
      // If the user is signed in
      else if (currentState is AuthSignedIn) {
        // If they are on an authentication page (e.g., login, register), redirect them to home
        if (onAuthFlow) {
          return AppRoutes.home;
        }
      }

      // No redirect needed, allow navigation to the intended route
      return null;
    },
    routes: <RouteBase>[
      GoRoute(path: AppRoutes.auth, builder: (context, state) => AuthPage()),
      ShellRoute(
        navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'shell'),
        builder: (BuildContext context, GoRouterState state, Widget child) => HomePage(child: child),
        routes: <RouteBase>[
          GoRoute(
            path: AppRoutes.home,
            pageBuilder: (context, state) => NoTransitionPage(child: const Text("Hello World"), key: state.pageKey),
          ),
          GoRoute(
            path: AppRoutes.profile,
            pageBuilder:
                (context, state) =>
                    NoTransitionPage(child: ProfilePage(uid: authCubit.student!.uid), key: state.pageKey),
          ),
          GoRoute(
            path: AppRoutes.leaderboard,
            pageBuilder:
                (context, state) =>
                    NoTransitionPage(child: Center(child: Text('Leaderboard Page (Route)')), key: state.pageKey),
          ),
          GoRoute(
            path: AppRoutes.quiz,
            pageBuilder:
                (context, state) =>
                    NoTransitionPage(child: Center(child: Text('Quiz Page (Route)')), key: state.pageKey),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) {
      print("GoRouter Error: ${state.error}");
      return Scaffold(body: Center(child: Text("Oops! Something went wrong. ${state.error}")));
    },
  );
}

// Helper class for GoRouter to listen to a stream and notify changes
class GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription<dynamic> _subscription;

  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.distinct().listen(
      // Use distinct to avoid unnecessary rebuilds if the state is the same
      (dynamic _) => notifyListeners(),
    );
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
