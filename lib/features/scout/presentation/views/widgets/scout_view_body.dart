import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:talent_hub/core/DI/dependency_injection.dart';
import 'package:talent_hub/core/helpers/spacing.dart';
import 'package:talent_hub/core/models/post_model.dart';
import 'package:talent_hub/core/models/user_model.dart';
import 'package:talent_hub/features/scout/presentation/views/widgets/post/custom_player_post.dart';

import '../../../../../core/theme/app_colors.dart';

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
          child: StreamBuilder<List<PostModel>?>(
              stream: getIt<FirebaseFirestore>()
                  .collection("posts")
                  .orderBy("createdAt", descending: true)
                  .snapshots()
                  .map((event) => event.docs
                      .map((e) => PostModel.fromJson(e.data()))
                      .toList()),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                      child: CircularProgressIndicator(
                          color: AppColors.primaryColor));
                }
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return CustomPlayerPost(
                      postModel: snapshot.data![index],
                      index: index,
                      userModel: userModel,
                    );
                  },
                );
              }),
        ),
        vGap(90)
      ],
    );
  }
}
