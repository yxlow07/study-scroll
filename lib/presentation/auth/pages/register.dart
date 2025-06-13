import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_scroll/core/theme/AppStyles.dart';
import 'package:study_scroll/presentation/auth/bloc/auth_cubit.dart';
import 'package:study_scroll/presentation/auth/widgets/auth_appbar.dart';
import 'package:study_scroll/presentation/widgets/alert.dart';
import 'package:study_scroll/presentation/widgets/form_button.dart';
import 'package:study_scroll/presentation/widgets/input_field.dart';
import 'package:study_scroll/presentation/widgets/link.dart';
import 'package:study_scroll/presentation/widgets/logo.dart';

class RegisterPage extends StatefulWidget {
  final void Function() toggleAuthMode;
  const RegisterPage({super.key, required this.toggleAuthMode});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void register() {
    final String email = emailController.text;
    final String name = nameController.text;
    final String password = passwordController.text;
    final String confirmPassword = confirmPasswordController.text;

    if (email.isNotEmpty && name.isNotEmpty && password.isNotEmpty && confirmPassword.isNotEmpty) {
      if (password == confirmPassword) {
        final authCubit = context.read<AuthCubit>();
        authCubit.signUp(email, password, name);
      } else {
        Alert.alert(context, 'Passwords do not match');
      }
    } else {
      Alert.alert(context, 'Please fill in all the fields');
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AuthAppBar(title: 'Register'),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Logo(),
                const SizedBox(height: 20),
                Text('Create An Account', style: AppStyles.title(context)),
                const SizedBox(height: 10),
                InputField(label: "Email", controller: emailController),
                const SizedBox(height: 10),
                InputField(label: "Name", controller: nameController),
                const SizedBox(height: 10),
                InputField(label: "Password", controller: passwordController, isPassword: true),
                const SizedBox(height: 10),
                InputField(label: "Confirm Password", controller: confirmPasswordController, isPassword: true),
                const SizedBox(height: 20),
                FormButton(text: "Sign Up", onPressed: register),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account? ", style: AppStyles.subtitle),
                    Link(onTap: widget.toggleAuthMode, child: Text("Login", style: AppStyles.subtitleBold)),
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
