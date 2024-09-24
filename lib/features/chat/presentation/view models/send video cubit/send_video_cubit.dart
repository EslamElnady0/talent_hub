import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/repo/send_message_repo.dart';

part 'send_video_state.dart';

class SendVideoCubit extends Cubit<SendVideoState> {
  SendVideoCubit(this.sendMessageRepo) : super(SendVideoInitial());
  final SendMessageRepo sendMessageRepo;
}
