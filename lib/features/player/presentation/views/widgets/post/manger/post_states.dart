abstract class PostState {}

class CreatePostInitialState extends PostState {}

class CreatePostLoadingState extends PostState {}

class CreatePostSuccessState extends PostState {}

class CreatePostErrorState extends PostState {
  final String message;

  CreatePostErrorState(this.message);}

class GetPostsLoadingState extends PostState {}

class GetPostsSuccessState extends PostState {}

class GetPostsErrorState extends PostState {
  final String error;

  GetPostsErrorState(this.error);
}
class LikePostSuccessState extends PostState {}
class LikePostErrorState extends PostState
{
  final String error;
  LikePostErrorState(this.error);
}
