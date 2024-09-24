import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/repo/send_message_repo.dart';

part 'send_file_state.dart';

class SendFileCubit extends Cubit<SendFileState> {
  SendFileCubit(this.sendMessageRepo) : super(SendFileInitial());
  final SendMessageRepo sendMessageRepo;
}
