import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talent_hub/core/helpers/show_toast.dart';
import 'package:talent_hub/core/helpers/spacing.dart';
import 'package:talent_hub/core/models/user_model.dart';
import 'package:talent_hub/core/theme/app_colors.dart';
import 'package:talent_hub/features/profile/presentation/manger/profile_cubit.dart';
import 'package:talent_hub/features/profile/presentation/manger/profile_state.dart';
import 'package:talent_hub/features/profile/presentation/views/widgets/custom_stack_image.dart';
import 'package:talent_hub/features/profile/presentation/views/widgets/custom_upload_button.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({super.key, required this.userModel});
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    ProfileCubit profileCubit = ProfileCubit.get(context);
    return BlocConsumer<ProfileCubit, ProfileStates>(
      listener: (context, state) {
        if (state is SuccessUpdateProfileState) {
          showToast(
            toastMsg: "uploaded profile image\n refresh your account.",
            state: ToastStates.success,
          );
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            CustomStackImage(userModel: userModel),
            if (profileCubit.profileImage != null &&
                state is! SuccessUpdateProfileState)
              CustomUploadButton(userModel: userModel),
            if (state is LoadingUpdateProfileState)
              const LinearProgressIndicator(color: AppColors.primaryColor),
            vGap(15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  userModel.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '(${userModel.role})',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            Text(
              userModel.role == 'player'
                  ? "I'm ${userModel.age} years old my position is ${userModel.position}."
                  : userModel.email,
              style: const TextStyle(fontSize: 17),
              textAlign: TextAlign.center,
            ),
          ],
        );
      },
    );
  }
}
