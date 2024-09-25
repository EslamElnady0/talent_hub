import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:talent_hub/features/chat/data/repo/get_messages_repo.dart';

part 'get_messages_state.dart';

class GetMessagesCubit extends Cubit<GetMessagesState> {
  GetMessagesCubit(this.getMessagesRepo) : super(GetMessagesInitial());
  final GetMessagesRepo getMessagesRepo;
}
