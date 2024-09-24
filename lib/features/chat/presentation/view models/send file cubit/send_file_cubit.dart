import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:talent_hub/core/utils/send%20messages%20utils/images_utils.dart';

import '../../../../../core/models/user_model.dart';
import '../../../../../core/utils/send messages utils/send_files_utils.dart';
import '../../../data/models/message_model.dart';
import '../../../data/repo/send_message_repo.dart';

part 'send_file_state.dart';

class SendFileCubit extends Cubit<SendFileState> {
  SendFileCubit(this.sendMessageRepo) : super(SendFileInitial());
  final SendMessageRepo sendMessageRepo;
  String? filePath;
  bool? flag;

  pickImageFromGallery() async {
    filePath = await pickImageFromGalleryHelper();
    emit(SendFilePicked());
  }

  pickImageFromCamera() async {
    filePath = await pickImageFromCameraHelper();
    emit(SendFilePicked());
  }

  pickFile() async {
    filePath = await pickFileHelper();
    emit(SendFilePicked());
  }

  Future<void> sendFile({
    required MessageModel fileMessage,
    required UserModel receivingUser,
  }) async {
    emit(SendFileLoading());
    flag = await sendMessageRepo.sendFile(
        fileMessage: fileMessage,
        receivingUser: receivingUser,
        pickedFilePath: filePath);
    if (flag!) {
      emit(SendFileSuccess());
    } else {
      emit(SendFileFailure(message: "Failed to send message"));
    }
  }
}
