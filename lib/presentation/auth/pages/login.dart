import 'package:flutter/material.dart';
import 'package:study_scroll/core/constants/images.dart';
import 'package:study_scroll/core/theme/AppStyles.dart';
import 'package:study_scroll/presentation/widgets/form_button.dart';
import 'package:study_scroll/presentation/widgets/input_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: Image(image: AssetImage(images.logo), width: 100, height: 100),
                ),
                const SizedBox(height: 20),
                const Text('Login', style: AppStyles.title),
                const SizedBox(height: 10),
                InputField(label: "Email", controller: emailController),
                const SizedBox(height: 10),
                InputField(label: "Password", controller: passwordController, isPassword: true),
                const SizedBox(height: 20),
                FormButton(
                  text: "Login",
                  onPressed:
                      () => {
                        print(
                          "Login pressed with email: ${emailController.text} and password: ${passwordController.text}",
                        ),
                      },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
