import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:talent_hub/core/helpers/extensions.dart';
import 'package:talent_hub/core/helpers/spacing.dart';
import 'package:talent_hub/core/models/post_model.dart';
import 'package:talent_hub/core/models/user_model.dart';
import 'package:talent_hub/core/routes/app_router.dart';
import 'package:talent_hub/core/theme/app_colors.dart';
import 'package:talent_hub/core/utils/get_user_by_id.dart';
import 'package:talent_hub/features/post/presentation/views/widgets/custom_tail_button.dart';
import 'package:talent_hub/features/post/presentation/views/widgets/like_button.dart';
import '../../manger/post_cubit/post_cubit.dart';

class TailPostSection extends StatelessWidget {
  const TailPostSection({
    super.key,
    required this.postModel,
    required this.userModel,
  });

  final PostModel postModel;
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    List likes = List<String>.from(postModel.likes);
    PostCubit postCubit = PostCubit.get(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          LikeButton(
            onTap: () {
              if (likes.contains(postCubit.currentUser)) {
                postCubit.dislikePost(postModel: postModel);
              } else {
                postCubit.likePost(postModel: postModel);
              }
            },
            text: likes.length.toString(),
            isLiked: likes.contains(postCubit.currentUser),
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('posts')
                .doc(postModel.postId)
                .collection('comments')
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Row(
                  children: [
                    const Icon(FontAwesomeIcons.commentDots),
                    hGap(8),
                    const Text(
                      'Comments',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                );
              }
              return CustomTailButton(
                onTap: () {
                  postCubit.showBottomSheet(
                    context: context,
                    userModel: userModel,
                    postModel: postModel,
                  );
                },
                icon: FontAwesomeIcons.commentDots,
                text: "Comments",
                count: '${snapshot.data!.docs.length}',
              );
            },
          ),
          if (userModel.role == "scout")
            CustomTailButton(
              onTap: () async {
                showDialog(
                    context: context,
                    builder: (context) => const Center(
                            child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        )));
                UserModel user = await getUserById(postModel.uId);
                if (context.mounted) {
                  context.pop();
                  context.pushNamed(AppRouter.chatDetails, arguments: user);
                }
              },
              icon: Icons.chat_outlined,
              text: "Chat",
              count: '',
            ),
        ],
      ),
    );
  }
}
