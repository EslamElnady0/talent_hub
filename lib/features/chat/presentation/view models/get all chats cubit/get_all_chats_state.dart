part of 'get_all_chats_cubit.dart';

@immutable
sealed class GetAllChatsState {}

final class GetAllChatsInitial extends GetAllChatsState {}

final class GetAllChatsLoading extends GetAllChatsState {}

final class GetAllChatsSuccess extends GetAllChatsState {
  final List<UserModel> users;
  GetAllChatsSuccess({required this.users});
}

final class GetAllChatsFailure extends GetAllChatsState {
  final String message;
  GetAllChatsFailure({required this.message});
}
