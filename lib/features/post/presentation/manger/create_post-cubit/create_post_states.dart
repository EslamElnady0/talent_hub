abstract class CreatePostsState {}

class CreatePostInitialState extends CreatePostsState {}

class CreatePostLoadingState extends CreatePostsState {}

class CreatePostSuccessState extends CreatePostsState {}

class CreatePostErrorState extends CreatePostsState {
  final String message;
  CreatePostErrorState(this.message);
}
