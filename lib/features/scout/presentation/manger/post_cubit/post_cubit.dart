import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talent_hub/core/helpers/extensions.dart';
import 'package:talent_hub/core/models/post_model.dart';
import 'package:talent_hub/core/models/user_model.dart';
import 'package:talent_hub/core/theme/app_colors.dart';
import 'package:talent_hub/features/scout/presentation/manger/post_cubit/post_states.dart';

import '../../../data/repos/scout_repo_impl.dart';

class PostCubit extends Cubit<PostStates> {
  PostCubit() : super(InitialPostState());
  static PostCubit get(context) => BlocProvider.of(context);
  final ScoutRepoImpl _scoutRepo = ScoutRepoImpl();
  List<PostModel> posts = [];
  bool isLiked = false;
  final currentUser = FirebaseAuth.instance.currentUser;
  TextEditingController commentController = TextEditingController();

  Future<void> getPosts() async {
    emit(LoadingPostState());
    var result = await _scoutRepo.fetchPosts();
    result.fold((failure) {
      emit(FailurePostState(error: failure.message));
    }, (postsList) {
      posts = postsList;
      emit(SuccessPostState());
    });
  }

  void addComment({
    required String commentText,
    required PostModel postModel,
    required UserModel userModel,
  }) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postModel.postId)
        .collection('comments')
        .add({
      "commentText": commentText,
      "commentedBy": userModel.name,
      "commentTime": Timestamp.now(),
    });
  }

  void showCommentDialog({
    required BuildContext context,
    required PostModel postModel,
    required UserModel userModel,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Comment'),
        content: TextField(
          controller: commentController,
          decoration: const InputDecoration(hintText: 'Write Comment..'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.pop();
              commentController.clear();
            },
            child: const Text(
              'Cancel',
              style: TextStyle(color: AppColors.black),
            ),
          ),
          TextButton(
            onPressed: () {
              addComment(
                  commentText: commentController.text,
                  postModel: postModel,
                  userModel: userModel);
              context.pop();
              commentController.clear();
            },
            child: const Text(
              'Post',
              style: TextStyle(color: AppColors.primaryColor),
            ),
          ),
        ],
      ),
    );
  }

  void toggleLike({required PostModel postModel}) {
    isLiked = !isLiked;

    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("posts").doc(postModel.postId);
    if (isLiked) {
      documentReference.update({
        "likes": FieldValue.arrayUnion([currentUser!.email]),
      });
    } else {
      documentReference.update({
        "likes": FieldValue.arrayRemove([currentUser!.email]),
      });
    }
    emit(SuccessPostState());
  }
}
