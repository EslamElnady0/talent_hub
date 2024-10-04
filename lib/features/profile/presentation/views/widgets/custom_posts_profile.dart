import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talent_hub/core/DI/dependency_injection.dart';
import 'package:talent_hub/core/helpers/spacing.dart';
import 'package:talent_hub/core/models/post_model.dart';
import 'package:talent_hub/core/models/user_model.dart';
import 'package:talent_hub/core/theme/app_colors.dart';
import 'package:talent_hub/features/post/presentation/manger/post_cubit/post_cubit.dart';
import 'package:talent_hub/features/post/presentation/manger/post_cubit/post_states.dart';
import 'package:talent_hub/features/post/presentation/views/post_view.dart';

class CustomPostsProfile extends StatelessWidget {
  const CustomPostsProfile({super.key, required this.userModel});

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(indent: 10, endIndent: 10),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Text('Your posts : '),
        ),
        BlocProvider(
          create: (context) => PostCubit()..getPosts(),
          child: BlocBuilder<PostCubit, PostStates>(
            builder: (context, state) {
              return StreamBuilder<List<PostModel>?>(
                stream: getIt<FirebaseFirestore>()
                    .collection("posts")
                    .where(
                      "uId",
                      isEqualTo: FirebaseAuth.instance.currentUser!.uid,
                    )
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
                    return Column(
                      children: [
                        vGap(100),
                        const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    );
                  }
                  return ListView.separated(
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
                  );
                },
              );
            },
          ),
        )
      ],
    );
  }
}
