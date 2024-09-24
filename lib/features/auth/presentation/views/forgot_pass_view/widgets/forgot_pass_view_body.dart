import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:talent_hub/core/DI/dependency_injection.dart';
import 'package:talent_hub/core/helpers/show_toast.dart';
import 'package:talent_hub/core/helpers/spacing.dart';
import 'package:talent_hub/core/theme/app_colors.dart';
import 'package:talent_hub/features/auth/presentation/views/forgot_pass_view/widgets/forgot_pass_header.dart';
import 'package:talent_hub/features/auth/presentation/views/register_view/widgets/custom_text_form_field.dart';
import 'package:talent_hub/features/onboarding/presentation/views/widgets/custom_button.dart';

class ForgotPassViewBody extends StatefulWidget {
  const ForgotPassViewBody({super.key});

  @override
  State<ForgotPassViewBody> createState() => _ForgotPassViewBodyState();
}

class _ForgotPassViewBodyState extends State<ForgotPassViewBody> {
  var emailsController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const ForgotPassHeader(),
        vGap(20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: CustomTextFormField(
            controller: emailsController,
            labelText: 'Email',
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              return null;
            },
          ),
        ),
        vGap(20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: CustomButton(
            text: 'Reset Password',
            backgroundColor: AppColors.black,
            textColor: AppColors.white,
            onPressed: () async {
              await getIt
                  .get<FirebaseAuth>()
                  .sendPasswordResetEmail(email: emailsController.text);

              showToast(
                toastMsg: 'Sent Reset Link to ${emailsController.text}',
                state: ToastStates.success,
              );
            },
          ),
        ),
      ],
    );
  }
}
