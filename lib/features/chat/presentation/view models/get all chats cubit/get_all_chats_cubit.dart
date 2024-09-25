import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:talent_hub/features/chat/data/repo/get_all_chats_repo.dart';

import '../../../../../core/models/user_model.dart';

part 'get_all_chats_state.dart';

class GetAllChatsCubit extends Cubit<GetAllChatsState> {
  GetAllChatsCubit(this.getAllChatsRepo) : super(GetAllChatsInitial());
  final GetAllChatsRepo getAllChatsRepo;

  Future<void> getAllChats() async {
    emit(GetAllChatsLoading());
    final result = await getAllChatsRepo.getAllChats();
    result.fold(
      (failure) => emit(GetAllChatsFailure(message: failure.message)),
      (users) => emit(GetAllChatsSuccess(users: users)),
    );
  }
}
