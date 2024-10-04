import 'package:flutter/material.dart';
import 'package:talent_hub/core/helpers/spacing.dart';
import 'package:talent_hub/core/models/post_model.dart';
import 'package:talent_hub/core/models/user_model.dart';
import 'package:talent_hub/features/post/presentation/views/widgets/comment_post_section.dart';
import 'package:talent_hub/features/post/presentation/views/widgets/desc_post_section.dart';
import 'package:talent_hub/features/post/presentation/views/widgets/head_post_section.dart';
import 'package:talent_hub/features/post/presentation/views/widgets/tail_post_section.dart';
import 'package:talent_hub/features/post/presentation/views/widgets/video_post_section.dart';

class PostView extends StatelessWidget {
  const PostView(
      {super.key, required this.postModel, required this.userModel});
  final PostModel postModel;
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: EdgeInsets.zero,
      elevation: 8.0,
      child: Container(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blueGrey),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          children: [
            HeadPostSection(postModel: postModel),
            const Divider(endIndent: 10, indent: 10),
            DescPostSection(postModel: postModel),
            vGap(10),
            VideoPostSection(postModel: postModel),
            vGap(15),
            TailPostSection(
              postModel: postModel,
              userModel: userModel,
            ),
            CommentPostSection(postModel: postModel)

          ],
        ),
      ),
    );
  }
}
