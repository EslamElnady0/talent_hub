import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:talent_hub/core/utils/send%20messages%20utils/images_utils.dart';

import '../../../../../core/models/user_model.dart';
import '../../../../../core/utils/send messages utils/send_files_utils.dart';
import '../../../../../core/utils/send messages utils/send_videos_utils.dart';
import '../../../data/models/message_model.dart';
import '../../../data/repo/send_message_repo.dart';

part 'send_file_state.dart';

class SendFileCubit extends Cubit<SendFileState> {
  SendFileCubit(this.sendMessageRepo) : super(SendFileInitial());
  final SendMessageRepo sendMessageRepo;
  String? filePath;
  Uint8List? videoThumbnail;
  bool? flag;
  var fileType = MessageType.text;
  pickImageFromGallery() async {
    filePath = null;
    filePath = await pickImageFromGalleryHelper();
    if (filePath != null) {
      fileType = MessageType.image;
      emit(SendFilePicked());
    }
  }

  pickImageFromCamera() async {
    filePath = null;
    filePath = await pickImageFromCameraHelper();
    if (filePath != null) {
      fileType = MessageType.image;
      emit(SendFilePicked());
    }
  }

  pickFile() async {
    filePath = null;
    filePath = await pickFileHelper();
    if (filePath != null) {
      fileType = MessageType.file;
      emit(SendFilePicked());
    }
  }

  pickVideo() async {
    filePath = null;
    videoThumbnail = null;
    videoThumbnail = await pickVideoFromGallery(videoPath: filePath);
    if (filePath != null) {
      fileType = MessageType.video;
      emit(SendFilePicked());
    }
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
    filePath = null;
    videoThumbnail = null;
  }
}
