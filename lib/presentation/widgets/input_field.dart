import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isPassword;
  final String? Function(String?)? validator;

  const InputField({super.key, required this.label, required this.controller, this.isPassword = false, this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(labelText: label, border: OutlineInputBorder()),
      validator: validator,
    );
  }
}
