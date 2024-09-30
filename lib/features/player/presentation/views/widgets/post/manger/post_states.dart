abstract class PostsState {}

class CreatePostInitialState extends PostsState {}

class CreatePostLoadingState extends PostsState {}

class CreatePostSuccessState extends PostsState {}

class CreatePostErrorState extends PostsState {
  final String message;

  CreatePostErrorState(this.message);
}

class GetPostsLoadingState extends PostsState {}

class GetPostsSuccessState extends PostsState {}

class GetPostsErrorState extends PostsState {
  final String error;

  GetPostsErrorState(this.error);
}

class LikePostSuccessState extends PostsState {}

class LikePostErrorState extends PostsState {
  final String error;
  LikePostErrorState(this.error);
}
