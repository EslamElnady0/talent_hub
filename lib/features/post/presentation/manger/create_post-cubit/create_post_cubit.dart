import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talent_hub/core/DI/dependency_injection.dart';
import 'package:talent_hub/core/models/post_model.dart';
import 'package:talent_hub/core/models/user_model.dart';
import 'package:talent_hub/features/post/presentation/manger/create_post-cubit/create_post_states.dart';
import 'package:talent_hub/features/post/presentation/manger/post_cubit/post_cubit.dart';

class CreatePostsCubit extends Cubit<CreatePostsState> {
  CreatePostsCubit() : super(CreatePostInitialState());

  static CreatePostsCubit get(context) => BlocProvider.of(context);

  Future<void> createPost({
    required String text,
    required File videoFile,
    required UserModel userModel,
    required BuildContext context,
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
          .add(postModel.toJson())
          .then((onValue) {
        onValue.set(
          PostModel(
            uId: getIt.get<FirebaseAuth>().currentUser!.uid,
            name: userModel.name,
            videoUrl: videoUrl,
            text: text,
            imageUrl: userModel.imageUrl,
            postId: onValue.id,
            createdAt: Timestamp.now(),
            likes: [],
          ).toJson(),
        );
      });
      if (context.mounted) {
        context.read<PostCubit>().posts.add(postModel);
        await context.read<PostCubit>().getPosts();
      }
      emit(CreatePostSuccessState());
    } catch (error) {
      emit(CreatePostErrorState(error.toString()));
    }
  }
}
