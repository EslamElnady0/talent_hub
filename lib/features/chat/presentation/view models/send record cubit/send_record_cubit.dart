import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'dart:developer';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import '../../../data/models/message_model.dart';
import '../../../data/repo/send_message_repo.dart';
part 'send_record_state.dart';

class SendRecordCubit extends Cubit<SendRecordState> {
  SendRecordCubit(this.sendMessageRepo) : super(SendRecordInitial());
  final SendMessageRepo sendMessageRepo;
  AudioRecorder audioRecorder = AudioRecorder();
  bool? flag;
  void startRecording() async {
    try {
      if (await audioRecorder.hasPermission()) {
        emit(SendRecordRecording());
        final Directory appDocDir = await getApplicationDocumentsDirectory();
        final String recFilePath = p.join(
            appDocDir.path, '${DateTime.now().millisecondsSinceEpoch}.m4a');
        await audioRecorder.start(const RecordConfig(), path: recFilePath);
      }
    } catch (e) {
      log("error in recording $e");
      emit(SendRecordFailure(message: e.toString()));
    }
  }

  Future<void> sendRecord(
      {required MessageModel voiceMessage,
      required String receivingUserId}) async {
    emit(SendRecordLoading());
    flag = await sendMessageRepo.sendRecord(
        voiceMessage: voiceMessage,
        audioRecorder: audioRecorder,
        receivingUserId: receivingUserId);
    if (flag!) {
      emit(SendRecordSuccess());
    } else {
      emit(SendRecordFailure(message: "Failed to send message"));
    }
  }

  void stopRecording() async {
    await audioRecorder.cancel();
    emit(SendRecordInitial());
  }

  @override
  Future<void> close() {
    audioRecorder.dispose();
    return super.close();
  }
}
