import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:talent_hub/features/chat/data/repo/send_message_repo.dart';

part 'send_text_state.dart';

class SendTextCubit extends Cubit<SendTextState> {
  SendTextCubit(this.sendMessageRepo) : super(SendTextInitial());
  final SendMessageRepo sendMessageRepo;
}
