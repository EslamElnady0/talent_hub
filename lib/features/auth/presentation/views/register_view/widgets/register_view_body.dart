import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talent_hub/core/helpers/extensions.dart';
import 'package:talent_hub/core/helpers/show_toast.dart';
import 'package:talent_hub/core/helpers/spacing.dart';
import 'package:talent_hub/core/helpers/validators_regex.dart';
import 'package:talent_hub/core/routes/app_router.dart';
import 'package:talent_hub/core/theme/app_colors.dart';
import 'package:talent_hub/features/auth/presentation/manger/signup_cubit/signup_cubit.dart';
import 'package:talent_hub/features/auth/presentation/manger/signup_cubit/signup_states.dart';
import 'package:talent_hub/features/auth/presentation/views/register_view/widgets/custom_drop_down.dart';
import 'package:talent_hub/features/auth/presentation/views/register_view/widgets/custom_text_form_field.dart';
import 'package:talent_hub/features/auth/presentation/views/register_view/widgets/register_header.dart';
import 'package:talent_hub/features/onboarding/presentation/views/widgets/custom_button.dart';

class RegisterViewBody extends StatefulWidget {
  const RegisterViewBody({super.key});

  @override
  State<RegisterViewBody> createState() => _RegisterViewBodyState();
}

class _RegisterViewBodyState extends State<RegisterViewBody> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<SignupCubit>(context);
    return Form(
      key: formKey,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const RegisterHeader(),
                vGap(10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Center(
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.bottomRight,
                      children: [
                        BlocBuilder<SignupCubit, SignupStates>(
                          builder: (context, state) {
                            return CircleAvatar(
                              radius: 70,
                              backgroundImage: cubit.imageFile != null
                                  ? FileImage(cubit.imageFile!)
                                  : const AssetImage(
                                      'assets/images/default_user.png'),
                            );
                          },
                        ),
                        InkWell(
                          onTap: () {
                            cubit.pickImage();
                          },
                          child: Container(
                            width: 35,
                            height: 40,
                            decoration: const BoxDecoration(
                              color: AppColors.primaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt_outlined,
                              size: 25,
                              color: AppColors.smoke,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                vGap(10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      CustomTextFormField(
                        labelText: 'Name',
                        controller: cubit.nameController,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      vGap(16),
                      CustomTextFormField(
                        labelText: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        controller: cubit.emailController,
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
                        obscureText: true,
                        controller: cubit.passwordController,
                        keyboardType: TextInputType.visiblePassword,
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
                      vGap(16),
                      CustomTextFormField(
                        labelText: 'Age',
                        controller: cubit.ageController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your age';
                          }
                          return null;
                        },
                      ),
                      vGap(16),
                      CustomTextFormField(
                        labelText: 'Phone',
                        controller: cubit.phoneController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          if (!ValidatorsRegex.isPhoneNumberValid(value)) {
                            return 'Please enter a valid phone number';
                          }
                          return null;
                        },
                      ),
                      vGap(16),
                      CustomTextFormField(
                        labelText: 'Position',
                        controller: cubit.positionController,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your position';
                          }
                          return null;
                        },
                      ),
                      vGap(16),
                      CustomDropDown(
                        validator: (value) {
                          if (value == null) {
                            return 'Please select your role player or scout';
                          }
                          if (value.isEmpty) {
                            return 'Please select your role player or scout';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          if (value != null) {
                            cubit.roleController.text = value;
                          }
                        },
                        hintText: 'Role',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                const Spacer(),
                vGap(20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: BlocConsumer<SignupCubit, SignupStates>(
                    listener: (context, state) {
                      if (state is SignupSuccessState) {
                        context.pushNamedAndRemoveUntil(
                          AppRouter.scout,
                          predicate: (_) => false,
                        );
                      } else if (state is SignupErrorState) {
                        showToast(
                          toastMsg: state.error,
                          state: ToastStates.error,
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is! SignupLoadingState) {
                        return CustomButton(
                          text: 'CREATE ACCOUNT',
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              cubit.signup();
                            }
                          },
                          textColor: AppColors.white,
                          backgroundColor: AppColors.black,
                        );
                      } else {
                        return const CustomButton(
                          text: 'CREATE ACCOUNT',
                          widget:
                              CircularProgressIndicator(color: AppColors.white),
                          textColor: AppColors.white,
                          backgroundColor: AppColors.black,
                        );
                      }
                    },
                  ),
                ),
                vGap(60),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
