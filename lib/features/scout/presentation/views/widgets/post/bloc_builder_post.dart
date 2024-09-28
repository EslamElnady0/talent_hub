import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talent_hub/core/theme/app_colors.dart';
import 'package:talent_hub/features/scout/presentation/manger/post_cubit/post_cubit.dart';
import 'package:talent_hub/features/scout/presentation/manger/post_cubit/post_states.dart';
import 'package:talent_hub/features/scout/presentation/views/widgets/scout_view_body.dart';

class BlocBuilderPost extends StatelessWidget {
  const BlocBuilderPost({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostCubit, PostStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: PostCubit.get(context).posts.isNotEmpty
              //&& PostCubit.get(context).postsId.isNotEmpty
              //&& PostCubit.get(context).likes.isNotEmpty
          ,
          builder: (context) =>
              ScoutViewBody(posts: PostCubit.get(context).posts),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          ),
        );
        // if (state is SuccessPostState) {
        //   return ScoutViewBody(posts: state.posts);
        // } else if (state is FailurePostState) {
        //   return Center(
        //     child: Padding(
        //       padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        //       child: Text(
        //         state.error,
        //         style: const TextStyle(
        //           fontSize: 18,
        //           color: AppColors.primaryColor,
        //         ),
        //         textAlign: TextAlign.center,
        //       ),
        //     ),
        //   );
        // } else {
        //   return const Center(
        //     child: CircularProgressIndicator(
        //       color: AppColors.primaryColor,
        //     ),
        //   );
        // }
      },
    );
  }
}
