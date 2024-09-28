import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:talent_hub/core/helpers/extensions.dart';
import 'package:talent_hub/core/helpers/spacing.dart';
import 'package:talent_hub/core/models/post_model.dart';
import 'package:talent_hub/core/routes/app_router.dart';
import 'package:talent_hub/core/theme/app_colors.dart';
import 'package:talent_hub/features/scout/presentation/manger/post_cubit/post_cubit.dart';

class TailPostSection extends StatelessWidget {
  const TailPostSection(
      {super.key, required this.postModel, required this.index});
  final PostModel postModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              PostCubit.get(context)
                  .likePost(postId: PostCubit.get(context).postsId[index]);
            },
            child: PostCubit.get(context).likes.isNotEmpty
                ? Row(
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.solidHeart,
                        color: AppColors.primaryColor,
                      ),
                      hGap(5),
                      Text(
                        "${PostCubit.get(context).likes[index]}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      hGap(5),
                      const Text(
                        "Like",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                      )
                    ],
                  )
                : Row(
                    children: [
                      const FaIcon(FontAwesomeIcons.heart),
                      hGap(5),
                      const Text(
                        "Like",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
          ),
          InkWell(
            onTap: () {
              context.pushNamed(AppRouter.chatInbox);
            },
            child: Row(
              children: [
                const FaIcon(
                  FontAwesomeIcons.facebookMessenger,
                ),
                hGap(5),
                const Text(
                  "Chat",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
