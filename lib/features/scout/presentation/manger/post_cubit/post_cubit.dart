import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talent_hub/core/models/post_model.dart';
import 'package:talent_hub/features/scout/presentation/manger/post_cubit/post_states.dart';

class PostCubit extends Cubit<PostStates> {
  PostCubit() : super(InitialPostState());
  static PostCubit get(context) => BlocProvider.of(context);

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];

  void getPosts() async {
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      for (var element in value.docs) {
        element.reference.collection("likes").get().then((value) {
          likes.add(value.docs.length);
        }).catchError((error) {});
        postsId.add(element.id);
        posts.add(PostModel.fromJson(element.data()));
      }
      emit(SuccessPostState());
    }).catchError((error) {
      emit(FailurePostState(error: error.message));
    });
    // emit(LoadingPostState());
    // var result = await ScoutRepoImpl().fetchPosts();
    // result.fold((failure) {
    //   emit(FailurePostState(error: failure.message));
    // }, (posts) {
    //   emit(SuccessPostState(posts: posts));
    // });
  }

  void likePost({required String postId}) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      "like": true,
    }).then((value) {
      emit(LikePostSuccessPostState());
    }).catchError((error) {
      emit(LikePostFailurePostState(error: error.message));
    });
  }
}
