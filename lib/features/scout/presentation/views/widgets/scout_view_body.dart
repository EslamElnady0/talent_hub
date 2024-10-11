import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:talent_hub/core/DI/dependency_injection.dart';
import 'package:talent_hub/core/helpers/spacing.dart';
import 'package:talent_hub/core/models/post_model.dart';
import 'package:talent_hub/core/models/user_model.dart';
import 'package:talent_hub/features/post/presentation/views/widgets/add_post_section.dart';
import 'package:talent_hub/features/post/presentation/views/post_view.dart';
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
    return StreamBuilder<List<PostModel>?>(
      stream: getIt<FirebaseFirestore>()
          .collection("posts")
          .orderBy("createdAt", descending: false)
          .snapshots()
          .map(
            (event) => event.docs
                .map(
                  (e) => PostModel.fromJson(
                    e.data(),
                  ),
                )
                .toList(),
          ),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primaryColor),
          );
        }
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              if (userModel.role == 'player')
                AddPostSection(userModel: userModel),
              ListView.separated(
                reverse: true,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(10),
                itemCount: snapshot.data!.length,
                separatorBuilder: (context, index) => vGap(15),
                itemBuilder: (context, index) {
                  return PostView(
                    postModel: snapshot.data![index],
                    userModel: userModel,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
