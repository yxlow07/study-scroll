import 'package:flutter/material.dart';
import 'package:study_scroll/core/constants/images.dart';
import 'package:study_scroll/core/theme/AppStyles.dart';
import 'package:study_scroll/presentation/widgets/form_button.dart';
import 'package:study_scroll/presentation/widgets/input_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

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
                const Text('Create An Account', style: AppStyles.title),
                const SizedBox(height: 10),
                InputField(label: "Email", controller: emailController),
                const SizedBox(height: 10),
                InputField(label: "Name", controller: nameController),
                const SizedBox(height: 10),
                InputField(label: "Password", controller: passwordController, isPassword: true),
                const SizedBox(height: 10),
                InputField(label: "Confirm Password", controller: confirmPasswordController, isPassword: true),
                const SizedBox(height: 20),
                FormButton(
                  text: "Sign Up",
                  onPressed:
                      () => {
                        print(
                          "Register pressed with email: ${emailController.text}, name: ${nameController.text}, password: ${passwordController.text}, confirm password: ${confirmPasswordController.text}",
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
