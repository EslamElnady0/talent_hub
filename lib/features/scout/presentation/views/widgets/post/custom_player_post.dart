import 'package:flutter/material.dart';
import 'package:talent_hub/core/helpers/spacing.dart';
import 'package:talent_hub/core/models/post_model.dart';
import 'package:talent_hub/core/models/user_model.dart';
import 'package:talent_hub/features/scout/presentation/views/widgets/post/comment_post_section.dart';
import 'package:talent_hub/features/scout/presentation/views/widgets/post/desc_post_section.dart';
import 'package:talent_hub/features/scout/presentation/views/widgets/post/head_post_section.dart';
import 'package:talent_hub/features/scout/presentation/views/widgets/post/tail_post_section.dart';
import 'package:talent_hub/features/scout/presentation/views/widgets/post/video_post_section.dart';

class CustomPlayerPost extends StatelessWidget {
  const CustomPlayerPost({
    super.key,
    required this.postModel,
    required this.index,
    required this.userModel,
  });
  final PostModel postModel;
  final UserModel userModel;
  final int index;
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
            color: Colors.white),
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
              index: index,
              userModel: userModel,
            ),
            CommentPostSection(postModel: postModel)
          ],
        ),
      ),
    );
  }
}
