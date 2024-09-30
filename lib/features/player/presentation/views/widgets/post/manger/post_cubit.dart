import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talent_hub/features/player/presentation/model/player_model.dart';
import 'package:talent_hub/features/player/presentation/views/widgets/post/manger/post_states.dart';

import '../model/posts_model.dart';

class PostsCubit extends Cubit<PostState> {
  PostsCubit() : super(CreatePostInitialState());

  static PostsCubit get(context) => BlocProvider.of(context);
  late PlayerModel playerModel;

  void createPost({
    required String description,
    required File videoFile,
  }) async {
    emit(CreatePostLoadingState());

    try {
      String videoFileName = DateTime.now().millisecondsSinceEpoch.toString();
      final storageRef =
          FirebaseStorage.instance.ref().child('posts/$videoFileName');

      UploadTask uploadTask = storageRef.putFile(videoFile);
      TaskSnapshot storageSnapshot = await uploadTask;

      String videoUrl = await storageSnapshot.ref.getDownloadURL();

      Post postModel = Post(
        uId: playerModel.uId,
        createdAt: DateTime.now(),
        description: description,
        videoUrl: videoUrl,
        comments: [],
        likes: [],
      );

      await FirebaseFirestore.instance
          .collection('posts')
          .add(postModel.toMap());

      emit(CreatePostSuccessState());
    } catch (error) {
      emit(CreatePostErrorState(error.toString()));
    }
  }

  List<Post> postsList = [];
  void getPosts() {
    emit(GetPostsLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('createdAt', descending: true)
        .get()
        .then((value) {
      for (var element in value.docs) {
        postsList.add(Post.fromMap(element.data()));
      }
      emit(GetPostsSuccessState());
    }).catchError((error) {
      emit(GetPostsErrorState(error.toString()));
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(playerModel.uId)
        .set({
      'like': true,
    }).then((value) {
      emit(LikePostSuccessState());
    }).catchError((error) {
      emit(LikePostErrorState(error.toString()));
    });
  }
}
