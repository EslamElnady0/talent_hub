abstract class PostStates {}

class InitialPostState extends PostStates {}

class LoadingPostState extends PostStates {}

class SuccessPostState extends PostStates {}

class FailurePostState extends PostStates {
  final String error;
  FailurePostState({required this.error});
}

class ChangeScrollerPostState extends PostStates {}

