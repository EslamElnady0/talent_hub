import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/repo/send_message_repo.dart';

part 'send_record_state.dart';

class SendRecordCubit extends Cubit<SendRecordState> {
  SendRecordCubit(this.sendMessageRepo) : super(SendRecordInitial());
  final SendMessageRepo sendMessageRepo;
}
