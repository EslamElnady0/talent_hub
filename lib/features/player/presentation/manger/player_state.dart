abstract class PlayerState {}

class GetInfoPlayerInitialState extends PlayerState {}

class GetInfoPlayerLoadingState extends PlayerState {}

class GetInfoPlayerSuccessState extends PlayerState {}

class GetInfoPlayerErrorState extends PlayerState {
  final String message;

  GetInfoPlayerErrorState(this.message);}