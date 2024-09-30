import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talent_hub/core/DI/dependency_injection.dart';
import 'package:talent_hub/core/models/post_model.dart';
import 'package:talent_hub/core/models/user_model.dart';
import 'package:talent_hub/features/player/presentation/views/widgets/post/manger/post_states.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit() : super(CreatePostInitialState());

  static PostsCubit get(context) => BlocProvider.of(context);

  Future<void> createPost({
    required String text,
    required File videoFile,
    required UserModel userModel,
  }) async {
    emit(CreatePostLoadingState());

    try {
      String videoFileName = DateTime.now().millisecondsSinceEpoch.toString();
      final storageRef =
          FirebaseStorage.instance.ref().child('posts/$videoFileName');

      UploadTask uploadTask = storageRef.putFile(videoFile);
      TaskSnapshot storageSnapshot = await uploadTask;

      String videoUrl = await storageSnapshot.ref.getDownloadURL();

      PostModel postModel = PostModel(
        uId: getIt.get<FirebaseAuth>().currentUser!.uid,
        name: userModel.name,
        videoUrl: videoUrl,
        text: text,
        imageUrl: userModel.imageUrl,
        postId: DateTime.now().millisecondsSinceEpoch.toString(),
        createdAt: Timestamp.now(),
        likes: [],
      );

      await FirebaseFirestore.instance
          .collection('posts')
          .add(postModel.toJson());
      emit(CreatePostSuccessState());
    } catch (error) {
      emit(CreatePostErrorState(error.toString()));
    }
  }

  List<PostModel> postsList = [];
  void getPosts() {
    emit(GetPostsLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('createdAt', descending: true)
        .get()
        .then((value) {
      for (var element in value.docs) {
        postsList.add(PostModel.fromJson(element.data()));
      }
      emit(GetPostsSuccessState());
    }).catchError((error) {
      emit(GetPostsErrorState(error.toString()));
    });
  }

//   void likePost(String postId) {
//     FirebaseFirestore.instance
//         .collection('posts')
//         .doc(postId)
//         .collection('likes')
//         .doc(userModel.id)
//         .set({
//       'like': true,
//     }).then((value) {
//       emit(LikePostSuccessState());
//     }).catchError((error) {
//       emit(LikePostErrorState(error.toString()));
//     });
//   }
  @override
  void onChange(Change<PostsState> change) {
    log(change.toString());
    super.onChange(change);
  }
}
