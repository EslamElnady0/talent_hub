import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talent_hub/features/player/presentation/model/player_model.dart';
import 'package:talent_hub/features/player/presentation/views/widgets/post/manger/post_states.dart';

import '../model/posts_model.dart';

class PostsCubit extends Cubit<PostState> {
  PostsCubit() : super(CreatePostInitialState());

  static PostsCubit get(context) => BlocProvider.of(context);
  late Player playerModel;

  void createPost({
    required String uId,
    required String description,
    required String postVideo,
  }) {
    emit(CreatePostLoadingState());
    Post postModel = Post(
      playerId: playerModel.uId,
      createdAt: DateTime.now(),
      uId: uId,
      description: description,
      videoUrl: postVideo,
      comments: [],
      likes: [],
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(postModel.toMap())
        .then((value) {
      emit(CreatePostSuccessState());
    }).catchError((error) {
      emit(CreatePostErrorState(error.toString()));
    });
  }
  List<Post> postsList = [];
  void getPosts()
  {
    emit(GetPostsLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('createdAt', descending: true)
        .get()
        .then((value)
    {
      for (var element in value.docs) {
        postsList.add(Post.fromMap(element.data()));
      }
      emit(GetPostsSuccessState());
    })
        .catchError((error){
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
