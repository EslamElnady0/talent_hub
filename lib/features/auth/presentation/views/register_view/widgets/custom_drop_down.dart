import 'package:flutter/material.dart';
import 'package:talent_hub/core/theme/app_colors.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({
    super.key,
    this.validator,
    required this.onChanged,
    required this.hintText,
  });

  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      validator: validator,
      items: const <DropdownMenuItem<String>>[
        DropdownMenuItem<String>(
          value: 'player',
          child: Text('Player'),
        ),
        DropdownMenuItem<String>(
          value: 'scout',
          child: Text('Scout'),
        ),
      ],
      onChanged: onChanged,
      decoration: const InputDecoration(
        errorMaxLines: 3,
        border: OutlineInputBorder(borderSide: BorderSide.none),
        filled: true,
        fillColor: AppColors.smoke,
      ),
      hint: Text(
        hintText,
        style: const TextStyle(color: AppColors.fieldColor),
      ),
      icon: const Icon(Icons.arrow_drop_down_circle),
    );
  }
}
