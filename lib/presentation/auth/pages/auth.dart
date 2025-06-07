import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_scroll/presentation/auth/bloc/auth_cubit.dart';
import 'package:study_scroll/presentation/auth/bloc/auth_states.dart';
import 'package:study_scroll/presentation/auth/pages/login.dart';
import 'package:study_scroll/presentation/auth/pages/register.dart';

class AuthPage extends StatelessWidget {
  // Or StatefulWidget if you had other reasons
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        // The state.mode will determine which view to show
        // This assumes your AuthState always has a 'mode'
        if (state.mode == AuthMode.login) {
          return LoginPage(
            toggleAuthMode: () {
              context.read<AuthCubit>().toggleAuthMode();
            },
          );
        } else {
          return RegisterPage(
            toggleAuthMode: () {
              context.read<AuthCubit>().toggleAuthMode();
            },
          );
        }
      },
    );
  }
}
