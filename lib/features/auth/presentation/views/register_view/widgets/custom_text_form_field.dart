import 'package:flutter/material.dart';
import 'package:talent_hub/core/theme/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.labelText,
    this.validator,
    required this.keyboardType,
    this.obscureText = false,
    required this.controller,
  });
  final String labelText;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      keyboardType: keyboardType,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        border: const OutlineInputBorder(borderSide: BorderSide.none),
        filled: true,
        fillColor: AppColors.smoke,
        hintText: labelText,
        hintStyle: const TextStyle(color: AppColors.fieldColor),
      ),
    );
  }
}
