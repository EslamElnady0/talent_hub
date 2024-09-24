import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talent_hub/core/helpers/extensions.dart';
import 'package:talent_hub/core/helpers/show_toast.dart';
import 'package:talent_hub/core/helpers/spacing.dart';
import 'package:talent_hub/core/helpers/validators_regex.dart';
import 'package:talent_hub/core/routes/app_router.dart';
import 'package:talent_hub/core/theme/app_colors.dart';
import 'package:talent_hub/features/auth/presentation/manger/login_cubit/login_cubit.dart';
import 'package:talent_hub/features/auth/presentation/manger/login_cubit/login_states.dart';
import 'package:talent_hub/features/auth/presentation/views/login_view/widgets/login_header.dart';
import 'package:talent_hub/features/auth/presentation/views/register_view/widgets/custom_text_form_field.dart';
import 'package:talent_hub/features/onboarding/presentation/views/widgets/custom_button.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<LoginCubit>(context);
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const LoginHeader(),
            vGap(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  CustomTextFormField(
                    labelText: 'Email',
                    controller: cubit.emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!ValidatorsRegex.isEmailValid(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  vGap(16),
                  CustomTextFormField(
                    labelText: 'Password',
                    keyboardType: TextInputType.visiblePassword,
                    controller: cubit.passwordController,
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (!ValidatorsRegex.isPasswordValid(value)) {
                        return 'Password must be at least 8 characters long, contain at least one uppercase letter, one lowercase letter, one number, and one special character';
                      }
                      return null;
                    },
                  ),
                  vGap(4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          context.pushNamed(AppRouter.forgotPassword);
                        },
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: AppColors.grey,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            vGap(20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: BlocConsumer<LoginCubit, LoginStates>(
                    listener: (context, state) {
                      if (state is LoginSuccessState) {
                        context.pushNamedAndRemoveUntil(AppRouter.scout,
                            predicate: (_) => false);
                      } else if (state is LoginErrorState) {
                        showToast(
                          toastMsg: state.error,
                          state: ToastStates.error,
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is! LoginLoadingState) {
                        return CustomButton(
                          text: 'SIGN IN',
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              cubit.login();
                            }
                          },
                          textColor: AppColors.white,
                          backgroundColor: AppColors.black,
                        );
                      } else {
                        return const CustomButton(
                          text: 'SIGN IN',
                          widget: CircularProgressIndicator(),
                          textColor: AppColors.white,
                          backgroundColor: AppColors.black,
                        );
                      }
                    },
                  ),
                ),
                vGap(20),
                const Text(
                  'OR',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                vGap(16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomButton(
                    text: 'SIGN UP',
                    onPressed: () {
                      context.pushNamed(AppRouter.register);
                    },
                    textColor: AppColors.black,
                    backgroundColor: AppColors.smoke,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
