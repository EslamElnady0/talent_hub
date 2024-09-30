import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talent_hub/core/models/user_model.dart';
import 'package:talent_hub/core/theme/app_colors.dart';
import 'package:talent_hub/features/scout/presentation/manger/post_cubit/post_cubit.dart';
import 'package:talent_hub/features/scout/presentation/manger/post_cubit/post_states.dart';
import 'package:talent_hub/features/scout/presentation/views/widgets/scout_view_body.dart';

class BlocBuilderPost extends StatelessWidget {
  const BlocBuilderPost({super.key, required this.userModel});
  final UserModel userModel;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostCubit, PostStates>(builder: (context, state) {
      if (state is SuccessPostState) {
        return ScoutViewBody(
            posts: context.read<PostCubit>().posts, userModel: userModel);
      } else if (state is FailurePostState) {
        return Center(
          child: Text(state.error),
        );
      } else {
        return const Center(
          child: CircularProgressIndicator(
            color: AppColors.primaryColor,
          ),
        );
      }
    });
  }
}
