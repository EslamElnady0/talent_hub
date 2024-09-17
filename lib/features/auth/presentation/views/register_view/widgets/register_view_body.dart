import 'package:flutter/material.dart';
import 'package:talent_hub/core/helpers/spacing.dart';
import 'package:talent_hub/core/theme/app_colors.dart';
import 'package:talent_hub/features/auth/presentation/views/register_view/widgets/custom_text_form_field.dart';
import 'package:talent_hub/features/auth/presentation/views/register_view/widgets/register_header.dart';
import 'package:talent_hub/features/onboarding/presentation/views/widgets/custom_button.dart';

class RegisterViewBody extends StatelessWidget {
  const RegisterViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const RegisterHeader(),
          vGap(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                CustomTextFormField(
                  labelText: 'First Name',
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    return null;
                  },
                ),
                vGap(16),
                CustomTextFormField(
                  labelText: 'Last Name',
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    return null;
                  },
                ),
                vGap(16),
                CustomTextFormField(
                  labelText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    return null;
                  },
                ),
                vGap(16),
                CustomTextFormField(
                  labelText: 'Password',
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  validator: (value) {
                    return null;
                  },
                ),
              ],
            ),
          ),
          vGap(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomButton(
              text: 'CREATE ACCOUNT',
              onPressed: () {},
              textColor: AppColors.white,
              backgroundColor: AppColors.black,
            ),
          ),
        ],
      ),
    );
  }
}
