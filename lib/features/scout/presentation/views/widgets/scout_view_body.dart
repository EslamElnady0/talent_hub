import 'package:flutter/material.dart';
import 'package:talent_hub/core/helpers/spacing.dart';
import 'package:talent_hub/core/models/post_model.dart';
import 'package:talent_hub/core/models/user_model.dart';
import 'package:talent_hub/features/scout/presentation/views/widgets/post/custom_player_post.dart';

class ScoutViewBody extends StatelessWidget {
  const ScoutViewBody({
    super.key,
    required this.posts,
    required this.userModel,
  });
  final List<PostModel> posts;
  final UserModel userModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(10),
            itemBuilder: (context, index) {
              return CustomPlayerPost(
                  postModel: posts[index], index: index, userModel: userModel);
            },
            separatorBuilder: (context, index) => vGap(10),
            itemCount: posts.length,
          ),
        ),
        vGap(90)
      ],
    );
  }
}
