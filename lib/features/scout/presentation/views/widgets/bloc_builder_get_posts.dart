import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:talent_hub/core/helpers/show_toast.dart';
import 'package:talent_hub/core/models/user_model.dart';
import 'package:talent_hub/features/post/presentation/manger/post_cubit/post_cubit.dart';
import 'package:talent_hub/features/post/presentation/manger/post_cubit/post_states.dart';
import 'package:talent_hub/features/post/presentation/views/widgets/add_post_section.dart';
import 'package:talent_hub/features/scout/presentation/manger/scout_cubit/scout_cubit.dart';
import 'package:talent_hub/features/scout/presentation/views/widgets/scout_view_body.dart';

class BlocBuilderGetPosts extends StatelessWidget {
  const BlocBuilderGetPosts({super.key, required this.userModel});
  final UserModel userModel;
  @override
  Widget build(BuildContext context) {
    RefreshController refreshController =
        RefreshController(initialRefresh: false);
    return BlocConsumer<PostCubit, PostStates>(
      listener: (context, state) {
        if (state is FailurePostState) {
          showToast(toastMsg: state.error, state: ToastStates.error);
        }
      },
      builder: (context, state) {
        return SmartRefresher(
          controller: refreshController,
          onRefresh: () async {
            ScoutCubit.get(context).getScout();
            PostCubit.get(context).getPosts();
            await Future.delayed(const Duration(milliseconds: 1000));
            refreshController.refreshCompleted();
          },
          child: ConditionalBuilder(
            condition: PostCubit.get(context).posts.isNotEmpty,
            builder: (context) => ScoutViewBody(
                posts: PostCubit.get(context).posts, userModel: userModel),
            fallback: (context) => Column(
              children: [
                if (userModel.role == 'player')
                  AddPostSection(userModel: userModel),
                const Spacer(),
                const Text("No posted added yet."),
                const Spacer(),
              ],
            ),
          ),
        );
      },
    );
  }
}
