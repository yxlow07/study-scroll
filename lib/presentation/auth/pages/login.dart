import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_scroll/core/theme/AppStyles.dart';
import 'package:study_scroll/presentation/auth/bloc/auth_cubit.dart';
import 'package:study_scroll/presentation/home/bloc/ThemeCubit.dart';
import 'package:study_scroll/presentation/widgets/form_button.dart';
import 'package:study_scroll/presentation/widgets/input_field.dart';
import 'package:study_scroll/presentation/widgets/logo.dart';

class LoginPage extends StatefulWidget {
  final void Function() toggleAuthMode;

  const LoginPage({super.key, required this.toggleAuthMode});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login() {
    final String email = emailController.text;
    final String password = passwordController.text;
    final authCubit = context.read<AuthCubit>();

    if (email.isNotEmpty && password.isNotEmpty) {
      authCubit.signIn(email, password);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill in all fields')));
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.light_mode),
            onPressed: () {
              context.read<ThemeCubit>().toggleTheme();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Logo(),
                const SizedBox(height: 20),
                Text('Login', style: AppStyles.title(context)),
                const SizedBox(height: 10),
                InputField(label: "Email", controller: emailController),
                const SizedBox(height: 10),
                InputField(label: "Password", controller: passwordController, isPassword: true),
                const SizedBox(height: 20),
                FormButton(text: "Login", onPressed: login),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? ", style: AppStyles.subtitle),
                    GestureDetector(
                      onTap: widget.toggleAuthMode,
                      child: const Text("Sign Up", style: AppStyles.subtitleBold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
