import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:talent_hub/core/helpers/extensions.dart';
import 'package:talent_hub/core/models/post_model.dart';
import 'package:talent_hub/core/models/user_model.dart';
import 'package:talent_hub/core/routes/app_router.dart';
import 'package:talent_hub/features/scout/presentation/manger/post_cubit/post_cubit.dart';
import 'package:talent_hub/features/scout/presentation/views/widgets/post/custom_tail_button.dart';
import 'package:talent_hub/features/scout/presentation/views/widgets/post/like_button.dart';

class TailPostSection extends StatefulWidget {
  const TailPostSection({
    super.key,
    required this.postModel,
    required this.index,
    required this.userModel,
  });
  final PostModel postModel;
  final int index;
  final UserModel userModel;

  @override
  State<TailPostSection> createState() => _TailPostSectionState();
}

class _TailPostSectionState extends State<TailPostSection> {
  @override
  void initState() {
    super.initState();
    setState(() {
      PostCubit.get(context).isLiked = List<String>.from(widget.postModel.likes)
          .contains(PostCubit.get(context).currentUser!.email);
    });
  }

  @override
  Widget build(BuildContext context) {
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
            text: widget.postModel.likes.length.toString(),
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
            icon: FontAwesomeIcons.comments,
            text: "Comments",
          ),
          CustomTailButton(
            onTap: () => context.pushNamed(AppRouter.chatInbox),
            icon: FontAwesomeIcons.message,
            text: "Chat",
          ),
        ],
      ),
    );
  }
}
