import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:study_scroll/core/routes/app_routes.dart';
import 'package:study_scroll/presentation/auth/bloc/auth_cubit.dart';
import 'package:study_scroll/presentation/auth/bloc/auth_states.dart';
import 'package:study_scroll/presentation/auth/pages/auth.dart';
import 'package:study_scroll/presentation/home/home.dart';
import 'package:study_scroll/presentation/profile/profile.dart';

// final goRouter = GoRouter(
//   initialLocation: AppRoutes.home,
//   redirect: (context, state) {
//     final authCubit = context.read<AuthCubit>();
//     final authState = authCubit.state;
//
//     if (authState is AuthSignedOut || authState is AuthError || authState is AuthInitial) {
//       return AppRoutes.auth;
//     }
//
//     // Allow authenticated users to proceed
//     return null;
//   },
//   routes: [
//     GoRoute(
//       path: AppRoutes.auth,
//       builder:
//           (context, state) => BlocListener<AuthCubit, AuthState>(
//             listener: (context, state) {
//               if (state is AuthError || state is AuthSignedOut || state is AuthInitial) {
//                 // Redirect to auth page if not authenticated
//                 WidgetsBinding.instance.addPostFrameCallback((_) => GoRouter.of(context).go(AppRoutes.auth));
//               } else if (state is AuthSignedIn) {
//                 // Redirect to home page if authenticated
//                 GoRouter.of(context).go(AppRoutes.home);
//               }
//             },
//             child: AuthPage(),
//           ),
//     ),
//     GoRoute(path: AppRoutes.home, builder: (context, state) => HomePage()),
//     GoRoute(path: AppRoutes.profile, builder: (context, state) => const ProfilePage()),
//     GoRoute(
//       path: AppRoutes.leaderboard,
//       builder: (context, state) => const Center(child: Text('Leaderboard Page (Route)')),
//     ),
//     GoRoute(path: AppRoutes.quiz, builder: (context, state) => const Center(child: Text('Quiz Page (Route)'))),
//     // Add your other routes here
//   ],
//   errorBuilder: (context, state) => Scaffold(body: Center(child: CircularProgressIndicator())),
// );

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
        if (currentState is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(currentState.message)));
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
    routes: [
      GoRoute(path: AppRoutes.auth, builder: (context, state) => AuthPage()),
      GoRoute(path: AppRoutes.home, builder: (context, state) => HomePage()),
      GoRoute(path: AppRoutes.profile, builder: (context, state) => const ProfilePage()),
      GoRoute(
        path: AppRoutes.leaderboard,
        builder: (context, state) => const Center(child: Text('Leaderboard Page (Route)')),
      ),
      GoRoute(path: AppRoutes.quiz, builder: (context, state) => const Center(child: Text('Quiz Page (Route)'))),
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
