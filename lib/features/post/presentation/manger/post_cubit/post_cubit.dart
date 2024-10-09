import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talent_hub/core/helpers/show_toast.dart';
import 'package:talent_hub/core/helpers/spacing.dart';
import 'package:talent_hub/core/models/post_model.dart';
import 'package:talent_hub/core/models/user_model.dart';
import 'package:talent_hub/core/theme/app_colors.dart';
import 'package:talent_hub/features/post/presentation/manger/post_cubit/post_states.dart';
import 'package:talent_hub/features/post/presentation/views/widgets/comment_post_section.dart';
import 'package:talent_hub/features/scout/data/repos/scout_repo_impl.dart';

class PostCubit extends Cubit<PostStates> {
  PostCubit() : super(InitialPostState());

  static PostCubit get(context) => BlocProvider.of(context);

  List<PostModel> posts = [];
  TextEditingController commentController = TextEditingController();

  final currentUser = FirebaseAuth.instance.currentUser!.uid;

  Future<void> getPosts() async {
    emit(LoadingPostState());
    var result = await ScoutRepoImpl().fetchPosts();
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
      "imageUrl": userModel.imageUrl,
      "commentTime": Timestamp.now(),
    });
  }

  Future<int> getCommentsCount({required PostModel postModel}) async {
    CollectionReference commentsRef = FirebaseFirestore.instance
        .collection('posts')
        .doc(postModel.postId)
        .collection('comments');
    QuerySnapshot snapshot = await commentsRef.get();
    return snapshot.docs.length;
  }

  void showBottomSheet({
    required BuildContext context,
    required PostModel postModel,
    required UserModel userModel,
  }) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back),
                  ),
                  const Spacer(),
                  const Text(
                    "Comments",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: CommentPostSection(postModel: postModel),
                ),
              ),
            ),
            vGap(20),
            Padding(
              padding: EdgeInsets.only(
                left: 10.0,
                right: 10.0,
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: TextFormField(
                controller: commentController,
                onFieldSubmitted: (value) {
                  if (commentController.text.isNotEmpty) {
                    addComment(
                      commentText: commentController.text,
                      postModel: postModel,
                      userModel: userModel,
                    );
                    commentController.clear();
                  } else {
                    showToast(
                      toastMsg: "Empty comment",
                      state: ToastStates.warining,
                    );
                  }
                },
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Add comment..',
                  suffixIcon: IconButton(
                    onPressed: () {
                      if (commentController.text.isNotEmpty) {
                        addComment(
                          commentText: commentController.text,
                          postModel: postModel,
                          userModel: userModel,
                        );
                        commentController.clear();
                      } else {
                        showToast(
                          toastMsg: "Empty comment",
                          state: ToastStates.warining,
                        );
                      }
                    },
                    icon: const Icon(
                      Icons.send,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> likePost({required PostModel postModel}) async {
    try {
      await FirebaseFirestore.instance
          .collection('posts')
          .doc(postModel.postId)
          .update(
        {
          'likes': FieldValue.arrayUnion([currentUser])
        },
      );
    } on FirebaseException {
      showToast(toastMsg: 'Error liking post', state: ToastStates.error);
    }
  }

  Future<void> dislikePost({required PostModel postModel}) async {
    try {
      await FirebaseFirestore.instance
          .collection('posts')
          .doc(postModel.postId)
          .update(
        {
          'likes': FieldValue.arrayRemove([currentUser])
        },
      );
    } on FirebaseException {
      showToast(toastMsg: 'Error liking post', state: ToastStates.error);
    }
  }
}
