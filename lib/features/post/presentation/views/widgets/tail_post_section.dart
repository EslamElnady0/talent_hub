import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:talent_hub/core/helpers/extensions.dart';
import 'package:talent_hub/core/models/post_model.dart';
import 'package:talent_hub/core/models/user_model.dart';
import 'package:talent_hub/core/routes/app_router.dart';
import 'package:talent_hub/features/post/presentation/views/widgets/custom_tail_button.dart';
import 'package:talent_hub/features/post/presentation/views/widgets/like_button.dart';

import '../../manger/post_cubit/post_cubit.dart';

class TailPostSection extends StatefulWidget {
  const TailPostSection({
    super.key,
    required this.postModel,
    required this.userModel,
  });
  final PostModel postModel;
  final UserModel userModel;

  @override
  State<TailPostSection> createState() => _TailPostSectionState();
}

class _TailPostSectionState extends State<TailPostSection> {
  @override
  void initState() {
    super.initState();
    List likes = List<String>.from(widget.postModel.likes);
    PostCubit.get(context).isLiked = likes.contains(
      PostCubit.get(context).currentUser.email,
    );
  }

  @override
  Widget build(BuildContext context) {
    List likes = List<String>.from(widget.postModel.likes);
    PostCubit postCubit = PostCubit.get(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          LikeButton(
            onTap: () {
              postCubit.toggleLike(postModel: widget.postModel);
            },
            text: likes.length.toString(),
            isLiked: postCubit.isLiked,
          ),
          CustomTailButton(
            onTap: () {
              postCubit.showCommentDialog(
                context: context,
                postModel: widget.postModel,
                userModel: widget.userModel,
              );
            },
            icon: FontAwesomeIcons.commentDots,
            text: "Comments",
          ),
          if (widget.userModel.role == "scout")
            CustomTailButton(
              onTap: () => context.pushNamed(AppRouter.chatInbox),
              icon: FontAwesomeIcons.message,
              text: "Chat",
            )
        ],
      ),
    );
  }
}
